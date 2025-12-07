import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/app/page/main/app_main_router_constant.dart';
import 'package:flutter_smart_home_tablet/util/log_util.dart';
import 'package:get/get.dart';

class AppMainRouterUtil extends GetxService implements NavigatorObserver {
  // MARK: - Properties

  final GlobalKey<NavigatorState> nestedNavigatorKey =
      GlobalKey<NavigatorState>();
  BuildContext? get nestedContext => nestedNavigatorKey.currentContext;
  NavigatorState? get nestedNavigator => nestedNavigatorKey.currentState;
  static EnumAppMainRouter get rootRouter => EnumAppMainRouter.defaultRouter;

  // 維護路由堆疊列表
  final List<String> _routeStack = [];

  // MARK: - Init

  AppMainRouterUtil._internal();

  // MARK: - Public Method

  static AppMainRouterUtil register() {
    if (Get.isRegistered<AppMainRouterUtil>()) {
      return Get.find<AppMainRouterUtil>();
    }
    final AppMainRouterUtil service = AppMainRouterUtil._internal();
    Get.put<AppMainRouterUtil>(service, permanent: false);
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<AppMainRouterUtil>()) {
      final instance = Get.find<AppMainRouterUtil>();
      instance._routeStack.clear();
      Get.delete<AppMainRouterUtil>(force: true);
    }
  }

  static AppMainRouterUtil get instance {
    if (!Get.isRegistered<AppMainRouterUtil>()) {
      register();
    }
    return Get.find<AppMainRouterUtil>();
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    final router = EnumAppMainRouter.values.firstWhereOrNull(
          (router) => router.path == settings.name,
        ) ??
        rootRouter;

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => router.page(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  /// 使用嵌套 Navigator 导航到指定路由
  Future<T?>? pushNamed<T>(
    String routeName, {
    Object? arguments,
  }) {
    return nestedNavigator?.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// 使用嵌套 Navigator 替换当前路由
  Future<T?>? pushReplacementNamed<T, TO>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return nestedNavigator?.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// 使用嵌套 Navigator 返回上一页
  void pop<T>([T? result]) {
    nestedNavigator?.pop<T>(result);
  }

  /// 检查嵌套 Navigator 是否可以返回
  bool canPop() {
    return nestedNavigator?.canPop() ?? false;
  }

  /// 打印嵌套 Navigator 的堆疊狀況（靜態方法，方便外部調用）
  static void printStack() {
    if (Get.isRegistered<AppMainRouterUtil>()) {
      Get.find<AppMainRouterUtil>().printRouteStack();
    } else {
      LogUtil.i(
        EnumLogType.navigation,
        '[Nested] 堆疊狀況: AppMainRouterUtil 尚未註冊',
      );
    }
  }

  /// 打印嵌套 Navigator 的堆疊狀況
  void printRouteStack() {
    final navigator = nestedNavigator;
    if (navigator == null) {
      LogUtil.i(
        EnumLogType.navigation,
        '[Nested] 堆疊狀況: Navigator 尚未初始化',
      );
      return;
    }

    final stackInfo = StringBuffer();
    stackInfo.writeln('═══════════════════════════════════════════════════');
    stackInfo.writeln('[Nested Navigator] 路由堆疊狀況');
    stackInfo.writeln('═══════════════════════════════════════════════════');

    if (_routeStack.isEmpty) {
      stackInfo.writeln('堆疊為空');
    } else {
      stackInfo.writeln('堆疊深度: ${_routeStack.length}');
      stackInfo.writeln('');
      for (int i = _routeStack.length - 1; i >= 0; i--) {
        final routeName = _routeStack[i];
        final isTop = i == _routeStack.length - 1;
        final prefix = isTop ? '👉 [頂部]' : '   [${_routeStack.length - i}]';
        stackInfo.writeln('$prefix $routeName');
      }
    }

    stackInfo.writeln('');
    stackInfo.writeln('Navigator.canPop(): ${navigator.canPop()}');
    stackInfo.writeln('═══════════════════════════════════════════════════');

    LogUtil.i(EnumLogType.navigation, stackInfo.toString());
  }

  // MARK: - NavigatorObserver

  @override
  NavigatorState? get navigator => null;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = route.settings.name ?? '未知路由';
    _routeStack.add(routeName);
    LogUtil.i(
      EnumLogType.navigation,
      '[Nested] 路由推入: $routeName (前一個路由: ${previousRoute?.settings.name ?? '無'})',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = route.settings.name ?? '未知路由';
    if (_routeStack.isNotEmpty && _routeStack.last == routeName) {
      _routeStack.removeLast();
    }
    LogUtil.i(
      EnumLogType.navigation,
      '[Nested] 路由彈出: $routeName (前一個路由: ${previousRoute?.settings.name ?? '無'})',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = route.settings.name ?? '未知路由';
    _routeStack.remove(routeName);
    LogUtil.i(
      EnumLogType.navigation,
      '[Nested] 路由移除: $routeName (前一個路由: ${previousRoute?.settings.name ?? '無'})',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final oldRouteName = oldRoute?.settings.name ?? '無';
    final newRouteName = newRoute?.settings.name ?? '未知路由';

    // 替換堆疊頂部的路由
    if (_routeStack.isNotEmpty && _routeStack.last == oldRouteName) {
      _routeStack.removeLast();
    }
    _routeStack.add(newRouteName);

    LogUtil.i(
      EnumLogType.navigation,
      '[Nested] 路由替換: $oldRouteName -> $newRouteName',
    );
  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    LogUtil.d('[Nested] 用戶開始手勢導航: ${route.settings.name}');
  }

  @override
  void didStopUserGesture() {
    LogUtil.d('[Nested] 用戶停止手勢導航');
  }
}
