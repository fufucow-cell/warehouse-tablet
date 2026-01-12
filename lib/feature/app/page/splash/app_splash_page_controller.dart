part of 'app_splash_page.dart';

class AppSplashPageController extends GetxController {
  // MARK: - Init

  AppSplashPageController() {
    AppService.register();
    Timer(const Duration(seconds: 2), () {
      routerHandle(EnumAppSplashPageRoute.goToLogin);
    });
  }
}
