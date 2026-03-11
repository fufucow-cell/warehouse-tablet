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
  itemCreate('warehouse/item', EnumApiMethod.post),
  itemSmartCreate('warehouse/item/smart', EnumApiMethod.post),
  itemRead('warehouse/item', EnumApiMethod.get),
  itemUpdateNormal('warehouse/item/normal', EnumApiMethod.put),
  itemUpdatePosition('warehouse/item/position', EnumApiMethod.put),
  itemUpdateQuantity('warehouse/item/quantity', EnumApiMethod.put),
  itemDelete('warehouse/item', EnumApiMethod.delete),
  // Warehouse Cabinet
  cabinetRead('warehouse/cabinet', EnumApiMethod.get),
  cabinetCreate('warehouse/cabinet', EnumApiMethod.post),
  cabinetUpdate('warehouse/cabinet', EnumApiMethod.put),
  cabinetDelete('warehouse/cabinet', EnumApiMethod.delete),
  // Warehouse Category
  categoryCreate('warehouse/category', EnumApiMethod.post),
  categoryRead('warehouse/category', EnumApiMethod.get),
  categoryUpdate('warehouse/category', EnumApiMethod.put),
  categoryDelete('warehouse/category', EnumApiMethod.delete),
  // Warehouse Record
  recordCreate('warehouse/record', EnumApiMethod.post),
  recordRead('warehouse/record', EnumApiMethod.get),
  recordDelete('warehouse/record', EnumApiMethod.delete);

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
