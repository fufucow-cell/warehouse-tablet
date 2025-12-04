import 'package:flutter_smart_home_tablet/feature/warehouse/constant/error_map.dart';

abstract class BaseApiRequestModel {
  Map<String, dynamic> toJson();

  /// 从 JSON 创建对象（泛型静态方法）
  /// 子类应该实现 factory constructor fromJson
  static T fromJson<T extends BaseApiRequestModel>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return fromJsonT(json);
  }
}

class BaseApiResponseModel<T> {
  final int code;
  final String? message;
  final T? data;

  BaseApiResponseModel({
    required this.code,
    this.message,
    this.data,
  });

  factory BaseApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return BaseApiResponseModel<T>(
      code: json['code'] as int,
      message: json['message'] as String?,
      data: fromJsonT(json['data']),
    );
  }
}

/// API 空響應類，用於表示 API 成功但沒有返回數據的情況
class ApiEmptyResponse {
  const ApiEmptyResponse();

  static const name = 'ApiEmptyResponse';
}

// throw Api 錯誤異常
class ApiException implements Exception {
  final int code;
  final String message;

  const ApiException({
    required this.code,
    required this.message,
  });

  factory ApiException.localError() {
    return ApiException(
      code: EnumErrorMap.code201.code,
      message: EnumErrorMap.code201.message,
    );
  }

  @override
  String toString() => 'ApiException(code: $code, message: $message)';
}
