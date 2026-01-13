import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/en_us.dart' as en_us;
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/ja_jp.dart' as ja_jp;
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/ko_kr.dart' as ko_kr;
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/zh_cn.dart' as zh_cn;
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/zh_tw.dart' as zh_tw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// LocaleService 狀態模型
class LocaleServiceModel {
  /// 語系版本
  static const String localeVersion = '1.0.0';

  /// 當前語系
  LocaleTranslation currentTranslation = EnumLocaleType.system.model;

  /// 預設語系
  final defaultTranslation = EnumLocaleType.zhTW.model;

  /// 可用的語系
  static final avalibleLocales = [
    EnumLocaleType.zhTW.model,
    EnumLocaleType.zhCN.model,
    EnumLocaleType.enUS.model,
    EnumLocaleType.jaJP.model,
    EnumLocaleType.koKR.model,
  ];
}

/// 語系翻譯類（用於 GetX Translations）
class LocaleTranslation extends Translations {
  // MARK: - Properties

  final String languageCode;
  final String? countryCode;
  final String displayName;
  final Map<String, String> translationMap;

  // MARK: - Init

  LocaleTranslation._({
    required this.languageCode,
    this.countryCode,
    required this.displayName,
    this.translationMap = const {},
  });

  // MARK: - Public Methods

  /// GetX 多語系配置
  @override
  Map<String, Map<String, String>> get keys {
    final Map<String, Map<String, String>> result = {};

    for (final locale in LocaleServiceModel.avalibleLocales) {
      String code = locale.languageCode;

      if (locale.countryCode != null) {
        code = '${locale.languageCode}_${locale.countryCode}';
      }

      result[code] = locale.translationMap;
    }

    return result;
  }

  Locale get getLocale => Locale(languageCode, countryCode);
}

/// 語系類型枚舉
enum EnumLocaleType {
  system,
  zhTW,
  zhCN,
  enUS,
  jaJP,
  koKR;

  /// 獲取對應的 LocaleTranslation 實例
  LocaleTranslation get model {
    return switch (this) {
      EnumLocaleType.system => LocaleTranslation._(
          languageCode: 'system',
          countryCode: null,
          displayName: EnumLocale.languageFollowSystem.tr,
          translationMap: {},
        ),
      EnumLocaleType.zhTW => LocaleTranslation._(
          languageCode: 'zh',
          countryCode: 'TW',
          displayName: '繁體中文',
          translationMap: zh_tw.zhTW,
        ),
      EnumLocaleType.zhCN => LocaleTranslation._(
          languageCode: 'zh',
          countryCode: 'CN',
          displayName: '简体中文',
          translationMap: zh_cn.zhTW,
        ),
      EnumLocaleType.enUS => LocaleTranslation._(
          languageCode: 'en',
          countryCode: 'US',
          displayName: 'English',
          translationMap: en_us.zhTW,
        ),
      EnumLocaleType.jaJP => LocaleTranslation._(
          languageCode: 'ja',
          countryCode: 'JP',
          displayName: '日本語',
          translationMap: ja_jp.zhTW,
        ),
      EnumLocaleType.koKR => LocaleTranslation._(
          languageCode: 'ko',
          countryCode: 'KR',
          displayName: '한국어',
          translationMap: ko_kr.zhTW,
        ),
    };
  }
}
