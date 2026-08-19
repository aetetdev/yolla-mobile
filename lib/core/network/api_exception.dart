import 'package:dio/dio.dart';

/// API hatası.
///
/// Backend hataları RFC 7807 `ProblemDetails` biçiminde döndürür ve bu
/// yanıtlarda başarı zarfı **kullanılmaz**:
///
/// ```json
/// { "status": 404, "title": "Kayıt bulunamadı",
///   "detail": "Şehir bulunamadı: 999", "traceId": "0HN7A2B3C4D5E" }
/// ```
///
/// Doğrulama hatalarında ek olarak alan bazlı `errors` sözlüğü bulunur.
class ApiException implements Exception {
  const ApiException({
    required this.statusCode,
    required this.title,
    this.detail,
    this.traceId,
    this.fieldErrors = const {},
    this.kind = ApiErrorKind.server,
  });

  final int? statusCode;
  final String title;
  final String? detail;

  /// Sunucu günlüğüyle eşleştirmek için. Hata ekranında küçük punto gösterilir;
  /// kullanıcı destek isterse bu kod işe yarar.
  final String? traceId;

  /// Alan adı → hata mesajları. Form ekranlarında alanın altına yazılır.
  final Map<String, List<String>> fieldErrors;

  final ApiErrorKind kind;

  /// Kullanıcıya gösterilecek metin.
  String get message => detail?.isNotEmpty == true ? detail! : title;

  /// Aynı isteği tekrar denemek anlamlı mı?
  bool get isRetryable =>
      kind == ApiErrorKind.network ||
      kind == ApiErrorKind.timeout ||
      kind == ApiErrorKind.rateLimited ||
      (statusCode != null && statusCode! >= 500);

  factory ApiException.fromDio(DioException error) {
    final response = error.response;
    final data = response?.data;

    if (data is Map<String, dynamic>) {
      return ApiException(
        statusCode: response?.statusCode,
        title: data['title'] as String? ?? _titleFor(response?.statusCode),
        detail: data['detail'] as String?,
        traceId: data['traceId'] as String?,
        fieldErrors: _parseFieldErrors(data['errors']),
        kind: _kindFor(error, response?.statusCode),
      );
    }

    return ApiException(
      statusCode: response?.statusCode,
      title: _titleFor(response?.statusCode),
      detail: switch (_kindFor(error, response?.statusCode)) {
        ApiErrorKind.network => 'İnternet bağlantısı kurulamadı.',
        ApiErrorKind.timeout => 'Sunucu zamanında yanıt vermedi.',
        ApiErrorKind.rateLimited => 'Çok fazla istek gönderildi, biraz bekleyin.',
        _ => null,
      },
      kind: _kindFor(error, response?.statusCode),
    );
  }

  static Map<String, List<String>> _parseFieldErrors(Object? raw) {
    if (raw is! Map) return const {};
    return raw.map(
      (key, value) => MapEntry(
        key.toString(),
        value is List
            ? value.map((e) => e.toString()).toList()
            : <String>[value.toString()],
      ),
    );
  }

  static ApiErrorKind _kindFor(DioException error, int? status) {
    if (status == 429) return ApiErrorKind.rateLimited;
    if (status == 401 || status == 403) return ApiErrorKind.unauthorized;
    if (status == 404) return ApiErrorKind.notFound;

    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        ApiErrorKind.timeout,
      DioExceptionType.connectionError => ApiErrorKind.network,
      DioExceptionType.cancel => ApiErrorKind.cancelled,
      _ => ApiErrorKind.server,
    };
  }

  static String _titleFor(int? status) => switch (status) {
    400 => 'İstek doğrulanamadı',
    401 || 403 => 'Yetki gerekiyor',
    404 => 'Kayıt bulunamadı',
    429 => 'Çok fazla istek',
    _ when status != null && status >= 500 => 'Sunucu hatası',
    _ => 'Bir şeyler ters gitti',
  };

  @override
  String toString() =>
      'ApiException($statusCode, $title${detail == null ? '' : ': $detail'})';
}

enum ApiErrorKind {
  network,
  timeout,
  unauthorized,
  notFound,
  rateLimited,
  server,
  cancelled,
}
