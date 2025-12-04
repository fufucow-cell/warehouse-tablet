part of 'app_login_page.dart';

enum EnumAppLoginPageInteractive {
  tapLogin,
  tapRegister,
  tapPasswordVisibility,
}

/// AppLoginPage 用户事件处理扩展
extension AppLoginPageUserEventExtension on AppLoginPageController {
  /// 处理用户事件
  void interactive(EnumAppLoginPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumAppLoginPageInteractive.tapLogin:
        _prepareToCallApi(isLogin: true);
      case EnumAppLoginPageInteractive.tapRegister:
        _prepareToCallApi(isLogin: false);
      case EnumAppLoginPageInteractive.tapPasswordVisibility:
        _togglePasswordVisibility();
    }
  }
}
