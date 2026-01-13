import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:engo_terminal_app3/service/api_service/api_service_model.dart' as api_model;
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/error_map_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/base_api_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/api_service/api_service_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;

class ApiService extends GetxService {
  // MARK: - Properties

  static const String _tagName = 'smart_home';
  static ApiService get instance => Get.find<ApiService>(tag: _tagName);

  // Mock properties
  static const bool isAllMock = true;
  static List<EnumApiInfo> get mockApiList => [];

  // MARK: - Init

  ApiService._internal();

  static ApiService register(String baseUrl) {
    if (Get.isRegistered<ApiService>(tag: _tagName)) {
      return instance;
    }
    final ApiService service = ApiService._internal();
    api_model.ApiServiceModel.instance.dio.options.baseUrl = baseUrl;
    api_model.ApiServiceModel.instance.dio.interceptors.add(service._mockInterceptor());
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

  // MARK: - Public Method

  @override
  void onClose() {
    api_model.ApiServiceModel.instance.dio.close(force: true);
    super.onClose();
  }

  static Future<T> sendRequest<T>(
    EnumApiInfo apiInfo, {
    dynamic requestModel,
    T Function(Map<String, dynamic> json)? fromJson,
  }) async {
    return instance._executeRequest<T>(
      apiInfo: apiInfo,
      requestModel: requestModel,
      fromJson: fromJson,
    );
  }

  // MARK: - Private Method

  Future<T> _executeRequest<T>({
    required EnumApiInfo apiInfo,
    dynamic requestModel,
    T Function(Map<String, dynamic> json)? fromJson,
  }) async {
    try {
      final dio = api_model.ApiServiceModel.instance.dio;
      final isGet = apiInfo.method == EnumApiMethod.get;
      final reqData = _convertRequestModelToJson(requestModel);
      final options = Options(
        method: apiInfo.method.value,
        extra: {
          BaseApiResponseModel.name: T == BaseApiResponseModel,
        },
      );

      final response = await dio.request<dynamic>(
        '/${apiInfo.path}',
        data: isGet ? null : reqData,
        queryParameters: isGet ? reqData : null,
        options: options,
      );

      final resModel = _responseParser<T>(
        response.data,
        fromJson,
      );

      if (resModel.code == EnumErrorMap.code200.code) {
        return resModel.data as T;
      } else {
        throw BaseApiResponseModel<T>(
          code: resModel.code,
          message: resModel.message,
        );
      }
    } on Object catch (e) {
      _errorHandler<T>(
        apiInfo: apiInfo,
        requestModel: requestModel,
        fromJson: fromJson,
        exception: e,
      );
    }
  }

  Map<String, dynamic>? _convertRequestModelToJson(
    dynamic requestModel,
  ) {
    if (requestModel is Map<String, dynamic>) {
      return requestModel;
    }

    final result = (requestModel as dynamic).toJson();

    if (result is Map<String, dynamic>) {
      return result;
    }

    return null;
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

    int? code = raw['code'] as int?;
    String? message = raw['message'] as String?;
    final rawData = raw['data'];
    final finalCode = code ?? EnumErrorMap.code201.code;
    final finalMessage = message ?? EnumErrorMap.code201.message;

    if (finalCode == EnumErrorMap.code200.code) {
      if (rawData == null && T == BaseApiResponseModel) {
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

  Never _errorHandler<T>({
    required EnumApiInfo apiInfo,
    dynamic requestModel,
    T Function(Map<String, dynamic> json)? fromJson,
    Object? exception,
  }) {
    final err = BaseApiResponseModel<T>.unknowError();
    int code = err.code;
    String message = err.message!;

    if (exception is EnumErrorMap) {
      code = exception.code;
      message = exception.message;
    } else if (exception is DioException) {
      final convertInfo = _convertDioExceptionToErrorCode(exception);
      code = convertInfo.code;
      message = convertInfo.message;
    } else if (exception is BaseApiResponseModel<T>) {
      code = exception.code;
      message = exception.message!;
    }

    throw BaseApiResponseModel(
      code: code,
      message: message,
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

  InterceptorsWrapper _mockInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final apiInfo = _getApiInfoFromPathAndMethod(
          options.path,
          options.method,
        );

        if (apiInfo != null && _isMock(apiInfo)) {
          await _interceptorMock(options, handler, apiInfo);
          return;
        }

        handler.next(options);
      },
    );
  }

  bool _isMock(EnumApiInfo apiInfo) {
    if (isAllMock) {
      return true;
    }
    return mockApiList.contains(apiInfo);
  }

  EnumApiInfo? _getApiInfoFromPathAndMethod(
    String path,
    String method,
  ) {
    final cleanPath = path.replaceAll(RegExp(r'^/+'), '');
    final methodLower = method.toLowerCase();

    for (final apiInfo in EnumApiInfo.values) {
      if (apiInfo.path == cleanPath && apiInfo.method.name == methodLower) {
        return apiInfo;
      }
    }

    return null;
  }

  Future<void> _interceptorMock(
    RequestOptions options,
    RequestInterceptorHandler handler,
    EnumApiInfo apiInfo,
  ) async {
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
  }

  String _getMockFileName(
    RequestOptions options,
    EnumApiInfo apiInfo,
  ) {
    final cleanPath = options.path.replaceAll(RegExp(r'^/+'), '');
    final methodName = apiInfo.method.name.toLowerCase();
    String baseFileName = cleanPath.replaceAll('/', '_');
    baseFileName = '${baseFileName}_$methodName';
    return '$baseFileName.json';
  }
}
