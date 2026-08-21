import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../app/env.dart';
import 'api_envelope.dart';
import 'api_exception.dart';

/// Jetonu sağlayan taraf. Oturum katmanı bunu uygular; ağ katmanı oturumun
/// nasıl kurulduğunu bilmez.
abstract interface class SessionTokenSource {
  /// Elde tutulan geçerli jeton (yoksa null).
  Future<String?> currentToken();

  /// Jeton reddedildiğinde yeni bir oturum açar. Yeni jetonu döndürür.
  Future<String?> renewSession();
}

/// Yolla API istemcisi.
///
/// Sorumlulukları: zarf açma, atıf toplama, jeton ekleme, geçici hatalarda
/// tekrar deneme ve `DioException` → [ApiException] çevirisi. Uçların kendisi
/// özellik katmanındaki servislerde tanımlanır.
class ApiClient {
  ApiClient({
    required AttributionRegistry attributions,
    Dio? dio,
    // Alan özel olduğu için adlandırılmış parametrede `this._x` yazılamıyor.
    // ignore: prefer_initializing_formals
  }) : _attributions = attributions,
       _dio =
           dio ??
           Dio(
             BaseOptions(
               baseUrl: Env.apiBaseUrl,
               connectTimeout: Env.connectTimeout,
               receiveTimeout: Env.receiveTimeout,
               contentType: Headers.jsonContentType,
               headers: const {'Accept': 'application/json'},
               // Hata gövdesini kendimiz okuyacağız; dio 4xx'i de bize versin.
               validateStatus: (status) => status != null && status < 400,
             ),
           ) {
    _dio.interceptors.add(_AuthInterceptor(this));
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: false),
      );
    }
  }

  final Dio _dio;
  final AttributionRegistry _attributions;

  /// Oturum katmanı kurulduğunda kendini buraya bağlar.
  SessionTokenSource? _tokenSource;

  /// `Accept-Language` başlığında gönderilecek dil.
  ///
  /// Cihazın dili; uygulama TR/EN destekliyor, desteklenmeyen dilde Türkçeye
  /// düşülüyor.
  String get language {
    final code = PlatformDispatcher.instance.locale.languageCode;
    return code == 'en' ? 'en' : 'tr';
  }

  /// İlk `devices/register` çağrısı jetonsuz yapıldığı ve oturum katmanı bu
  /// istemciye ihtiyaç duyduğu için bağ kurulumdan sonra kuruluyor.
  set tokenSource(SessionTokenSource value) => _tokenSource = value;

  Future<ApiEnvelope<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    required T Function(Object? json) decode,
    CancelToken? cancelToken,
  }) => _send(
    path,
    method: 'GET',
    query: query,
    decode: decode,
    cancelToken: cancelToken,
  );

  Future<ApiEnvelope<T>> post<T>(
    String path, {
    Object? body,
    Map<String, dynamic>? query,
    required T Function(Object? json) decode,
    CancelToken? cancelToken,
  }) => _send(
    path,
    method: 'POST',
    body: body,
    query: query,
    decode: decode,
    cancelToken: cancelToken,
  );

  /// Yerine koyma. Gövdesiz yanıt veren uçlarda `decode: (_) {}` verilir.
  Future<ApiEnvelope<T>> put<T>(
    String path, {
    Object? body,
    required T Function(Object? json) decode,
  }) => _send(path, method: 'PUT', body: body, decode: decode);

  Future<ApiEnvelope<T>> patch<T>(
    String path, {
    Object? body,
    required T Function(Object? json) decode,
  }) => _send(path, method: 'PATCH', body: body, decode: decode);

  /// Silme. Gövdesiz uçlarda `decode: (_) {}` verilir.
  Future<ApiEnvelope<T>> delete<T>(
    String path, {
    required T Function(Object? json) decode,
  }) => _send(path, method: 'DELETE', decode: decode);

  Future<ApiEnvelope<T>> _send<T>(
    String path, {
    required String method,
    required T Function(Object? json) decode,
    Object? body,
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
    int attempt = 0,
  }) async {
    try {
      final response = await _dio.request<dynamic>(
        path,
        data: body,
        queryParameters: query,
        cancelToken: cancelToken,
        options: Options(method: method),
      );

      final payload = response.data;

      // 204 ve boş gövdeli yanıtlar zarf taşımaz.
      if (payload is! Map<String, dynamic>) {
        return ApiEnvelope(data: decode(payload));
      }

      final attributions =
          (payload['attributions'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          const <String>[];
      _attributions.record(attributions);

      return ApiEnvelope(
        // Zarfsız yanıt gelirse (ör. sağlık ucu) gövdenin kendisini çöz.
        data: decode(payload.containsKey('data') ? payload['data'] : payload),
        attributions: attributions,
      );
    } on DioException catch (error) {
      final failure = ApiException.fromDio(error);

      if (failure.isRetryable && attempt < _maxRetries) {
        await Future<void>.delayed(_backoff(attempt, error.response));
        return _send(
          path,
          method: method,
          decode: decode,
          body: body,
          query: query,
          cancelToken: cancelToken,
          attempt: attempt + 1,
        );
      }

      throw failure;
    }
  }

  static const _maxRetries = 2;

  /// Üstel geri çekilme. Hız sınırında sunucu `Retry-After` verirse ona uyulur —
  /// backend dakikada 120 istek (rota uçlarında 20) sınırı uyguluyor.
  Duration _backoff(int attempt, Response<dynamic>? response) {
    final retryAfter = response?.headers.value('retry-after');
    final seconds = int.tryParse(retryAfter ?? '');
    if (seconds != null) return Duration(seconds: seconds.clamp(1, 30));
    return Duration(milliseconds: 400 * (1 << attempt));
  }
}

/// Jetonu başlığa ekler; 401 gelirse oturumu bir kez yenileyip isteği tekrarlar.
class _AuthInterceptor extends Interceptor {
  _AuthInterceptor(this._client);

  final ApiClient _client;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Cihaz kaydı jetonun kendisini üreten uç; jetonsuz gider.
    if (!options.path.contains('devices/register')) {
      final token = await _client._tokenSource?.currentToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    // Sunucu içeriği dile göre döndürebiliyor (`place_translations`).
    options.headers['Accept-Language'] ??= _client.language;

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final isUnauthorized = err.response?.statusCode == 401;
    final alreadyRetried = err.requestOptions.extra['yolla_retried'] == true;
    final source = _client._tokenSource;

    if (!isUnauthorized || alreadyRetried || source == null) {
      return handler.next(err);
    }

    // Jeton 90 gün geçerli; süresi dolduğunda çözüm aynı UUID ile yeniden
    // kayıt olmak — sunucu yeni kayıt açmaz, oturumu tazeler.
    final token = await source.renewSession();
    if (token == null) return handler.next(err);

    final options = err.requestOptions
      ..headers['Authorization'] = 'Bearer $token'
      ..extra['yolla_retried'] = true;

    try {
      final response = await _client._dio.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }
}
