import 'package:engo_terminal_app3/feature/app/page/main/app_main_page.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/user_login_response_model/user_login_response_model.dart';
import 'package:engo_terminal_app3/wh/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/parent/service/log_service/log_service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'app_service_model.dart';

class AppService extends GetxService implements NavigatorObserver {
  // MARK: - Properties

  final _model = AppServiceModel();
  UserLoginResponseModel? get getUserData => _model.userLoginData;
  BuildContext? get nestedContext => _model.nestedNavigatorKey.currentContext;
  NavigatorState? get nestedNavigator => _model.nestedNavigatorKey.currentState;
  GlobalKey<NavigatorState> get nestedNavigatorKey => _model.nestedNavigatorKey;
  static EnumAppMainRouter get rootRouter => EnumAppMainRouter.defaultRouter;

  // MARK: - Init

  AppService._internal();

  // MARK: - Public Method

  static AppService register() {
    if (Get.isRegistered<AppService>()) {
      return Get.find<AppService>();
    } else {
      final service = AppService._internal();
      Get.put<AppService>(service, permanent: true);
      return service;
    }
  }

  static void unregister() {
    if (Get.isRegistered<AppService>()) {
      final instance = Get.find<AppService>();
      instance._model.routeStack.clear();
      Get.delete<AppService>(force: true);
    }
  }

  static AppService get instance => register();

  void updateUserLoginData(UserLoginResponseModel? data) {
    _model.userLoginData = data;
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
    if (Get.isRegistered<AppService>()) {
      Get.find<AppService>().printRouteStack();
    } else {
      LogService.instance.i(
        EnumLogType.navigation,
        '[Nested] 堆疊狀況: AppService 尚未註冊',
      );
    }
  }

  /// 打印嵌套 Navigator 的堆疊狀況
  void printRouteStack() {
    final navigator = nestedNavigator;
    if (navigator == null) {
      LogService.instance.i(
        EnumLogType.navigation,
        '[Nested] 堆疊狀況: Navigator 尚未初始化',
      );
      return;
    }

    final stackInfo = StringBuffer();
    stackInfo.writeln('═══════════════════════════════════════════════════');
    stackInfo.writeln('[Nested Navigator] 路由堆疊狀況');
    stackInfo.writeln('═══════════════════════════════════════════════════');

    if (_model.routeStack.isEmpty) {
      stackInfo.writeln('堆疊為空');
    } else {
      stackInfo.writeln('堆疊深度: ${_model.routeStack.length}');
      stackInfo.writeln('');
      for (int i = _model.routeStack.length - 1; i >= 0; i--) {
        final routeName = _model.routeStack[i];
        final isTop = i == _model.routeStack.length - 1;
        final prefix = isTop ? '👉 [頂部]' : '   [${_model.routeStack.length - i}]';
        stackInfo.writeln('$prefix $routeName');
      }
    }

    stackInfo.writeln('');
    stackInfo.writeln('Navigator.canPop(): ${navigator.canPop()}');
    stackInfo.writeln('═══════════════════════════════════════════════════');

    LogService.instance.i(EnumLogType.navigation, stackInfo.toString());
  }

  // MARK: - NavigatorObserver

  @override
  NavigatorState? get navigator => null;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = route.settings.name ?? '未知路由';
    _model.routeStack.add(routeName);
    LogService.instance.i(
      EnumLogType.navigation,
      '[Nested] 路由推入: $routeName (前一個路由: ${previousRoute?.settings.name ?? '無'})',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = route.settings.name ?? '未知路由';
    if (_model.routeStack.isNotEmpty && _model.routeStack.last == routeName) {
      _model.routeStack.removeLast();
    }
    LogService.instance.i(
      EnumLogType.navigation,
      '[Nested] 路由彈出: $routeName (前一個路由: ${previousRoute?.settings.name ?? '無'})',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = route.settings.name ?? '未知路由';
    _model.routeStack.remove(routeName);
    LogService.instance.i(
      EnumLogType.navigation,
      '[Nested] 路由移除: $routeName (前一個路由: ${previousRoute?.settings.name ?? '無'})',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final oldRouteName = oldRoute?.settings.name ?? '無';
    final newRouteName = newRoute?.settings.name ?? '未知路由';

    // 替換堆疊頂部的路由
    if (_model.routeStack.isNotEmpty && _model.routeStack.last == oldRouteName) {
      _model.routeStack.removeLast();
    }
    _model.routeStack.add(newRouteName);

    LogService.instance.i(
      EnumLogType.navigation,
      '[Nested] 路由替換: $oldRouteName -> $newRouteName',
    );
  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    LogService.instance.d('[Nested] 用戶開始手勢導航: ${route.settings.name}');
  }

  @override
  void didStopUserGesture() {
    LogService.instance.d('[Nested] 用戶停止手勢導航');
  }
}
