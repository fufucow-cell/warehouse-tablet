import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/en_us.dart'
    as en_us;
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/ja_jp.dart'
    as ja_jp;
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/ko_kr.dart'
    as ko_kr;
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/zh_cn.dart'
    as zh_cn;
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/zh_tw.dart'
    as zh_tw;
import 'package:get/get.dart';

class LocaleConstant extends Translations {
  // MARK: - Properties

  static LocaleConstant defaultLocale = enUS;
  final String languageCode;
  final String? countryCode;
  final String displayName;
  final Map<String, String> translationMap;
  static List<LocaleConstant> get getAvalibleLocales {
    return [
      zhTW,
      zhCN,
      enUS,
      jaJP,
      koKR,
    ];
  }

  // MARK: - Init

  LocaleConstant._({
    required this.languageCode,
    this.countryCode,
    required this.displayName,
    this.translationMap = const {},
  });

  /// 系統語言（跟隨系統）
  static final LocaleConstant system = LocaleConstant._(
    languageCode: 'system',
    countryCode: null,
    displayName: '跟隨系統',
    translationMap: {},
  );

  /// 繁體中文
  static final LocaleConstant zhTW = LocaleConstant._(
    languageCode: 'zh',
    countryCode: 'TW',
    displayName: '繁體中文',
    translationMap: zh_tw.zhTW,
  );

  /// 簡體中文
  static final LocaleConstant zhCN = LocaleConstant._(
    languageCode: 'zh',
    countryCode: 'CN',
    displayName: '简体中文',
    translationMap: zh_cn.zhCN,
  );

  /// 英文
  static final LocaleConstant enUS = LocaleConstant._(
    languageCode: 'en',
    countryCode: 'US',
    displayName: 'English',
    translationMap: en_us.enUS,
  );

  /// 日文
  static final LocaleConstant jaJP = LocaleConstant._(
    languageCode: 'ja',
    countryCode: 'JP',
    displayName: '日本語',
    translationMap: ja_jp.jaJP,
  );

  /// 韓文
  static final LocaleConstant koKR = LocaleConstant._(
    languageCode: 'ko',
    countryCode: 'KR',
    displayName: '한국어',
    translationMap: ko_kr.koKR,
  );

  // MARK: - Public Methods

  /// 取得完整的 code（languageCode_countryCode 格式）
  String get code {
    if (countryCode != null) {
      return '${languageCode}_$countryCode';
    }
    return languageCode;
  }

  static LocaleConstant fromCode(String code) {
    final parts = code.split('_');
    final language = parts[0];
    final country = parts.length > 1 ? parts[1] : null;

    final sameLanguage = getAvalibleLocales
        .where((e) => e.languageCode == language)
        .toList();

    if (sameLanguage.isEmpty) {
      return defaultLocale;
    }

    if (country != null) {
      final matchedByCountry =
          sameLanguage.firstWhereOrNull(
        (e) => e.countryCode == country,
      );

      if (matchedByCountry != null) {
        return matchedByCountry;
      }
    }

    return sameLanguage.first;
  }

  /// GetX 多語系配置
  @override
  Map<String, Map<String, String>> get keys {
    final Map<String, Map<String, String>> result = {};

    for (final locale in getAvalibleLocales) {
      String code = locale.languageCode;

      if (locale.countryCode != null) {
        code =
            '${locale.languageCode}_${locale.countryCode}';
      }

      result[code] = locale.translationMap;
    }

    return result;
  }
}
