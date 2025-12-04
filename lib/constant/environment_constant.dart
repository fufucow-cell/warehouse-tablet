/// 從 launch.json 讀取環境參數的 key
const String launchEnvironmentKey = 'ENVIRONMENT';

/// 預設環境
const String defaultEnvironment = 'dev';

/// 運行環境
///
/// 定義應用的運行環境類型
enum EnumEnvironment {
  dev,
  stg,
  uat,
  prd;

  String get displayName => switch (this) {
        EnumEnvironment.dev => '開發環境',
        EnumEnvironment.stg => '測試環境',
        EnumEnvironment.uat => '預發布環境',
        EnumEnvironment.prd => '生產環境',
      };

  String get apiBaseUrl {
    return switch (this) {
      EnumEnvironment.dev => 'http://localhost:8000',
      EnumEnvironment.stg => '',
      EnumEnvironment.uat => '',
      EnumEnvironment.prd => '',
    };
  }
}

