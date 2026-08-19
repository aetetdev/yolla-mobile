/// Plan kurallarının istemci tarafındaki karşılığı.
///
/// Sunucu bu kuralları zaten uyguluyor; buradakiler kullanıcıyı hataya
/// koşturmamak için. Değerler ayrıldığı için ikisi ayrışabilir — sunucu
/// tarafı değişirse burası da güncellenmeli.
abstract final class TripRules {
  /// Rota hesaplanabilmesi için gereken en az durak sayısı.
  ///
  /// Tek yer için "en kısa sıra" anlamsız; sunucu da en az iki nokta istiyor.
  static const minStops = 2;
}
