import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_home_tablet/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/constant/error_map_constant.dart';
import 'package:flutter_smart_home_tablet/inherit/base_api_model.dart';

class ApiMockUtil {
  // MARK: - Properties

  static const bool isAllMock = true;
  static List<EnumApiInfo> get mockApiList => [];

  // MARK: - Method

  static InterceptorsWrapper createInterceptor() {
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

  // MARK: - Private Method

  static bool _isMock(EnumApiInfo apiInfo) {
    if (isAllMock) {
      return true;
    }
    return mockApiList.contains(apiInfo);
  }

  static EnumApiInfo? _getApiInfoFromPathAndMethod(
    String path,
    String method,
  ) {
    // 移除所有開頭的斜線
    final cleanPath = path.replaceAll(RegExp(r'^/+'), '');
    // 將 HTTP method 轉換為小寫，與 EnumApiMethod 對應
    final methodLower = method.toLowerCase();

    // 遍歷所有 EnumApiInfo 找到匹配的路徑和方法
    for (final apiInfo in EnumApiInfo.values) {
      if (apiInfo.path == cleanPath && apiInfo.method.name == methodLower) {
        return apiInfo;
      }
    }
    return null;
  }

  static Future<void> _interceptorMock(
    RequestOptions options,
    RequestInterceptorHandler handler,
    EnumApiInfo apiInfo,
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
      final mockFileName = _getMockFileName(options, apiInfo);
      final jsonString = await rootBundle.loadString(
        'assets/mock_data/response/$mockFileName',
      );
      final mockData = jsonDecode(jsonString) as Map<String, dynamic>;
      final mockResponse = Response<dynamic>(
        requestOptions: options,
        data: mockData,
        statusCode: EnumErrorMap.code200.code,
        statusMessage: EnumErrorMap.code200.message,
      );

      handler.resolve(mockResponse);
    } on Object catch (error) {
      final errorResponse = Response<dynamic>(
        requestOptions: options,
        data: {
          'code': EnumErrorMap.code203.code,
          'message': '${EnumErrorMap.code203.message} - $error',
          'data': null,
        },
        statusCode: EnumErrorMap.code200.code,
      );

      handler.resolve(errorResponse);
    }
  }

  static String _getMockFileName(
    RequestOptions options,
    EnumApiInfo apiInfo,
  ) {
    final cleanPath = options.path.replaceAll(RegExp(r'^/+'), '');
    final methodName = apiInfo.method.name.toLowerCase();
    String baseFileName = cleanPath.replaceAll('/', '_');

    if (cleanPath == EnumApiInfo.homeFetch.path) {
      baseFileName = '${baseFileName}_$methodName';
    }

    // 其他 path 保持原來的格式
    return '$baseFileName.json';
  }
}
