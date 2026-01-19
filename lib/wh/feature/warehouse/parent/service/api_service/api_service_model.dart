import 'dart:async';

import 'package:dio/dio.dart';

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
  // Service instance properties
  final Dio dio = Dio();

  // Cache properties
  final Map<String, RequestCache> requestCache = {};
  final Map<String, dynamic> responseCache = {};
  Timer? cacheCleanupTimer;
  String? accessToken;
  String? domainUrl;
  final int cacheExpirationSeconds = 0;
  final String cacheKeyExtra = 'cache_key';

  // Mock properties
  static const bool isAllMock = false;
  List<EnumApiInfo> get mockApiList => [];
}

enum EnumApiInfo {
  serverHealth('health', EnumApiMethod.get),
  // Auth APIs
  userLogin('auth/login', EnumApiMethod.post),
  userRegister('auth/register', EnumApiMethod.post),
  userLogout('auth/logout', EnumApiMethod.post),
  tokenRefresh('auth/refresh', EnumApiMethod.post),
  forgotPassword('auth/forgot-password', EnumApiMethod.post),
  resetPassword('auth/reset-password', EnumApiMethod.post),
  // Household
  homeRead('home', EnumApiMethod.get),
  // Warehouse Item
  itemCreate('item', EnumApiMethod.post),
  itemSmartCreate('item/smart', EnumApiMethod.post),
  itemRead('item', EnumApiMethod.get),
  itemUpdateNormal('item/normal', EnumApiMethod.put),
  itemUpdatePosition('item/position', EnumApiMethod.put),
  itemUpdateQuantity('item/quantity', EnumApiMethod.put),
  itemDelete('item', EnumApiMethod.delete),
  // Warehouse Cabinet
  cabinetRead('cabinet', EnumApiMethod.get),
  cabinetCreate('cabinet', EnumApiMethod.post),
  cabinetUpdate('cabinet', EnumApiMethod.put),
  cabinetDelete('cabinet', EnumApiMethod.delete),
  // Warehouse Category
  categoryCreate('category', EnumApiMethod.post),
  categoryRead('category', EnumApiMethod.get),
  categoryUpdate('category', EnumApiMethod.put),
  categoryDelete('category', EnumApiMethod.delete),
  // Warehouse Record
  recordCreate('record', EnumApiMethod.post),
  recordRead('record', EnumApiMethod.get),
  recordDelete('record', EnumApiMethod.delete);

  const EnumApiInfo(this.path, this.method);
  final String path;
  final EnumApiMethod method;
}

enum EnumApiMethod {
  get,
  post,
  put,
  delete,
  patch;

  String get value => name.toUpperCase();
}
