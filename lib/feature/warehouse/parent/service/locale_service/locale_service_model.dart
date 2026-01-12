import 'package:get/get.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/en_us.dart' as en_us;
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/ja_jp.dart' as ja_jp;
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/ko_kr.dart' as ko_kr;
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/zh_cn.dart' as zh_cn;
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/zh_tw.dart' as zh_tw;

/// 語系版本
final localeVersion = '1.0.0';

class LocaleTranslation extends Translations {
  // MARK: - Properties

  static LocaleTranslation defaultTranslation = enUS;
  final String languageCode;
  final String? countryCode;
  final String displayName;
  final Map<String, String> translationMap;
  static List<LocaleTranslation> get getAvalibleLocales {
    return [
      zhTW,
      zhCN,
      enUS,
      jaJP,
      koKR,
    ];
  }

  // MARK: - Init

  LocaleTranslation._({
    required this.languageCode,
    this.countryCode,
    required this.displayName,
    this.translationMap = const {},
  });

  /// 系統語言（跟隨系統）
  static LocaleTranslation get system {
    return LocaleTranslation._(
      languageCode: 'system',
      countryCode: null,
      displayName: EnumLocale.languageFollowSystem.tr,
      translationMap: {},
    );
  }

  /// 繁體中文
  static final LocaleTranslation zhTW = LocaleTranslation._(
    languageCode: 'zh',
    countryCode: 'TW',
    displayName: '繁體中文',
    translationMap: zh_tw.zhTW,
  );

  /// 簡體中文
  static LocaleTranslation get zhCN {
    return LocaleTranslation._(
      languageCode: 'zh',
      countryCode: 'CN',
      displayName: EnumLocale.languageSimplifiedChinese.tr,
      translationMap: zh_cn.zhTW,
    );
  }

  /// 英文
  static final LocaleTranslation enUS = LocaleTranslation._(
    languageCode: 'en',
    countryCode: 'US',
    displayName: 'English',
    translationMap: en_us.zhTW,
  );

  /// 日文
  static final LocaleTranslation jaJP = LocaleTranslation._(
    languageCode: 'ja',
    countryCode: 'JP',
    displayName: '日本語',
    translationMap: ja_jp.zhTW,
  );

  /// 韓文
  static final LocaleTranslation koKR = LocaleTranslation._(
    languageCode: 'ko',
    countryCode: 'KR',
    displayName: '한국어',
    translationMap: ko_kr.zhTW,
  );

  // MARK: - Public Methods

  /// GetX 多語系配置
  @override
  Map<String, Map<String, String>> get keys {
    final Map<String, Map<String, String>> result = {};

    for (final locale in getAvalibleLocales) {
      String code = locale.languageCode;

      if (locale.countryCode != null) {
        code = '${locale.languageCode}_${locale.countryCode}';
      }

      result[code] = locale.translationMap;
    }

    return result;
  }
}
