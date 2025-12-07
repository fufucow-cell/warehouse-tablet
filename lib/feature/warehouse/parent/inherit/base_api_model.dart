import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/error_map_constant.dart';

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

  factory BaseApiResponseModel.emptySuccess() {
    return BaseApiResponseModel<T>(
      code: EnumErrorMap.code200.code,
      message: EnumErrorMap.code200.message,
    );
  }

  factory BaseApiResponseModel.unknowError() {
    return BaseApiResponseModel<T>(
      code: EnumErrorMap.code201.code,
      message: EnumErrorMap.code201.message,
    );
  }
}

class ApiEmptyResponse {
  const ApiEmptyResponse();

  static const name = 'ApiEmptyResponse';
}
