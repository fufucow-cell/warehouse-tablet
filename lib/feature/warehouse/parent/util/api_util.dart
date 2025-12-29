import 'package:dio/dio.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/error_map_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_api_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/api_mock_util.dart';
import 'package:get/get.dart' hide Response;

class ApiUtil extends GetxService {
  // Properties

  static const String _tagName = 'warehouse';
  final Dio _dio;

  // Init

  ApiUtil._internal(String url) : _dio = Dio(BaseOptions(baseUrl: url)) {
    _dio.interceptors.add(ApiMockUtil.createInterceptor());
  }

  // Public Method

  @override
  void onClose() {
    _dio.close(force: true);
    super.onClose();
  }

  static ApiUtil register(String baseUrl) {
    if (Get.isRegistered<ApiUtil>(tag: _tagName)) {
      return _instance;
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

  static ApiUtil get _instance => Get.find<ApiUtil>(tag: _tagName);

  static Future<T?> sendRequest<T>(
    EnumApiInfo apiInfo, {
    dynamic requestModel,
    T Function(Map<String, dynamic> json)? fromJson,
    void Function(BaseApiResponseModel<void> error)? onError,
  }) async {
    try {
      final dio = _instance._dio;
      final isGet = apiInfo.method == EnumApiMethod.get;
      final reqData = _convertRequestModelToJson(requestModel);
      final options = Options(
        method: apiInfo.method.value,
        extra: {
          BaseApiResponseModel.name: _isBaseApiResponseModelType<T>(),
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
    if (requestModel is Map<String, dynamic>) {
      return requestModel;
    }

    final result = (requestModel as dynamic).toJson();

    if (result is Map<String, dynamic>) {
      return result;
    }

    return null;
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

    int? code = raw['code'] as int?;
    String? message = raw['message'] as String?;
    final rawData = raw['data'];

    final finalCode = code ?? EnumErrorMap.code201.code;
    final finalMessage = message ?? EnumErrorMap.code201.message;

    if (finalCode == EnumErrorMap.code200.code) {
      if (rawData == null && _isBaseApiResponseModelType<T>()) {
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
}
