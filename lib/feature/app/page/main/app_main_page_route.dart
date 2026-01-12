part of 'app_main_page.dart';

enum EnumAppMainPageRoute {
  switchContentPage,
  logout,
}

extension AppMainPageRouteExtension on AppMainPageController {
  Future<void> routerHandle(
    EnumAppMainPageRoute type, {
    dynamic data,
  }) async {
    switch (type) {
      case EnumAppMainPageRoute.switchContentPage:
        if (data is EnumAppMainTabItem) {
          final routePath = data.router.path;
          unawaited(AppService.instance.pushReplacementNamed(routePath));
        }
      case EnumAppMainPageRoute.logout:
        await _handleLogout();
    }
  }

  Future<void> _handleLogout() async {
    try {
      // 调用登出 API
      await ApiService.sendRequest<BaseApiResponseModel<void>?>(
        EnumApiInfo.userLogout,
      );

      // 清除本地存储的认证信息
      await StorageService.instance.remove(
        EnumStorageKey.accessToken,
      );
      await StorageService.instance.remove(
        EnumStorageKey.refreshToken,
      );
      await StorageService.instance.remove(EnumStorageKey.account);
      await StorageService.instance.remove(
        EnumStorageKey.isRememberLogin,
      );

      // 跳转到登录页
      unawaited(Get.offAllNamed(EnumRootRouter.login.path));
    } on Object {
      // 其他错误，仍然清除本地存储并跳转
      await StorageService.instance.remove(
        EnumStorageKey.accessToken,
      );
      await StorageService.instance.remove(
        EnumStorageKey.refreshToken,
      );
      await StorageService.instance.remove(EnumStorageKey.account);
      await StorageService.instance.remove(
        EnumStorageKey.isRememberLogin,
      );
      unawaited(Get.offAllNamed(EnumRootRouter.login.path));
    }
  }
}
