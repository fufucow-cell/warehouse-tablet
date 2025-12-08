import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/constant/root_router_constant.dart';
import 'package:flutter_smart_home_tablet/util/log_util.dart';
import 'package:get/get.dart';

class RouterUtil extends GetxService
    implements NavigatorObserver {
  // MARK: - Properties

  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  BuildContext? get rootContext =>
      rootNavigatorKey.currentContext;
  NavigatorState? get rootNavigator =>
      rootNavigatorKey.currentState;
  String get initRouterPath => EnumRootRouter.splash.path;
  List<GetPage<dynamic>> get getRouterPages =>
      EnumRootRouter.pages;

  // MARK: - Init

  RouterUtil._internal();

  // MARK: - Public Method

  static RouterUtil register() {
    if (Get.isRegistered<RouterUtil>()) {
      return Get.find<RouterUtil>();
    }
    final RouterUtil service = RouterUtil._internal();
    Get.put<RouterUtil>(service, permanent: true);
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<RouterUtil>()) {
      Get.delete<RouterUtil>(force: true);
    }
  }

  static RouterUtil get instance {
    if (!Get.isRegistered<RouterUtil>()) {
      register();
    }
    return Get.find<RouterUtil>();
  }

  // MARK: - NavigatorObserver

  @override
  NavigatorState? get navigator => null;

  @override
  void didPush(
      Route<dynamic> route, Route<dynamic>? previousRoute) {
    LogUtil.i(
      EnumLogType.navigation,
      '路由推入: ${route.settings.name} (前一個路由: ${previousRoute?.settings.name ?? '無'})',
    );
  }

  @override
  void didPop(
      Route<dynamic> route, Route<dynamic>? previousRoute) {
    LogUtil.i(
      EnumLogType.navigation,
      '路由彈出: ${route.settings.name} (前一個路由: ${previousRoute?.settings.name ?? '無'})',
    );
  }

  @override
  void didRemove(
      Route<dynamic> route, Route<dynamic>? previousRoute) {
    LogUtil.i(
      EnumLogType.navigation,
      '路由移除: ${route.settings.name} (前一個路由: ${previousRoute?.settings.name ?? '無'})',
    );
  }

  @override
  void didReplace(
      {Route<dynamic>? newRoute,
      Route<dynamic>? oldRoute}) {
    LogUtil.i(
      EnumLogType.navigation,
      '路由替換: ${oldRoute?.settings.name ?? '無'} -> ${newRoute?.settings.name ?? '無'}',
    );
  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    LogUtil.d('用戶開始手勢導航: ${route.settings.name}');
  }

  @override
  void didStopUserGesture() {
    LogUtil.d('用戶停止手勢導航');
  }
}
