import 'package:dio/dio.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/constant/api_path.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/constant/error_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/inherit/base_api_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/util/api_mock_util.dart';
import 'package:get/get.dart' hide Response;

class ApiUtil extends GetxService {
  // Properties

  final Dio _dio;

  // Init

  ApiUtil._internal(String url)
      : _dio = Dio(BaseOptions(baseUrl: url)) {
    _dio.interceptors.add(ApiMockUtil.createInterceptor());
  }

  // Public Method

  @override
  void onClose() {
    _dio.close(force: true);
    super.onClose();
  }

  static ApiUtil register(String baseUrl) {
    if (Get.isRegistered<ApiUtil>()) {
      return Get.find<ApiUtil>();
    }
    final ApiUtil service = ApiUtil._internal(baseUrl);
    Get.put<ApiUtil>(service, permanent: true);
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<ApiUtil>()) {
      Get.delete<ApiUtil>(); // 自動觸發該實例的 onClose() 方法
    }
  }

  static Future<T> sendRequest<T>(
    EnumApiInfo apiInfo, {
    BaseApiRequestModel? requestModel,
    T Function(Map<String, dynamic> json)? fromJson,
  }) async {
    return _executeRequest<T>(
      apiInfo: apiInfo,
      requestModel: requestModel,
      fromJson: fromJson,
    );
  }

  static Future<T> _executeRequest<T>({
    required EnumApiInfo apiInfo,
    BaseApiRequestModel? requestModel,
    T Function(Map<String, dynamic> json)? fromJson,
  }) async {
    try {
      final dio = Get.find<ApiUtil>()._dio;
      final isGet = apiInfo.method == EnumApiMethod.get;
      final reqData = requestModel?.toJson();
      final options = Options(
        method: apiInfo.method.value,
        extra: {ApiEmptyResponse.name: T == ApiEmptyResponse},
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

      // 錯誤處理
      if (resModel.code != EnumErrorMap.code200.code) {
        await _errorHandler<T>(
          apiInfo: apiInfo,
          requestModel: requestModel,
          fromJson: fromJson,
          responseModel: resModel,
        );
        // _errorHandler 會 throw，這裡不會執行到
        return _getDefaultResponse<T>();
      }

      // 成功回傳
      if (resModel.data != null) {
        return resModel.data as T;
      } else {
        // data 為 null 時，如果 fromJson 為 null 或 T 是 ApiEmptyResponse，返回 ApiEmptyResponse
        if (fromJson == null || T == ApiEmptyResponse) {
          return const ApiEmptyResponse() as T;
        }
        // 否則拋出異常，因為期望有數據但沒有
        throw ApiException(
          code: EnumErrorMap.code201.code,
          message: 'Response data is null but type $T expects data',
        );
      }
    } on DioException catch (e) {
      await _errorHandler<T>(
        apiInfo: apiInfo,
        requestModel: requestModel,
        fromJson: fromJson,
        dioException: e,
      );
      // _errorHandler 會 throw，這裡不會執行到
      return _getDefaultResponse<T>();
    } on Object catch (e) {
      await _errorHandler<T>(
        apiInfo: apiInfo,
        requestModel: requestModel,
        fromJson: fromJson,
        exception: e,
      );
      // _errorHandler 會 throw，這裡不會執行到
      return _getDefaultResponse<T>();
    }
  }

  /// 獲取默認響應值
  /// 當錯誤處理路徑中需要返回值時使用（實際上不會執行到）
  static T _getDefaultResponse<T>() {
    return const ApiEmptyResponse() as T;
  }

  // Private Method

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

  static BaseApiResponseModel<T> _responseParser<T>(
    dynamic raw,
    T Function(Map<String, dynamic> json)? fromJson,
  ) {
    int? code = raw['code'] as int?;
    String? message = raw['message'] as String?;
    final rawData = raw['data'];
    T? resData;

    if (raw is! Map<String, dynamic>) {
      const errorInfo = EnumErrorMap.code202;
      code = errorInfo.code;
      message = '${errorInfo.message}: ${raw.toString()}';
    }

    if (code == EnumErrorMap.code200.code && fromJson != null) {
      try {
        if (rawData == null) {
          const errorInfo = EnumErrorMap.code203;
          code = errorInfo.code;
          message = '${errorInfo.message}: data is null';
        } else if (rawData is! Map<String, dynamic>) {
          const errorInfo = EnumErrorMap.code203;
          code = errorInfo.code;
          message =
              '${errorInfo.message}: data is not Map<String, dynamic>, got ${rawData.runtimeType}';
        } else {
          final mapData = rawData;
          resData = fromJson(mapData) as T?;
        }
      } on Object catch (e) {
        const errorInfo = EnumErrorMap.code203;
        code = errorInfo.code;
        message = '${errorInfo.message}: ${e.toString()}';
      }
    }

    return BaseApiResponseModel<T>(
      code: code ?? EnumErrorMap.code200.code,
      message: message ?? EnumErrorMap.code200.message,
      data: resData,
    );
  }

  /// 處理錯誤狀態
  static Future<void> _errorHandler<T>({
    required EnumApiInfo apiInfo,
    BaseApiRequestModel? requestModel,
    T Function(Map<String, dynamic> json)? fromJson,
    BaseApiResponseModel<T>? responseModel,
    DioException? dioException,
    Object? exception,
  }) async {
    const defaultError = EnumErrorMap.code201;
    int code = defaultError.code;
    String message = defaultError.message;

    if (responseModel != null) {
      code = responseModel.code;
      message = responseModel.message ?? defaultError.message;
    } else if (dioException != null) {
      final errorInfo = _convertDioExceptionToErrorCode(dioException);
      code = errorInfo.code;
      message = errorInfo.message;
    } else if (exception != null) {
      message = exception.toString();
    }

    // 直接拋出錯誤
    throw ApiException(code: code, message: message);
  }
}
