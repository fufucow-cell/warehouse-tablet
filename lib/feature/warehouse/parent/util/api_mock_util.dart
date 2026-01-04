import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/error_map_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_api_model.dart';

class ApiMockUtil {
  // MARK: - Properties

  static const bool isAllMock = false;
  static List<EnumApiInfo> get mockApiList => [
        // EnumApiInfo.itemRead,
      ];

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
    final cleanPath = path.replaceAll(RegExp(r'^/+'), '');
    final methodLower = method.toLowerCase();

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
        'lib/feature/warehouse/parent/assets/mock_data/response/$mockFileName',
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

  static String _getMockFileName(
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
