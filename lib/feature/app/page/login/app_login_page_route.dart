part of 'app_login_page.dart';

enum EnumAppLoginPageRoute {
  goToMainPage,
  showLoginFail,
  showRegisterFail,
}

extension AppLoginPageRouteExtension on AppLoginPageController {
  Future<void> routerHandle(
    EnumAppLoginPageRoute type, {
    dynamic data,
  }) async {
    switch (type) {
      case EnumAppLoginPageRoute.goToMainPage:
        await Get.offAllNamed(EnumRootRouter.main.path);
      case EnumAppLoginPageRoute.showLoginFail:
        final message = data is String ? data : '';
        Get.snackbar(
          '登入失敗',
          message,
          snackPosition: SnackPosition.BOTTOM,
        );
      case EnumAppLoginPageRoute.showRegisterFail:
        final message = data is String ? data : '';
        Get.snackbar(
          '註冊失敗',
          message,
          snackPosition: SnackPosition.BOTTOM,
        );
    }
  }
}
