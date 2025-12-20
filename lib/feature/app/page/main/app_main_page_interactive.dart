part of 'app_main_page.dart';

enum EnumAppMainPageInteractive {
  selectItem,
  tapTitleWidget,
  tapLogout,
}

/// AppMainPage 用户事件处理扩展
extension AppMainPageUserEventExtension on AppMainPageController {
  /// 处理用户事件
  void interactive(
    EnumAppMainPageInteractive type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumAppMainPageInteractive.selectItem:
        if (data is EnumAppMainTabItem) {
          _selectItem(data);
        }
      case EnumAppMainPageInteractive.tapTitleWidget:
        routerHandle(EnumAppMainPageRoute.showDialog);
      case EnumAppMainPageInteractive.tapLogout:
        routerHandle(EnumAppMainPageRoute.logout);
    }
  }
}
