import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';

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
        EnumEnvironment.dev => EnumLocale.environmentDev.tr,
        EnumEnvironment.stg => EnumLocale.environmentStg.tr,
        EnumEnvironment.uat => EnumLocale.environmentUat.tr,
        EnumEnvironment.prd => EnumLocale.environmentPrd.tr,
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
