import 'package:engo_terminal_app3/feature/app/page/login/app_login_page.dart';
import 'package:engo_terminal_app3/feature/app/page/main/app_main_page.dart';
import 'package:engo_terminal_app3/feature/app/page/splash/app_splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Router Service Model
class RouterServiceModel {
  /// Root navigator key
  final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
}

enum EnumRootRouter {
  splash,
  login,
  main;

  static const EnumRootRouter rootRouter = splash;

  String get path {
    if (this == rootRouter) {
      return '/';
    }
    return '/app_$name';
  }

  GetPage<dynamic> get page => GetPage<dynamic>(
        name: path,
        page: () => switch (this) {
          splash => const AppSplashPage(),
          login => const AppLoginPage(),
          main => const AppMainPage(),
        },
      );

  static List<GetPage<dynamic>> get pages => EnumRootRouter.values.map((e) => e.page).toList();
}
