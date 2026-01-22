import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter/foundation.dart';

/// Environment Service Model
class EnvironmentServiceModel {
  /// 倉儲 path
  final warehousePath = 'api/v1/warehouse';

  /// 當前運行環境
  EnumEnvironment currentEnvironment = EnumEnvironment.prd;

  /// 是否為 Module 模式
  bool isModuleMode = false;

  /// 後端網域
  String domainUrl = '';

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

  String get domainUrl {
    return switch (this) {
      EnumEnvironment.dev => 'http://192.168.31.159:8003',
      EnumEnvironment.stg => 'https://warehouseserver-l866q1mqn-fufucows-projects.vercel.app',
      EnumEnvironment.uat => '',
      EnumEnvironment.prd => 'http://tapp.smtengo.com/v1/wh',
    };
  }

  static EnumEnvironment fromString(String? env) {
    return EnumEnvironment.values.firstWhere(
      (e) => e.name == env?.toLowerCase(),
      orElse: () => EnumEnvironment.prd,
    );
  }
}
