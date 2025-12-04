import 'package:flutter/material.dart';

/// 語言模式枚舉
enum EnumLocale {
  system('system'),
  zhTW('zh_TW'),
  zhCN('zh_CN'),
  enUS('en_US'),
  jaJP('ja_JP'),
  koKR('ko_KR');

  const EnumLocale(this.code);

  final String code;

  String get displayName => switch (this) {
        EnumLocale.system => '跟隨系統',
        EnumLocale.zhTW => '繁體中文',
        EnumLocale.zhCN => '簡體中文',
        EnumLocale.enUS => 'English',
        EnumLocale.jaJP => '日本語',
        EnumLocale.koKR => '한국어',
      };

  Locale? get locale {
    if (this == system) {
      return null;
    }

    final parts = code.split('_');
    return Locale(parts[0], parts.length > 1 ? parts[1] : null);
  }

  String? get languageCode => locale?.languageCode;
  String? get countryCode => locale?.countryCode;
  static List<EnumLocale> get availableLocales => EnumLocale.values.where((e) => e != EnumLocale.system).toList();
}
