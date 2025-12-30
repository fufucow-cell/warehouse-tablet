part of 'app_main_page.dart';

enum EnumAppMainPageRoute {
  switchContentPage,
  showDialog,
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
          unawaited(AppMainRouterUtil.instance.pushReplacementNamed(routePath));
        }
      case EnumAppMainPageRoute.showDialog:
        const CustDialog(
          title: '智管家',
          description: '歡迎使用智管家系統',
        ).show();
      case EnumAppMainPageRoute.logout:
        await _handleLogout();
    }
  }

  Future<void> _handleLogout() async {
    try {
      // 调用登出 API
      await ApiUtil.sendRequest<BaseApiResponseModel<void>?>(
        EnumApiInfo.userLogout,
      );

      // 清除本地存储的认证信息
      await StorageUtil.remove(
        EnumStorageKey.accessToken,
      );
      await StorageUtil.remove(
        EnumStorageKey.refreshToken,
      );
      await StorageUtil.remove(EnumStorageKey.account);
      await StorageUtil.remove(
        EnumStorageKey.isRememberLogin,
      );

      // 跳转到登录页
      unawaited(Get.offAllNamed(EnumRootRouter.login.path));
    } on Object {
      // 其他错误，仍然清除本地存储并跳转
      await StorageUtil.remove(
        EnumStorageKey.accessToken,
      );
      await StorageUtil.remove(
        EnumStorageKey.refreshToken,
      );
      await StorageUtil.remove(EnumStorageKey.account);
      await StorageUtil.remove(
        EnumStorageKey.isRememberLogin,
      );
      unawaited(Get.offAllNamed(EnumRootRouter.login.path));
    }
  }
}
