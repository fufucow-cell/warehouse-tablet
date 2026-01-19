import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:engo_terminal_app3/service/api_service/api_service_model.dart' as home_service;
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/error_map_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/base_api_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/api_service/api_service_model.dart' as warehouse_service;
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;

class ApiService extends GetxService {
  // MARK: - Properties

  static const String _tagName = 'smart_home';
  final _model = home_service.ApiServiceModel.instance;
  static ApiService get instance => Get.find<ApiService>(tag: _tagName);
  EnvironmentService get _envService => EnvironmentService.instance;
  static const bool isAllMock = true;
  static List<warehouse_service.EnumApiInfo> get mockApiList => [];

  // MARK: - Init

  ApiService._internal();

  static ApiService register() {
    if (Get.isRegistered<ApiService>(tag: _tagName)) {
      return instance;
    }
    final ApiService service = ApiService._internal();
    service._model.dio.options.baseUrl = service._envService.getDomainUrl;
    service._model.dio.options.connectTimeout = const Duration(seconds: 30);
    service._model.dio.options.receiveTimeout = const Duration(seconds: 30);
    service._model.dio.options.sendTimeout = const Duration(seconds: 30);
    service._model.dio.options.followRedirects = true;
    service._model.dio.options.maxRedirects = 3;
    service._model.dio.interceptors.add(service._mockInterceptor());
    service._model.dio.interceptors.add(service._apiRequestInterceptor());
    service._model.dio.interceptors.add(service._apiResponseInterceptor());
    service._startCacheCleanupTimer();
    Get.put<ApiService>(
      service,
      tag: _tagName,
      permanent: true,
    );
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<ApiService>(tag: _tagName)) {
      Get.delete<ApiService>(
        tag: _tagName,
      ); // 自動觸發該實例的 onClose() 方法
    }
  }

  @override
  void onClose() {
    _stopCacheCleanupTimer();
    _clearAllCache();
    _model.dio.close(force: true);
    super.onClose();
  }

  // MARK: - Public Method

  void updateDomain(String domain) {
    _model.dio.options.baseUrl = domain;
  }

  static Future<T?> sendRequest<T>(
    warehouse_service.EnumApiInfo apiInfo, {
    dynamic requestModel,
    T Function(Map<String, dynamic> json)? fromJson,
    void Function(BaseApiResponseModel<void> error)? onError,
  }) async {
    return instance._sendRequest<T>(
      apiInfo,
      requestModel: requestModel,
      fromJson: fromJson,
      onError: onError,
    );
  }

  Future<T?> _sendRequest<T>(
    warehouse_service.EnumApiInfo apiInfo, {
    dynamic requestModel,
    T Function(Map<String, dynamic> json)? fromJson,
    void Function(BaseApiResponseModel<void> error)? onError,
  }) async {
    try {
      final dio = _model.dio;
      final isGet = apiInfo.method == warehouse_service.EnumApiMethod.get;
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

  bool _isBaseApiResponseModelType<T>() {
    final typeString = T.toString();
    return typeString.contains('BaseApiResponseModel');
  }

  BaseApiResponseModel<void> _errorHandle(Object exception) {
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

  Map<String, dynamic>? _convertRequestModelToJson(
    dynamic requestModel,
  ) {
    if (requestModel == null) {
      return null;
    }

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

  Map<String, dynamic> _removeNullValues(
    Map<String, dynamic> map,
  ) {
    return Map<String, dynamic>.fromEntries(
      map.entries.where((entry) => entry.value != null),
    );
  }

  // MARK: - Cache Management

  String _generateCacheKey(
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

  void _startCacheCleanupTimer() {
    _stopCacheCleanupTimer();
    // Skip timer if cache is disabled (cacheExpirationSeconds = 0)
    if (_model.cacheExpirationSeconds > 0) {
      _model.cacheCleanupTimer = Timer.periodic(
        Duration(seconds: _model.cacheExpirationSeconds),
        (_) => _cleanupExpiredCache(),
      );
    }
  }

  void _stopCacheCleanupTimer() {
    _model.cacheCleanupTimer?.cancel();
    _model.cacheCleanupTimer = null;
  }

  void _cleanupExpiredCache() {
    final expiredRequestKeys = <String>[];

    _model.requestCache.forEach((key, cache) {
      final age = DateTime.now().difference(cache.timestamp).inSeconds;
      if (age >= _model.cacheExpirationSeconds) {
        expiredRequestKeys.add(key);
        if (!cache.cancelToken.isCancelled) {
          cache.cancelToken.cancel('Cache expired');
        }
      }
    });

    for (final key in expiredRequestKeys) {
      _model.requestCache.remove(key);
    }

    // Clean up expired response cache
    _model.responseCache.clear();
  }

  void _clearAllCache() {
    for (final cache in _model.requestCache.values) {
      if (!cache.cancelToken.isCancelled) {
        cache.cancelToken.cancel('Service closed');
      }
    }
    _model.requestCache.clear();
    _model.responseCache.clear();
  }

  BaseApiResponseModel<T> _responseParser<T>(
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

  EnumErrorMap _convertDioExceptionToErrorCode(
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

  // MARK: - Mock Interceptor

  bool _isMock(warehouse_service.EnumApiInfo apiInfo) {
    if (home_service.ApiServiceModel.isAllMock) {
      return true;
    }
    return _model.mockApiList.contains(apiInfo);
  }

  warehouse_service.EnumApiInfo? _getApiInfoFromPathAndMethod(
    String path,
    String method,
  ) {
    final cleanPath = path.replaceAll(RegExp(r'^/+'), '');
    final methodLower = method.toLowerCase();

    for (final apiInfo in warehouse_service.EnumApiInfo.values) {
      if (apiInfo.path == cleanPath && apiInfo.method.name == methodLower) {
        return apiInfo;
      }
    }

    return null;
  }

  String _getMockFileName(
    RequestOptions options,
    warehouse_service.EnumApiInfo apiInfo,
  ) {
    final cleanPath = options.path.replaceAll(RegExp(r'^/+'), '');
    final methodName = apiInfo.method.name.toLowerCase();
    String baseFileName = cleanPath.replaceAll('/', '_');
    baseFileName = '${baseFileName}_$methodName';
    return '$baseFileName.json';
  }

  InterceptorsWrapper _mockInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final apiInfo = _getApiInfoFromPathAndMethod(
          options.path,
          options.method,
        );

        if (apiInfo != null && _isMock(apiInfo)) {
          final isEmptyResponse = options.extra[BaseApiResponseModel.name] as bool? ?? false;

          if (isEmptyResponse) {
            final successResponse = Response<dynamic>(
              requestOptions: options,
              data: {
                'code': EnumErrorMap.code200.code,
                'message': EnumErrorMap.code200.message,
                'data': null,
              },
              statusCode: EnumErrorMap.code200.code,
              statusMessage: EnumErrorMap.code200.message,
            );
            handler.resolve(successResponse);
            return;
          }

          try {
            final mockFileName = _getMockFileName(options, apiInfo);
            final jsonString = await rootBundle.loadString(
              'lib/wh/feature/warehouse/parent/assets/mock_data/response/$mockFileName',
            );
            final mockData = jsonDecode(jsonString) as Map<String, dynamic>;
            final mockResponse = Response<dynamic>(
              requestOptions: options,
              data: mockData,
              statusCode: EnumErrorMap.code200.code,
              statusMessage: EnumErrorMap.code200.message,
            );

            handler.resolve(mockResponse);
          } on Object {
            final errorResponse = Response<dynamic>(
              requestOptions: options,
              data: {
                'code': EnumErrorMap.code203.code,
                'message': EnumErrorMap.code203.message,
                'data': null,
              },
              statusCode: EnumErrorMap.code200.code,
            );

            handler.resolve(errorResponse);
          }
          return;
        }

        handler.next(options);
      },
    );
  }

  InterceptorsWrapper _apiRequestInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Content-Type'] = 'application/json';
        options.headers['App-Code'] = 'APP_MEMBER';
        // options.headers['Authorization'] = _envService.getAccessToken;
        options.headers['current-member-id'] = '00000000-0000-0000-0000-000000000000';
        final isGet = options.method.toUpperCase() == 'GET';

        // Only apply cache mechanism for GET requests and when cache is enabled
        if (isGet && _model.cacheExpirationSeconds > 0) {
          // Generate cache key
          final cacheKey = _generateCacheKey(
            options.method,
            options.path,
            options.queryParameters.isNotEmpty ? options.queryParameters : null,
          );

          // Store cache key in options extra for later use
          options.extra[_model.cacheKeyExtra] = cacheKey;

          // Check if response cache exists
          if (_model.responseCache.containsKey(cacheKey)) {
            final cachedData = _model.responseCache[cacheKey];
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

            LogService.instance.i(
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
          if (_model.requestCache.containsKey(cacheKey)) {
            final existingCache = _model.requestCache[cacheKey];
            if (existingCache != null && !existingCache.cancelToken.isCancelled) {
              // Cancel the new request
              final cancelToken = CancelToken();
              cancelToken.cancel('Duplicate request cancelled - request in progress');

              final method = options.method.toUpperCase();
              final url = '${options.baseUrl}${options.path}';
              final queryParams = options.queryParameters.isNotEmpty ? '?${Uri(queryParameters: options.queryParameters).query}' : '';

              LogService.instance.i(
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
          _model.requestCache[cacheKey] = home_service.RequestCache(
            cancelToken: cancelToken,
            timestamp: DateTime.now(),
          );

          options.cancelToken = cancelToken;
        }

        final method = options.method.toUpperCase();
        final queryParams = options.queryParameters.isNotEmpty ? '?${Uri(queryParameters: options.queryParameters).query}' : '';
        final fullUrl = '${options.baseUrl}${options.path}$queryParams';

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

        final logMessage = StringBuffer();
        logMessage.writeln('[$method] $fullUrl');
        if (headerStr.isNotEmpty) {
          logMessage.writeln('Headers:');
          logMessage.writeln(headerStr);
        }
        if (dataStr.isNotEmpty) {
          logMessage.writeln('Parameters:');
          logMessage.writeln(dataStr);
        }

        LogService.instance.i(
          EnumLogType.apiRequest,
          logMessage.toString(),
        );

        handler.next(options);
      },
    );
  }

  InterceptorsWrapper _apiResponseInterceptor() {
    return InterceptorsWrapper(
      onResponse: (response, handler) {
        final cacheKey = response.requestOptions.extra[_model.cacheKeyExtra] as String?;
        final isGet = response.requestOptions.method.toUpperCase() == 'GET';

        // Only cache GET requests
        if (cacheKey != null && isGet) {
          // Store response data in cache
          if (response.data != null) {
            _model.responseCache[cacheKey] = response.data;
          }

          // Remove from request cache on success
          _model.requestCache.remove(cacheKey);
        } else if (cacheKey != null && !isGet) {
          // For non-GET requests, just remove from request cache
          _model.requestCache.remove(cacheKey);
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

        LogService.instance.i(
          EnumLogType.apiResponse,
          '[$statusCode] $url${dataStr.isNotEmpty ? '\nResponse: $dataStr' : ''}',
        );

        handler.next(response);
      },
      onError: (error, handler) {
        // Remove from cache if request was cancelled or failed
        final cacheKey = error.requestOptions.extra[_model.cacheKeyExtra] as String?;
        if (cacheKey != null) {
          _model.requestCache.remove(cacheKey);
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

        final logMessage = StringBuffer();
        logMessage.writeln('[$statusCode] $url');

        if (errorMessage.isNotEmpty) {
          logMessage.writeln('Error: $errorMessage');
        }
        if (error.response != null) {
          logMessage.writeln('Response Headers:');
          logMessage.writeln(error.response!.headers.map.toString());
        }
        if (responseDataStr.isNotEmpty) {
          logMessage.writeln('Response:');
          logMessage.writeln(responseDataStr);
        }

        LogService.instance.i(
          EnumLogType.apiResponse,
          logMessage.toString(),
        );

        handler.next(error);
      },
    );
  }
}
