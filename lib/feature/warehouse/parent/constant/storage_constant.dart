import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_string.dart';

enum EnumStorageKey {
  locale,
  theme,
  account,
  accessToken,
  refreshToken,
  isRememberLogin;

  /// 存儲鍵
  String get key => name.toSnakeCase();

  /// 顯示名稱
  String get displayName => switch (this) {
        EnumStorageKey.locale => '用戶語系',
        EnumStorageKey.theme => '主題模式',
        EnumStorageKey.account => '帳號',
        EnumStorageKey.accessToken => '訪問令牌',
        EnumStorageKey.refreshToken => '刷新令牌',
        EnumStorageKey.isRememberLogin => '記住登入狀態',
      };
}
