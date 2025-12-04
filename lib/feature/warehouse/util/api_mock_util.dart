import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/constant/api_path.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/constant/error_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/inherit/base_api_model.dart';

class ApiMockUtil {
  // MARK: - Properties

  static const bool isAllMock = false;
  static List<EnumApiInfo> get mockApiList => [
        EnumApiInfo.userLogin,
        EnumApiInfo.userRegister,
      ];

  // MARK: - Method

  static InterceptorsWrapper createInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final apiInfo = _getApiInfoFromPath(options.path);

        if (apiInfo != null && _isMock(apiInfo)) {
          await _interceptorMock(options, handler);
          return;
        }

        handler.next(options);
      },
    );
  }

  // MARK: - Private Method

  static bool _isMock(EnumApiInfo apiInfo) {
    if (isAllMock) {
      return true;
    }
    return mockApiList.contains(apiInfo);
  }

  static EnumApiInfo? _getApiInfoFromPath(String path) {
    // 移除所有開頭的斜線
    final cleanPath = path.replaceAll(RegExp(r'^/+'), '');

    // 遍歷所有 EnumApiInfo 找到匹配的路徑
    for (final apiInfo in EnumApiInfo.values) {
      if (apiInfo.path == cleanPath) {
        return apiInfo;
      }
    }
    return null;
  }

  static Future<void> _interceptorMock(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isApiEmptyResponse =
        options.extra[ApiEmptyResponse.name] as bool? ?? false;

    if (isApiEmptyResponse) {
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
      final mockFileName = _getMockFileName(options);
      final jsonString = await rootBundle
          .loadString('assets/mock_data/$mockFileName');
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

  static String _getMockFileName(RequestOptions options) {
    // 移除所有開頭的斜線，與 _getApiInfoFromPath 保持一致
    final cleanPath = options.path.replaceAll(RegExp(r'^/+'), '');
    final baseFileName = cleanPath.replaceAll('/', '_');
    return '$baseFileName.json';
  }
}
