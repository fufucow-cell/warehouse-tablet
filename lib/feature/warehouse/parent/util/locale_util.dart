import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locale_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/storage_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/storage_util.dart';
import 'package:get/get.dart';

class LocaleUtil extends GetxService {
  // MARK: - Properties

  final localeVersion = '1.0.0';
  LocaleTranslation _currentTranslation = LocaleTranslation.system;
  LocaleTranslation get currentTranslation => _currentTranslation;
  LocaleTranslation _systemTranslation = LocaleTranslation.defaultTranslation;
  LocaleTranslation get getDefaultTranslation =>
      LocaleTranslation.defaultTranslation;
  Locale get getCurrentLocale =>
      _convertLocaleFromTranslation(currentTranslation);
  String get getCurrentLocaleCode => _convertCodeFromLocale(getCurrentLocale);
  Locale get getDefaultLocale => _convertLocaleFromTranslation(
        LocaleTranslation.defaultTranslation,
      );

  // MARK: - Init

  LocaleUtil._internal();

  static Future<LocaleUtil> register() async {
    if (Get.isRegistered<LocaleUtil>()) {
      return Get.find<LocaleUtil>();
    }
    final LocaleUtil service = LocaleUtil._internal();
    Get.put<LocaleUtil>(service, permanent: true);
    service._genSystemLocale();
    await service._readFromStorage();
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<LocaleUtil>()) {
      Get.delete<LocaleUtil>(force: true);
    }
  }

  static LocaleUtil get instance {
    if (!Get.isRegistered<LocaleUtil>()) {
      register();
    }
    return Get.find<LocaleUtil>();
  }

  // MARK: - Public Method

  Future<bool> switchFromTranslation(
    LocaleTranslation newTranslation,
  ) async {
    try {
      await _saveToStorage(newTranslation);
      _currentTranslation = newTranslation;
      final locale = getCurrentLocale;
      EnumLocale.setCurrentTranslation(_convertTranslationFromLocale(locale));
      await Get.updateLocale(locale);
      return true;
    } on Exception catch (e) {
      LogUtil.e('切換語系失敗', e);
    }

    return false;
  }

  Future<bool> switchFromCode(
    String code,
  ) async =>
      switchFromTranslation(
        _convertTranslationfromCode(code),
      );

  Future<bool> switchFromLocale(
    Locale locale,
  ) async =>
      switchFromTranslation(
        _convertTranslationFromLocale(locale),
      );

  List<Locale> get getSupportedLocales {
    return LocaleTranslation.getAvalibleLocales
        .map(
          (e) => e.countryCode != null
              ? Locale(e.languageCode, e.countryCode)
              : Locale(e.languageCode),
        )
        .toList();
  }

  // MARK: - Private Method

  /// 比對系統語系
  void _genSystemLocale() {
    final deviceLocale = Get.deviceLocale;

    if (deviceLocale == null) {
      _systemTranslation = LocaleTranslation.defaultTranslation;
    } else {
      final translation = _convertTranslationFromLocale(deviceLocale);

      if (translation == LocaleTranslation.system) {
        _systemTranslation = LocaleTranslation.defaultTranslation;
      } else {
        _systemTranslation = translation;
      }
    }
  }

  String _convertCodeFromLocale(Locale locale) {
    if (locale.countryCode != null) {
      return '${locale.languageCode}_${locale.countryCode}';
    }
    return locale.languageCode;
  }

  Locale _convertLocaleFromTranslation(
    LocaleTranslation translation,
  ) {
    if (translation == LocaleTranslation.system) {
      return _systemTranslation.countryCode != null
          ? Locale(
              _systemTranslation.languageCode,
              _systemTranslation.countryCode,
            )
          : Locale(_systemTranslation.languageCode);
    }

    return translation.countryCode != null
        ? Locale(
            translation.languageCode,
            translation.countryCode,
          )
        : Locale(translation.languageCode);
  }

  LocaleTranslation _convertTranslationFromLocale(
    Locale locale,
  ) {
    final code = _convertCodeFromLocale(locale);
    return _convertTranslationfromCode(code);
  }

  LocaleTranslation _convertTranslationfromCode(
    String? code,
  ) {
    if (code == null || code.isEmpty) {
      return LocaleTranslation.system;
    }

    // 處理 system 特殊值
    if (code == 'system') {
      return LocaleTranslation.system;
    }

    final parts = code.split('_');
    final language = parts[0];
    final country = parts.length > 1 ? parts[1] : null;
    final sameLanguage = LocaleTranslation.getAvalibleLocales
        .where((e) => e.languageCode == language)
        .toList();

    if (sameLanguage.isEmpty) {
      return LocaleTranslation.defaultTranslation;
    }

    if (country != null) {
      final matchedByCountry = sameLanguage.firstWhereOrNull(
        (e) => e.countryCode == country,
      );

      if (matchedByCountry != null) {
        return matchedByCountry;
      }
    }

    return sameLanguage.first;
  }

  /// 從存儲中讀取語言設置
  Future<void> _readFromStorage() async {
    try {
      final savedCode = StorageUtil.read<String?>(
        EnumStorageKey.locale,
      );
      _currentTranslation = _convertTranslationfromCode(savedCode);
      final locale = getCurrentLocale;
      EnumLocale.setCurrentTranslation(_convertTranslationFromLocale(locale));
      await Get.updateLocale(locale);
      LogUtil.i(
        EnumLogType.storage,
        '載入用戶語系: ${currentTranslation.displayName}',
      );
    } on Exception catch (e) {
      LogUtil.e('載入語系失敗', e);
    }
  }

  /// 保存語言設置到存儲
  Future<void> _saveToStorage(
    LocaleTranslation newTranslation,
  ) async {
    // 保存完整的 languageCode，包括 'system' 特殊值
    final codeToSave = newTranslation == LocaleTranslation.system
        ? 'system'
        : newTranslation.languageCode;
    await StorageUtil.write(
      EnumStorageKey.locale,
      codeToSave,
    );
  }
}
