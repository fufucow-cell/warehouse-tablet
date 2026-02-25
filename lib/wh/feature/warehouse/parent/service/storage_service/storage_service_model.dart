import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_string.dart';
import 'package:get_storage/get_storage.dart';

/// Storage Service Model
class StorageServiceModel {
  /// GetStorage 物件
  late final GetStorage storage;
}

enum EnumStorageKey {
  locale,
  theme,
  account,
  accessToken,
  refreshToken,
  isRememberLogin,
  airConditionerSettings;

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
        EnumStorageKey.airConditionerSettings => '空調設定',
      };
}
