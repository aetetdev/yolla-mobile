import '../models/place_card.dart';
import '../models/place_detail.dart';
import '../models/trip.dart';

/// Bir yerin görseli ve atfı.
///
/// Sunucu aynı görseli üç ayrı DTO'da (kart, yakındaki yer, plan kapağı)
/// biraz farklı alan adlarıyla veriyor. Bu tip aradaki farkı tek yerde
/// kapatıyor ki görsel bileşeni her model için ayrı yazılmasın.
///
/// [attribution] boşsa görsel **gösterilemez**: Commons görsellerinin çoğu
/// CC BY-SA ve fotoğrafçı adı ile lisansı göstermek zorunlu.
class PlaceImage {
  const PlaceImage({
    required this.label,
    this.originalUrl,
    this.thumbUrl,
    this.largeUrl,
    this.attribution,
  });

  PlaceImage.fromCard(PlaceCard card)
    : label = card.name,
      originalUrl = card.photoUrl,
      thumbUrl = card.photoThumbUrl,
      largeUrl = card.photoLargeUrl,
      attribution = card.photoAttribution;

  PlaceImage.fromDetail(PlaceDetail place)
    : label = place.name,
      originalUrl = place.photoUrl,
      thumbUrl = place.photoThumbUrl,
      largeUrl = place.photoLargeUrl,
      attribution = place.photoAttribution;

  PlaceImage.fromNearby(NearbyPlace place)
    : label = place.name,
      originalUrl = place.photoUrl,
      thumbUrl = place.photoThumbUrl,
      largeUrl = null,
      attribution = place.photoAttribution;

  PlaceImage.fromTrip(TripSummary trip)
    : label = trip.name,
      originalUrl = trip.coverPhotoUrl,
      thumbUrl = trip.coverPhotoThumbUrl,
      largeUrl = null,
      attribution = trip.coverPhotoAttribution;

  /// Görsel yüklenemezse gösterilecek metin (yer ya da plan adı).
  final String label;

  final String? originalUrl;
  final String? thumbUrl;
  final String? largeUrl;
  final String? attribution;

  /// Gösterilebilir mi? Adres **ve** atıf birlikte gerekli.
  bool get canDisplay =>
      (originalUrl?.isNotEmpty ?? false) && (attribution?.isNotEmpty ?? false);
}
