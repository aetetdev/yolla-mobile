import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yolla/core/models/city.dart';
import 'package:yolla/core/models/device_session.dart';
import 'package:yolla/core/models/enums.dart';
import 'package:yolla/core/models/feed_page.dart';
import 'package:yolla/core/models/place_card.dart';
import 'package:yolla/core/models/swipe.dart';
import 'package:yolla/core/providers.dart';
import 'package:yolla/features/discovery/deck_controller.dart';
import 'package:yolla/features/discovery/deck_source.dart';
import 'package:yolla/features/discovery/discovery_service.dart';

/// Sunucu yerine geçen sahte servis: hangi çağrının yapıldığını kaydeder.
class _FakeDiscovery implements DiscoveryService {
  _FakeDiscovery({required this.pages, int existingLikes = 0})
    : _totalLiked = existingLikes;

  /// Sırayla dönülecek sayfalar.
  final List<FeedPage> pages;

  final requestedCursors = <String?>[];
  final sentBatches = <List<SwipeRecord>>[];

  int _pageIndex = 0;

  /// Kullanıcının **şimdiye kadarki** beğeni sayısı — bu desteninki değil.
  int _totalLiked;

  @override
  Future<FeedPage> cityFeed({
    required int cityId,
    String? cursor,
    int take = 20,
    List<String> categories = const [],
  }) async {
    requestedCursors.add(cursor);
    if (_pageIndex >= pages.length) {
      return const FeedPage(hasMore: false);
    }
    return pages[_pageIndex++];
  }

  /// Sunucuya gitmis kaydirmalarin geri alinmasi.
  final undone = <int>[];

  @override
  Future<SwipeUndoResult> undoSwipe(int placeId) async {
    undone.add(placeId);
    if (_totalLiked > 0) _totalLiked--;
    return SwipeUndoResult(removed: true, totalLiked: _totalLiked);
  }

  @override
  Future<SwipeResult> recordSwipes(List<SwipeRecord> swipes) async {
    sentBatches.add(List.of(swipes));
    _totalLiked += swipes
        .where((s) => s.direction == SwipeDirection.like)
        .length;
    return SwipeResult(recorded: swipes.length, totalLiked: _totalLiked);
  }
}

PlaceCard _card(int id) => PlaceCard(
  id: id,
  name: 'Yer $id',
  slug: 'yer-$id',
  categoryKey: 'museum',
  categoryName: 'Müze',
  photoUrl: 'https://upload.wikimedia.org/wikipedia/commons/f/f0/A$id.jpg',
  photoAttribution: 'Fotoğraf: Biri (CC BY-SA 3.0)',
  latitude: 41,
  longitude: 29,
  qualityScore: 80,
);

const _city = City(id: 106, name: 'Nevşehir', slug: 'nevsehir');

ProviderContainer _container(_FakeDiscovery fake) {
  final container = ProviderContainer(
    overrides: [
      discoveryServiceProvider.overrideWithValue(fake),
      sessionProvider.overrideWith(
        (ref) async => DeviceSession(
          deviceId: 1,
          accessToken: 'test',
          expiresAt: DateTime.now().add(const Duration(days: 90)),
        ),
      ),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('DeckController', () {
    test('ilk sayfayı yükler ve üstteki kartı verir', () async {
      final fake = _FakeDiscovery(
        pages: [
          FeedPage(
            items: [_card(1), _card(2)],
            nextCursor: 'c1',
            hasMore: true,
          ),
        ],
      );
      final container = _container(fake);
      final notifier = container.read(deckControllerProvider.notifier);

      await notifier.open(const CityDeckSource(_city));

      final state = container.read(deckControllerProvider);
      expect(state.cards, hasLength(2));
      expect(state.top?.id, 1);
      expect(state.next?.id, 2);
      expect(fake.requestedCursors, [null]);
    });

    test('kaydırma kartı destenin üstünden alır', () async {
      final fake = _FakeDiscovery(
        pages: [
          FeedPage(items: [_card(1), _card(2)], hasMore: false),
        ],
      );
      final container = _container(fake);
      final notifier = container.read(deckControllerProvider.notifier);
      await notifier.open(const CityDeckSource(_city));

      notifier.swipe(SwipeDirection.like);

      final state = container.read(deckControllerProvider);
      expect(state.top?.id, 2);
      expect(state.likedCount, 1);
      // Tek kaydırma eşiğin altında: henüz gönderilmemeli.
      expect(fake.sentBatches, isEmpty);
      expect(state.pendingSwipes, 1);
    });

    test('beğeniler oturuma ait: eski beğeniler sayılmaz', () async {
      // Kullanıcı daha önce 40 yer beğenmiş (mesela Antalya gezisinde).
      // Bu destede beğendiği tek yer, kurulacak planın tek adayı olmalı.
      final fake = _FakeDiscovery(
        pages: [
          FeedPage(
            items: [for (var i = 1; i <= 12; i++) _card(i)],
            hasMore: false,
          ),
        ],
        existingLikes: 40,
      );
      final container = _container(fake);
      final notifier = container.read(deckControllerProvider.notifier);
      await notifier.open(const CityDeckSource(_city));

      notifier.swipe(SwipeDirection.like);

      // Kaydırma sunucuya gidiyor ve sunucu "toplam 41 beğeni" diyor.
      // Eskiden bu sayı sayacın üstüne yazılıyordu.
      await notifier.flushNow();

      final state = container.read(deckControllerProvider);
      expect(
        state.likedIds,
        {1},
        reason: 'plana yalnızca bu destede beğenilen girmeli',
      );
      expect(
        state.likedCount,
        1,
        reason: 'sunucunun ömür boyu toplamı sayacı ezmemeli',
      );
    });

    test('eşiğe ulaşınca kaydırmaları toplu gönderir', () async {
      final fake = _FakeDiscovery(
        pages: [
          FeedPage(
            items: [for (var i = 1; i <= 12; i++) _card(i)],
            hasMore: false,
          ),
        ],
      );
      final container = _container(fake);
      final notifier = container.read(deckControllerProvider.notifier);
      await notifier.open(const CityDeckSource(_city));

      for (var i = 0; i < 10; i++) {
        notifier.swipe(SwipeDirection.pass);
      }
      await Future<void>.delayed(Duration.zero);

      expect(fake.sentBatches, hasLength(1));
      expect(fake.sentBatches.single, hasLength(10));
      expect(container.read(deckControllerProvider).pendingSwipes, 0);
    });

    test('gönderilmemiş kaydırma geri alınabilir', () async {
      final fake = _FakeDiscovery(
        pages: [
          FeedPage(items: [_card(1), _card(2)], hasMore: false),
        ],
      );
      final container = _container(fake);
      final notifier = container.read(deckControllerProvider.notifier);
      await notifier.open(const CityDeckSource(_city));

      notifier.swipe(SwipeDirection.like);
      expect(notifier.canUndo, isTrue);

      expect(await notifier.undo(), isTrue);

      final state = container.read(deckControllerProvider);
      expect(state.top?.id, 1, reason: 'kart desteye geri konmalı');
      expect(state.likedCount, 0, reason: 'beğeni sayacı geri alınmalı');
      expect(state.pendingSwipes, 0);
      expect(
        fake.undone,
        isEmpty,
        reason: 'kuyruktaki kaydırma için sunucuya gidilmemeli',
      );
    });

    test('gönderilmiş kaydırma sunucudan silinerek geri alınır', () async {
      final fake = _FakeDiscovery(
        pages: [
          FeedPage(
            items: [for (var i = 1; i <= 12; i++) _card(i)],
            hasMore: false,
          ),
        ],
      );
      final container = _container(fake);
      final notifier = container.read(deckControllerProvider.notifier);
      await notifier.open(const CityDeckSource(_city));

      for (var i = 0; i < 10; i++) {
        notifier.swipe(SwipeDirection.like);
      }
      await Future<void>.delayed(Duration.zero);

      expect(await notifier.undo(), isTrue);

      final state = container.read(deckControllerProvider);
      expect(state.top?.id, 10, reason: 'son kaydırılan kart geri gelmeli');
      expect(
        fake.undone,
        [10],
        reason: 'gönderilmiş kaydırma için sunucudaki kayıt silinmeli',
      );
    });

    test('deste azalınca sonraki sayfayı imleçle çeker', () async {
      final fake = _FakeDiscovery(
        pages: [
          FeedPage(
            items: [for (var i = 1; i <= 6; i++) _card(i)],
            nextCursor: 'sayfa2',
            hasMore: true,
          ),
          FeedPage(
            items: [for (var i = 7; i <= 12; i++) _card(i)],
            hasMore: false,
          ),
        ],
      );
      final container = _container(fake);
      final notifier = container.read(deckControllerProvider.notifier);
      await notifier.open(const CityDeckSource(_city));

      // 6 karttan biri gidince kalan 5 → eşik.
      notifier.swipe(SwipeDirection.pass);
      await Future<void>.delayed(Duration.zero);

      expect(fake.requestedCursors, [null, 'sayfa2']);
      expect(container.read(deckControllerProvider).cards, hasLength(11));
    });

    test('sayfa sınırında yinelenen kartı desteye koymaz', () async {
      final fake = _FakeDiscovery(
        pages: [
          FeedPage(
            items: [for (var i = 1; i <= 6; i++) _card(i)],
            nextCursor: 'sayfa2',
            hasMore: true,
          ),
          // 5 ve 6 tekrar geliyor.
          FeedPage(items: [_card(5), _card(6), _card(7)], hasMore: false),
        ],
      );
      final container = _container(fake);
      final notifier = container.read(deckControllerProvider.notifier);
      await notifier.open(const CityDeckSource(_city));

      notifier.swipe(SwipeDirection.pass);
      await Future<void>.delayed(Duration.zero);

      final ids = container
          .read(deckControllerProvider)
          .cards
          .map((c) => c.id)
          .toList();
      expect(ids, [2, 3, 4, 5, 6, 7]);
    });

    test('deste bitince bitmiş sayılır', () async {
      final fake = _FakeDiscovery(
        pages: [
          FeedPage(items: [_card(1)], hasMore: false),
        ],
      );
      final container = _container(fake);
      final notifier = container.read(deckControllerProvider.notifier);
      await notifier.open(const CityDeckSource(_city));

      notifier.swipe(SwipeDirection.like);

      final state = container.read(deckControllerProvider);
      expect(state.isFinished, isTrue);
      expect(state.top, isNull);
    });
  });
}
