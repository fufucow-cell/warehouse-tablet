part of 'app_splash_page.dart';

class AppSplashPageController extends BasePageController {
  // MARK: - Init

  AppSplashPageController() {
    super.init(isCallApiWhenInit: false);
    Timer(const Duration(seconds: 2), () {
      routerHandle(EnumAppSplashPageRoute.goToLogin);
    });
  }
}
