part of 'app_main_page.dart';

enum EnumAppMainPageRoute {
  switchContentPage,
  showDialog,
}

extension AppMainPageRouteExtension on AppMainPageController {
  void routerHandle(EnumAppMainPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumAppMainPageRoute.switchContentPage:
        if (data is EnumAppMainTabItem) {
          final routePath = data.router.path;
          AppMainRouterUtil.instance.pushReplacementNamed(routePath);
        }
      case EnumAppMainPageRoute.showDialog:
        const CustDialog(
          title: '智管家',
          description: '歡迎使用智管家系統',
        ).show();
    }
  }
}
