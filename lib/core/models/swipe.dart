import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'swipe.freezed.dart';
part 'swipe.g.dart';

/// Tek bir kaydırma kaydı.
///
/// Çevrimdışıyken yerelde biriktirilip bağlantı gelince toplu gönderilir;
/// bu yüzden [swipedAt] istemci tarafında tutulur (sunucuya gönderilmez).
@freezed
abstract class SwipeRecord with _$SwipeRecord {
  const factory SwipeRecord({
    required int placeId,
    required SwipeDirection direction,
    required SwipeContext context,
    @JsonKey(includeToJson: false) DateTime? swipedAt,
  }) = _SwipeRecord;

  factory SwipeRecord.fromJson(Map<String, dynamic> json) =>
      _$SwipeRecordFromJson(json);
}

/// `POST /discovery/swipes` yanıtı.
@freezed
abstract class SwipeResult with _$SwipeResult {
  const factory SwipeResult({
    required int recorded,
    required int totalLiked,
  }) = _SwipeResult;

  factory SwipeResult.fromJson(Map<String, dynamic> json) =>
      _$SwipeResultFromJson(json);
}

/// `DELETE /discovery/swipes/{placeId}` yanıtı.
@freezed
abstract class SwipeUndoResult with _$SwipeUndoResult {
  const factory SwipeUndoResult({
    /// Silinecek bir kayıt bulundu mu? Bulunmaması hata değil.
    required bool removed,
    required int totalLiked,
  }) = _SwipeUndoResult;

  factory SwipeUndoResult.fromJson(Map<String, dynamic> json) =>
      _$SwipeUndoResultFromJson(json);
}
