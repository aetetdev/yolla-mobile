import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/enums.dart';
import '../../core/models/place_card.dart';
import '../../core/models/swipe.dart';
import '../../core/network/api_exception.dart';
import '../../core/providers.dart';
import 'deck_source.dart';
import 'discovery_service.dart';
import 'routes_service.dart';

/// Deste ekranının durumu.
@immutable
class DeckState {
  const DeckState({
    this.source,
    this.cards = const [],
    this.likedIds = const {},
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isExhausted = false,
    this.error,
    this.pendingSwipes = 0,
  });

  /// Kartların geldiği kaynak — şehir destesi ya da yol koridoru.
  final DeckSource? source;

  /// Kalan kartlar. `cards.first` en üstteki karttır.
  final List<PlaceCard> cards;

  /// **Bu oturumda** beğenilen yerler.
  ///
  /// Sayı değil küme tutuluyor: deste bitince kurulan plana yalnızca bunlar
  /// giriyor. Eskiden yalnızca sayı vardı ve kaydırmalar sunucuya gidince
  /// sunucunun *ömür boyu* toplamıyla eziliyordu; Bursa destesini bitiren
  /// kullanıcı aylar önce beğendiği Antalya'yı da içeren bir plan alıyordu.
  final Set<int> likedIds;

  /// Bu oturumda beğenilen yer sayısı.
  int get likedCount => likedIds.length;

  final bool isLoading;
  final bool isLoadingMore;

  /// Sunucuda başka kart kalmadı.
  final bool isExhausted;

  final ApiException? error;

  /// Henüz sunucuya gönderilmemiş kaydırma sayısı.
  final int pendingSwipes;

  PlaceCard? get top => cards.isEmpty ? null : cards.first;
  PlaceCard? get next => cards.length < 2 ? null : cards[1];

  /// Deste tükendi ve elde kart kalmadı.
  bool get isFinished => cards.isEmpty && isExhausted && !isLoading;

  /// Şehirde hiç içerik yoktu — "bitirdin" değil, "hiç yoktu".
  bool get isEmptyCity => isFinished && likedCount == 0 && _seenNothing;
  bool get _seenNothing => pendingSwipes == 0;

  DeckState copyWith({
    DeckSource? source,
    List<PlaceCard>? cards,
    Set<int>? likedIds,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isExhausted,
    ApiException? error,
    bool clearError = false,
    int? pendingSwipes,
  }) => DeckState(
    source: source ?? this.source,
    cards: cards ?? this.cards,
    likedIds: likedIds ?? this.likedIds,
    isLoading: isLoading ?? this.isLoading,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    isExhausted: isExhausted ?? this.isExhausted,
    error: clearError ? null : (error ?? this.error),
    pendingSwipes: pendingSwipes ?? this.pendingSwipes,
  );
}

/// Kart destesini yönetir: sayfalama, kaydırma kuyruğu, geri alma.
///
/// Kaydırmalar anında gönderilmez. Kullanıcı saniyede birkaç kart
/// kaydırabiliyor ve her biri için istek atmak hem hız sınırını
/// (dakikada 120) yakar hem de metroda/çevrimdışıyken kaybolur. Bunun yerine
/// yerelde biriktirilip [_flushThreshold] kadar birikince ya da [_flushDelay]
/// kadar duraklayınca toplu gönderilir.
class DeckController extends Notifier<DeckState> {
  static const _pageSize = 20;

  /// Kuyrukta bu kadar kart kalınca sonraki sayfa çekilir. Kullanıcı boş
  /// ekran görmemeli.
  static const _prefetchThreshold = 5;

  static const _flushThreshold = 10;
  static const _flushDelay = Duration(seconds: 4);

  final _pending = <SwipeRecord>[];
  Timer? _flushTimer;

  String? _cursor;
  bool _hasMore = true;

  /// Geri alma için: gönderilmemiş son kaydırma ve kartı.
  (PlaceCard, SwipeRecord)? _lastSwipe;

  /// Servis `build` sırasında yakalanır.
  ///
  /// `onDispose` içinde `ref.read` çağrılamaz — sağlayıcı zaten yıkılıyor
  /// olduğu için istisna fırlar ve ekrandan çıkarken biriken kaydırmalar
  /// gönderilmeden kaybolurdu.
  late DiscoveryService _discovery;
  late RoutesService _routes;

  @override
  DeckState build() {
    _discovery = ref.watch(discoveryServiceProvider);
    _routes = ref.watch(routesServiceProvider);

    ref.onDispose(() {
      _flushTimer?.cancel();
      // Ekrandan çıkarken elde kalan kaydırmalar kaybolmasın.
      unawaited(_flush());
    });
    return const DeckState();
  }

  /// Desteyi verilen kaynakla baştan kurar.
  Future<void> open(DeckSource source) async {
    await _flush();

    _cursor = null;
    _hasMore = true;
    _lastSwipe = null;
    state = DeckState(source: source, isLoading: true);

    await _loadPage();
  }

  Future<void> retry() async {
    if (state.source == null) return;
    state = state.copyWith(clearError: true, isLoading: state.cards.isEmpty);
    await _loadPage();
  }

  /// Üstteki kartı kaydırır.
  void swipe(SwipeDirection direction) {
    final card = state.top;
    if (card == null) return;

    final record = SwipeRecord(
      placeId: card.id,
      direction: direction,
      context: state.source?.swipeContext ?? SwipeContext.city,
      swipedAt: DateTime.now(),
    );

    _pending.add(record);
    _lastSwipe = (card, record);

    state = state.copyWith(
      cards: state.cards.sublist(1),
      likedIds: direction == SwipeDirection.like
          ? {...state.likedIds, card.id}
          : state.likedIds,
      pendingSwipes: _pending.length,
    );

    _scheduleFlush();

    if (state.cards.length <= _prefetchThreshold && _hasMore) {
      unawaited(_loadPage());
    }
  }

  /// Son kaydırmayı geri alır.
  ///
  /// İki durum var:
  /// * Kaydırma henüz kuyrukta — kayıt kuyruktan çıkarılır, sunucuya hiç
  ///   gitmez.
  /// * Kaydırma gönderilmiş — sunucudaki kayıt `DELETE` ile silinir, yer
  ///   destede yeniden görünebilir hale gelir.
  ///
  /// Her iki durumda da kart desteye geri konur; kullanıcı açısından fark yok.
  Future<bool> undo() async {
    final last = _lastSwipe;
    if (last == null) return false;

    final (card, record) = last;
    _lastSwipe = null;

    final wasPending = _pending.remove(record);

    state = state.copyWith(
      cards: [card, ...state.cards],
      likedIds: record.direction == SwipeDirection.like
          ? ({...state.likedIds}..remove(card.id))
          : state.likedIds,
      pendingSwipes: _pending.length,
      isExhausted: false,
    );

    if (wasPending) return true;

    // Gönderilmiş kaydırma: sunucudaki kaydı sil.
    try {
      await _discovery.undoSwipe(card.id);
      return true;
    } on ApiException catch (error) {
      debugPrint('Kaydırma geri alınamadı: $error');
      // Kart ekranda kaldı ama sunucu hâlâ onu kaydırılmış sayıyor. Kullanıcıya
      // yalan söylememek için başarısız bildiriliyor.
      return false;
    }
  }

  bool get canUndo => _lastSwipe != null;

  Future<void> _loadPage() async {
    final source = state.source;
    if (source == null || state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true, clearError: true);

    try {
      await ref.read(sessionProvider.future);

      final page = await source.load(
        discovery: _discovery,
        routes: _routes,
        cursor: _cursor,
        take: _pageSize,
      );

      _cursor = page.nextCursor;
      _hasMore = page.hasMore;

      // Sunucu kaydırılanları eliyor ama sayfa sınırında aynı kartın iki kez
      // gelmesi mümkün; kuyrukta yinelenen kart kullanıcıya tuhaf görünür.
      final known = state.cards.map((c) => c.id).toSet();
      final fresh = page.items.where((c) => known.add(c.id));

      state = state.copyWith(
        cards: [...state.cards, ...fresh],
        isLoading: false,
        isLoadingMore: false,
        isExhausted: !page.hasMore,
      );
    } on ApiException catch (error) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        error: error,
      );
    }
  }

  void _scheduleFlush() {
    if (_pending.length >= _flushThreshold) {
      unawaited(_flush());
      return;
    }
    _flushTimer?.cancel();
    _flushTimer = Timer(_flushDelay, () => unawaited(_flush()));
  }

  /// Biriken kaydırmaları gönderir.
  ///
  /// Başarısız olursa kayıtlar kuyrukta kalır ve bir sonraki denemede tekrar
  /// gönderilir — kullanıcının kaydırması kaybolmaz.
  Future<void> _flush() async {
    _flushTimer?.cancel();
    if (_pending.isEmpty) return;

    final batch = _pending
        .take(DiscoveryService.maxSwipesPerRequest)
        .toList(growable: false);

    try {
      await _discovery.recordSwipes(batch);

      _pending.removeRange(0, batch.length);

      if (ref.mounted) {
        // Sunucunun döndürdüğü `totalLiked` bilinçli olarak kullanılmıyor:
        // o, kullanıcının şimdiye kadarki **bütün** beğenilerinin sayısı.
        // Buraya yazıldığında deste ekranındaki sayaç oturumu değil ömrü
        // gösteriyor ve bu destede kurulacak plan da öyle davranıyordu.
        state = state.copyWith(pendingSwipes: _pending.length);
      }
    } on ApiException catch (error) {
      debugPrint('Kaydırmalar gönderilemedi, kuyrukta bekliyor: $error');
    }
  }

  /// Uygulama arka plana alınırken ya da ekrandan çıkılırken çağrılır.
  Future<void> flushNow() => _flush();
}

final deckControllerProvider = NotifierProvider<DeckController, DeckState>(
  DeckController.new,
);
