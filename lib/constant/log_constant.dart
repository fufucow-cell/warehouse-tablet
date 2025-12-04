/// 日誌分類枚舉
enum EnumLogType {
  debug,
  error,
  apiRequest,
  apiResponse,
  navigation,
  userAction,
  storage;

  bool get enable => switch (this) {
        EnumLogType.debug => true,
        EnumLogType.error => true,
        EnumLogType.apiRequest => true,
        EnumLogType.apiResponse => true,
        EnumLogType.navigation => true,
        EnumLogType.userAction => true,
        EnumLogType.storage => true,
      };

  String get displayName => switch (this) {
        EnumLogType.debug => '調試',
        EnumLogType.error => '錯誤',
        EnumLogType.apiRequest => 'API 請求',
        EnumLogType.apiResponse => 'API 回應',
        EnumLogType.navigation => '導航',
        EnumLogType.userAction => '用戶操作',
        EnumLogType.storage => '本地資料',
      };
}
