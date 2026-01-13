import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/log_service/log_service_model.dart';
import 'package:flutter_smart_home_tablet/service/router_service/router_service_model.dart';
import 'package:get/get.dart';

class RouterService extends GetxService implements NavigatorObserver {
  // MARK: - Properties

  final _model = RouterServiceModel();
  static const String _tagName = 'smart_home';
  BuildContext? get rootContext => _model.rootNavigatorKey.currentContext;
  NavigatorState? get rootNavigator => _model.rootNavigatorKey.currentState;
  GlobalKey<NavigatorState> get rootNavigatorKey => _model.rootNavigatorKey;
  String get initRouterPath => EnumRootRouter.splash.path;
  List<GetPage<dynamic>> get getRouterPages => EnumRootRouter.pages;
  static RouterService get instance => Get.find<RouterService>(tag: _tagName);

  // MARK: - Init

  RouterService._internal();

  static RouterService register() {
    if (Get.isRegistered<RouterService>(tag: _tagName)) {
      return instance;
    }
    final RouterService service = RouterService._internal();
    Get.put<RouterService>(
      service,
      tag: _tagName,
      permanent: true,
    );
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<RouterService>(tag: _tagName)) {
      Get.delete<RouterService>(
        tag: _tagName,
        force: true,
      );
    }
  }

  // MARK: - NavigatorObserver

  @override
  NavigatorState? get navigator => null;

  @override
  void didPush(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    LogService.i(
      EnumLogType.navigation,
      '路由推入: ${route.settings.name} (前一個路由: ${previousRoute?.settings.name ?? '無'})',
    );
  }

  @override
  void didPop(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    LogService.i(
      EnumLogType.navigation,
      '路由彈出: ${route.settings.name} (前一個路由: ${previousRoute?.settings.name ?? '無'})',
    );
  }

  @override
  void didRemove(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    LogService.i(
      EnumLogType.navigation,
      '路由移除: ${route.settings.name} (前一個路由: ${previousRoute?.settings.name ?? '無'})',
    );
  }

  @override
  void didReplace({
    Route<dynamic>? newRoute,
    Route<dynamic>? oldRoute,
  }) {
    LogService.i(
      EnumLogType.navigation,
      '路由替換: ${oldRoute?.settings.name ?? '無'} -> ${newRoute?.settings.name ?? '無'}',
    );
  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    LogService.d('用戶開始手勢導航: ${route.settings.name}');
  }

  @override
  void didStopUserGesture() {
    LogService.d('用戶停止手勢導航');
  }
}
