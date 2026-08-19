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
  static String likedFor(int? cityId) =>
      cityId == null ? liked : '$liked?sehir=$cityId';
  static String tripFor(int tripId) => '/planlarim/$tripId';
  static String placeFor(int placeId) => '/yer/$placeId';
}
