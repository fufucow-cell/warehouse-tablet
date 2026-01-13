import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter/foundation.dart';

/// Environment Service Model
class EnvironmentServiceModel {
  /// 當前運行環境
  EnumEnvironment currentEnvironment = EnumEnvironment.prd;

  /// 是否為 Module 模式
  bool isModuleMode = false;

  /// 從 launch.json 讀取環境參數的 key
  final launchEnvironmentKey = 'ENVIRONMENT';

  /// 預設環境
  String defaultEnvironment = EnumEnvironment.dev.name;

  /// 調試模式判斷
  bool get isDebugMode => kDebugMode;
}

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
      EnumEnvironment.dev => 'http://127.0.0.1:8000',
      EnumEnvironment.stg => '',
      EnumEnvironment.uat => '',
      EnumEnvironment.prd => '',
    };
  }

  static EnumEnvironment fromString(String? env) {
    return EnumEnvironment.values.firstWhere(
      (e) => e.name == env?.toLowerCase(),
      orElse: () => EnumEnvironment.prd,
    );
  }
}
