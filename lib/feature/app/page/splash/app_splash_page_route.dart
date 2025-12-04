part of 'app_splash_page.dart';

enum EnumAppSplashPageRoute {
  goToLogin,
}

extension AppSplashPageRouteExtension on AppSplashPageController {
  void routerHandle(EnumAppSplashPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumAppSplashPageRoute.goToLogin:
        Get.offNamed(EnumRootRouter.login.path);
        break;
    }
  }
}
