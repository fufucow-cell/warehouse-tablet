import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/error_map_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_api_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/api_mock_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:get/get.dart' hide Response;

class _RequestCache {
  final CancelToken cancelToken;
  final DateTime timestamp;

  _RequestCache({
    required this.cancelToken,
    required this.timestamp,
  });
}

class ApiUtil extends GetxService {
  // Properties

  static const String _tagName = 'warehouse';
  final Dio _dio;
  static ApiUtil get instance => Get.find<ApiUtil>(tag: _tagName);
  static String get getDomain => instance._dio.options.baseUrl;

  // Cache properties
  static final Map<String, _RequestCache> _requestCache = {};
  static final Map<String, dynamic> _responseCache = {};
  static Timer? _cacheCleanupTimer;
  static const int _cacheExpirationSeconds = 5;
  static const String _cacheKeyExtra = 'cache_key';

  // Init

  ApiUtil._internal(String url) : _dio = Dio(BaseOptions(baseUrl: url)) {
    _dio.interceptors.add(ApiMockUtil.createInterceptor());
    _dio.interceptors.add(_apiRequestInterceptor());
    _dio.interceptors.add(_apiResponseInterceptor());
    _startCacheCleanupTimer();
  }

  static ApiUtil register(String baseUrl) {
    if (Get.isRegistered<ApiUtil>(tag: _tagName)) {
      return instance;
    }
    final ApiUtil service = ApiUtil._internal(baseUrl);
    Get.put<ApiUtil>(
      service,
      tag: _tagName,
      permanent: true,
    );
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<ApiUtil>(tag: _tagName)) {
      Get.delete<ApiUtil>(
        tag: _tagName,
      ); // 自動觸發該實例的 onClose() 方法
    }
  }

  @override
  void onClose() {
    _stopCacheCleanupTimer();
    _clearAllCache();
    _dio.close(force: true);
    super.onClose();
  }

  // MARK: - Public Method

  void updateDomain(String domain) {
    _dio.options.baseUrl = domain;
  }

  static Future<T?> sendRequest<T>(
    EnumApiInfo apiInfo, {
    dynamic requestModel,
    T Function(Map<String, dynamic> json)? fromJson,
    void Function(BaseApiResponseModel<void> error)? onError,
  }) async {
    try {
      final dio = instance._dio;
      final isGet = apiInfo.method == EnumApiMethod.get;
      final reqData = _convertRequestModelToJson(requestModel);
      final options = Options(
        method: apiInfo.method.value,
        extra: {
          BaseApiResponseModel.name: _isBaseApiResponseModelType<T>(),
        },
      );

      final queryParams = isGet && reqData != null ? _removeNullValues(reqData) : null;

      final response = await dio.request<dynamic>(
        '/${apiInfo.path}',
        data: isGet ? null : reqData,
        queryParameters: isGet ? queryParams : null,
        options: options,
      );

      final resModel = _responseParser<T>(
        response.data,
        fromJson,
      );

      if (resModel.code == EnumErrorMap.code200.code) {
        if (_isBaseApiResponseModelType<T>()) {
          return resModel as T;
        } else {
          return resModel.data as T;
        }
      } else {
        throw BaseApiResponseModel<T>(
          code: resModel.code,
          message: resModel.message,
        );
      }
    } on Object catch (e) {
      onError?.call(_errorHandle(e));
      return null;
    }
  }

  // MARK: - Private Method

  static bool _isBaseApiResponseModelType<T>() {
    final typeString = T.toString();
    return typeString.contains('BaseApiResponseModel');
  }

  static BaseApiResponseModel<void> _errorHandle(Object exception) {
    final err = BaseApiResponseModel<void>.unknowError();
    int code = err.code;
    String message = err.message!;

    if (exception is EnumErrorMap) {
      code = exception.code;
      message = exception.message;
    } else if (exception is DioException) {
      final convertInfo = _convertDioExceptionToErrorCode(exception);
      code = convertInfo.code;
      message = convertInfo.message;
    } else if (exception is BaseApiResponseModel) {
      code = exception.code;
      message = exception.message ?? err.message!;
    }

    return BaseApiResponseModel<void>(
      code: code,
      message: message,
    );
  }

  static Map<String, dynamic>? _convertRequestModelToJson(
    dynamic requestModel,
  ) {
    Map<String, dynamic>? result;

    if (requestModel is Map<String, dynamic>) {
      result = requestModel;
    } else {
      final jsonResult = (requestModel as dynamic).toJson();
      if (jsonResult is Map<String, dynamic>) {
        result = jsonResult;
      }
    }

    // Remove null values from the result
    if (result != null) {
      return _removeNullValues(result);
    }

    return null;
  }

  static Map<String, dynamic> _removeNullValues(
    Map<String, dynamic> map,
  ) {
    return Map<String, dynamic>.fromEntries(
      map.entries.where((entry) => entry.value != null),
    );
  }

  // MARK: - Cache Management

  static String _generateCacheKey(
    String method,
    String path,
    Map<String, dynamic>? data,
  ) {
    String dataStr = '';
    if (data != null && data.isNotEmpty) {
      try {
        final sortedData = Map.fromEntries(
          data.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
        );
        dataStr = const JsonEncoder().convert(sortedData);
      } on Object {
        dataStr = data.toString();
      }
    }
    return '$method:$path:$dataStr';
  }

  static void _startCacheCleanupTimer() {
    _stopCacheCleanupTimer();
    _cacheCleanupTimer = Timer.periodic(
      const Duration(seconds: _cacheExpirationSeconds),
      (_) => _cleanupExpiredCache(),
    );
  }

  static void _stopCacheCleanupTimer() {
    _cacheCleanupTimer?.cancel();
    _cacheCleanupTimer = null;
  }

  static void _cleanupExpiredCache() {
    final now = DateTime.now();
    final expiredRequestKeys = <String>[];

    _requestCache.forEach((key, cache) {
      final age = now.difference(cache.timestamp).inSeconds;
      if (age >= _cacheExpirationSeconds) {
        expiredRequestKeys.add(key);
        if (!cache.cancelToken.isCancelled) {
          cache.cancelToken.cancel('Cache expired');
        }
      }
    });

    for (final key in expiredRequestKeys) {
      _requestCache.remove(key);
    }

    // Clean up expired response cache
    _responseCache.clear();
  }

  static void _clearAllCache() {
    for (final cache in _requestCache.values) {
      if (!cache.cancelToken.isCancelled) {
        cache.cancelToken.cancel('Service closed');
      }
    }
    _requestCache.clear();
    _responseCache.clear();
  }

  static BaseApiResponseModel<T> _responseParser<T>(
    dynamic raw,
    T Function(Map<String, dynamic> json)? fromJson,
  ) {
    // 回應格式錯誤
    if (raw is! Map<String, dynamic>) {
      throw BaseApiResponseModel<T>(
        code: EnumErrorMap.code202.code,
        message: '${EnumErrorMap.code202.message}: ${raw.toString()}',
      );
    }

    int? code = raw['code'] as int? ?? raw['external_code'] as int?;
    String? message = raw['message'] as String? ?? raw['external_message'] as String?;
    final rawData = raw['data'];

    final finalCode = code ?? EnumErrorMap.code201.code;
    final finalMessage = message ?? EnumErrorMap.code201.message;

    if (finalCode == EnumErrorMap.code200.code) {
      if (_isBaseApiResponseModelType<T>()) {
        return BaseApiResponseModel<T>.emptySuccess();
      } else if (fromJson != null) {
        if (rawData is Map<String, dynamic>) {
          final parsed = fromJson(rawData);
          return BaseApiResponseModel<T>(
            code: finalCode,
            message: finalMessage,
            data: parsed,
          );
        } else if (rawData is List) {
          final parsed = fromJson(raw);
          return BaseApiResponseModel<T>(
            code: finalCode,
            message: finalMessage,
            data: parsed,
          );
        }
      }
    }

    throw BaseApiResponseModel<T>(
      code: code ?? EnumErrorMap.code201.code,
      message: message ?? EnumErrorMap.code201.message,
    );
  }

  static EnumErrorMap _convertDioExceptionToErrorCode(
    DioException e,
  ) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return EnumErrorMap.code100;
      case DioExceptionType.sendTimeout:
        return EnumErrorMap.code101;
      case DioExceptionType.receiveTimeout:
        return EnumErrorMap.code102;
      case DioExceptionType.badCertificate:
        return EnumErrorMap.code104;
      case DioExceptionType.badResponse:
        return EnumErrorMap.code105;
      case DioExceptionType.cancel:
        return EnumErrorMap.code106;
      case DioExceptionType.connectionError:
        return EnumErrorMap.code103;
      case DioExceptionType.unknown:
      default:
        return EnumErrorMap.code108;
    }
  }

  // MARK: - Interceptors

  static InterceptorsWrapper _apiRequestInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add user_id header with UUID
        options.headers['user_id'] = '00000000-0000-0000-0000-000000000000';

        final isGet = options.method.toUpperCase() == 'GET';

        // Only apply cache mechanism for GET requests
        if (isGet) {
          // Generate cache key
          final cacheKey = _generateCacheKey(
            options.method,
            options.path,
            options.queryParameters.isNotEmpty ? options.queryParameters : null,
          );

          // Store cache key in options extra for later use
          options.extra[_cacheKeyExtra] = cacheKey;

          // Check if response cache exists
          if (_responseCache.containsKey(cacheKey)) {
            final cachedData = _responseCache[cacheKey];
            final method = options.method.toUpperCase();
            final url = '${options.baseUrl}${options.path}';
            String headerStr = '';

            if (options.headers.isNotEmpty) {
              try {
                headerStr = const JsonEncoder.withIndent('  ').convert(options.headers);
              } on Object {
                headerStr = options.headers.toString();
              }
            }

            LogUtil.i(
              EnumLogType.apiRequest,
              '[$method] $url\n[CACHED] Returning cached response${headerStr.isNotEmpty ? '\nHeaders: $headerStr' : ''}',
            );

            // Return cached response directly
            final cachedResponse = Response<dynamic>(
              requestOptions: options,
              data: cachedData,
              statusCode: 200,
            );
            handler.resolve(cachedResponse);
            return;
          }

          // Check if same request is in progress and cancel new request
          if (_requestCache.containsKey(cacheKey)) {
            final existingCache = _requestCache[cacheKey];
            if (existingCache != null && !existingCache.cancelToken.isCancelled) {
              // Cancel the new request
              final cancelToken = CancelToken();
              cancelToken.cancel('Duplicate request cancelled - request in progress');

              final method = options.method.toUpperCase();
              final url = '${options.baseUrl}${options.path}';
              final queryParams = options.queryParameters.isNotEmpty ? '?${Uri(queryParameters: options.queryParameters).query}' : '';

              LogUtil.i(
                EnumLogType.apiRequest,
                '[CANCELLED] Duplicate request cancelled - request in progress\n[$method] $url$queryParams',
              );

              // Return cancelled response
              handler.reject(
                DioException(
                  requestOptions: options,
                  type: DioExceptionType.cancel,
                  error: 'Duplicate request cancelled',
                ),
              );
              return;
            }
          }

          // Create new cancel token for this request
          final cancelToken = CancelToken();
          _requestCache[cacheKey] = _RequestCache(
            cancelToken: cancelToken,
            timestamp: DateTime.now(),
          );

          options.cancelToken = cancelToken;
        }

        final method = options.method.toUpperCase();
        final url = '${options.baseUrl}${options.path}';
        final queryParams = options.queryParameters.isNotEmpty ? '?${Uri(queryParameters: options.queryParameters).query}' : '';

        String dataStr = '';
        if (options.data != null) {
          try {
            if (options.data is Map || options.data is List) {
              dataStr = const JsonEncoder.withIndent('  ').convert(options.data);
            } else {
              dataStr = options.data.toString();
            }
          } on Object catch (e) {
            dataStr = '${options.data.toString()}, error: $e';
          }
        }

        String headerStr = '';
        if (options.headers.isNotEmpty) {
          try {
            headerStr = const JsonEncoder.withIndent('  ').convert(options.headers);
          } on Object {
            headerStr = options.headers.toString();
          }
        }

        LogUtil.i(
          EnumLogType.apiRequest,
          '[$method] $url$queryParams${dataStr.isNotEmpty ? '\nData: $dataStr' : ''}${headerStr.isNotEmpty ? '\nHeaders: $headerStr' : ''}',
        );

        handler.next(options);
      },
    );
  }

  static InterceptorsWrapper _apiResponseInterceptor() {
    return InterceptorsWrapper(
      onResponse: (response, handler) {
        final cacheKey = response.requestOptions.extra[_cacheKeyExtra] as String?;
        final isGet = response.requestOptions.method.toUpperCase() == 'GET';

        // Only cache GET requests
        if (cacheKey != null && isGet) {
          // Store response data in cache
          if (response.data != null) {
            _responseCache[cacheKey] = response.data;
          }

          // Remove from request cache on success
          _requestCache.remove(cacheKey);
        } else if (cacheKey != null && !isGet) {
          // For non-GET requests, just remove from request cache
          _requestCache.remove(cacheKey);
        }

        final statusCode = response.statusCode ?? 0;
        final url = '${response.requestOptions.baseUrl}${response.requestOptions.path}';

        String dataStr = '';
        if (response.data != null) {
          try {
            if (response.data is Map || response.data is List) {
              dataStr = const JsonEncoder.withIndent('  ').convert(response.data);
            } else {
              dataStr = response.data.toString();
            }
          } on Object catch (e) {
            dataStr = '${response.data.toString()}, error: $e';
          }
        }

        LogUtil.i(
          EnumLogType.apiResponse,
          '[$statusCode] $url${dataStr.isNotEmpty ? '\nResponse: $dataStr' : ''}',
        );

        handler.next(response);
      },
      onError: (error, handler) {
        // Remove from cache if request was cancelled or failed
        final cacheKey = error.requestOptions.extra[_cacheKeyExtra] as String?;
        if (cacheKey != null) {
          _requestCache.remove(cacheKey);
        }

        final statusCode = error.response?.statusCode ?? 0;
        final url = error.requestOptions.path.isNotEmpty
            ? '${error.requestOptions.baseUrl}${error.requestOptions.path}'
            : error.requestOptions.uri.toString();
        final errorMessage = error.message ?? '';

        String responseDataStr = '';
        if (error.response?.data != null) {
          try {
            if (error.response!.data is Map || error.response!.data is List) {
              responseDataStr = const JsonEncoder.withIndent('  ').convert(error.response!.data);
            } else {
              responseDataStr = error.response!.data.toString();
            }
          } on Object catch (e) {
            responseDataStr = '${error.response!.data.toString()}, error: $e';
          }
        }

        LogUtil.i(
          EnumLogType.apiResponse,
          '[$statusCode] $url\nError: $errorMessage${responseDataStr.isNotEmpty ? '\nResponse: $responseDataStr' : ''}',
        );

        handler.next(error);
      },
    );
  }
}
