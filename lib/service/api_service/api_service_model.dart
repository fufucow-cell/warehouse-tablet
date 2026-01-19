import 'dart:async';

import 'package:dio/dio.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/api_service/api_service_model.dart';

class RequestCache {
  final CancelToken cancelToken;
  final DateTime timestamp;

  RequestCache({
    required this.cancelToken,
    required this.timestamp,
  });
}

/// Api Service Model
class ApiServiceModel {
  ApiServiceModel._();
  static final ApiServiceModel instance = ApiServiceModel._();

  // Service instance properties
  final Dio dio = Dio();

  // Cache properties
  final Map<String, RequestCache> requestCache = {};
  final Map<String, dynamic> responseCache = {};
  Timer? cacheCleanupTimer;
  String? accessToken;
  String? refreshToken;
  String? domainUrl;
  final int cacheExpirationSeconds = 0;
  final String cacheKeyExtra = 'cache_key';

  // Mock properties
  static const bool isAllMock = false;
  List<EnumApiInfo> get mockApiList => [
        EnumApiInfo.userLogin,
        EnumApiInfo.homeRead,
      ];
}
