/// Rota adresleri tek yerde tutulur — web istemcisiyle aynı ağacı paylaşacak.
abstract final class Routes {
  /// Karşılama: giriş ve kayıt. Oturumu olmayan herkes buraya düşer.
  static const auth = '/giris';

  /// Sekme kökleri.
  static const discover = '/kesfet';
  static const trips = '/planlarim';
  static const profile = '/profil';

  /// Sekme içi ekranlar.
  ///
  /// Keşfetin kökü artık harita; mod seçimi haritadaki "Gir" düğmesinin
  /// arkasına taşındı.
  static const modePicker = '/kesfet/mod';
  static const cityPicker = '/kesfet/sehir';
  static const deck = '/kesfet/sehir/:cityId';
  static const corridor = '/kesfet/rota';
  static const trip = '/planlarim/:tripId';

  /// Sekmelerin üstüne açılan ekranlar.
  static const liked = '/begendiklerim';
  static const place = '/yer/:placeId';
  static const attributions = '/atiflar';

  /// Coin bakiyesi, premium avantajları ve premium alma.
  static const premium = '/premium';

  static String deckFor(int cityId) => '/kesfet/sehir/$cityId';

  /// Beğenilenler ekranının adresi.
  ///
  /// [preselect] verilirse ekran yalnızca o yerleri işaretli açar. Haritadan
  /// gelinirken kullanılıyor: kullanıcı haritada üç yer beğendiyse plana o üçü
  /// girmeli, aylar önce beğendikleri değil. Eski beğeniler listede duruyor,
  /// yalnızca işaretsizler.
  static String likedFor(int? cityId, {Iterable<int>? preselect}) {
    final query = [
      if (cityId != null) 'sehir=$cityId',
      if (preselect != null && preselect.isNotEmpty)
        'secili=${preselect.join(',')}',
    ];

    return query.isEmpty ? liked : '$liked?${query.join('&')}';
  }

  /// [likedFor]'un `secili` parametresini çözer.
  ///
  /// Biçim burada, adresi kuran koda bitişik duruyor ki ikisi ayrışmasın.
  /// Bozuk ya da boş değer null döner: ekran o zaman hepsini seçili açar.
  static Set<int>? preselectOf(String? raw) {
    if (raw == null || raw.isEmpty) return null;

    final ids = raw.split(',').map(int.tryParse).nonNulls.toSet();
    return ids.isEmpty ? null : ids;
  }

  static String tripFor(int tripId) => '/planlarim/$tripId';
  static String placeFor(int placeId) => '/yer/$placeId';
}
