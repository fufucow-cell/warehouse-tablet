part of 'app_service.dart';

class AppServiceModel {
  UserLoginResponseModel? userLoginData;

  /// Nested navigator key
  final GlobalKey<NavigatorState> nestedNavigatorKey = GlobalKey<NavigatorState>();

  /// 維護路由堆疊列表
  final List<String> routeStack = [];
}
