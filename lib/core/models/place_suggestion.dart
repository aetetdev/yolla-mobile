import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_suggestion.freezed.dart';
part 'place_suggestion.g.dart';

/// Öneri kurulurken seçilebilecek kategori.
@freezed
abstract class SuggestionCategory with _$SuggestionCategory {
  const factory SuggestionCategory({
    /// İstekte gönderilen anahtar ("museum", "viewpoint").
    required String key,
    required String name,
    String? icon,
  }) = _SuggestionCategory;

  factory SuggestionCategory.fromJson(Map<String, dynamic> json) =>
      _$SuggestionCategoryFromJson(json);
}

/// Kullanıcının önerdiği yer.
///
/// Öneri kataloğa doğrudan girmiyor: onaylanana kadar [status] `Pending`
/// kalıyor, onaylanınca [placeId] doluyor ve coin yazılıyor.
@freezed
abstract class PlaceSuggestion with _$PlaceSuggestion {
  const factory PlaceSuggestion({
    required int id,
    required String name,
    required String categoryName,
    required String cityName,
    required double latitude,
    required double longitude,
    String? description,

    /// "Pending" · "Approved" · "Rejected"
    required String status,
    String? rejectionReason,

    /// Onaylandıysa kataloğa giren yerin kimliği.
    int? placeId,
    int? coinsAwarded,
    required DateTime createdAt,
    DateTime? reviewedAt,
  }) = _PlaceSuggestion;

  const PlaceSuggestion._();

  factory PlaceSuggestion.fromJson(Map<String, dynamic> json) =>
      _$PlaceSuggestionFromJson(json);

  bool get isPending => status == 'Pending';
  bool get isApproved => status == 'Approved';
  bool get isRejected => status == 'Rejected';
}
