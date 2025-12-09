import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locale_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/storage_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/storage_util.dart';
import 'package:get/get.dart';

class LocaleUtil extends GetxService {
  // MARK: - Properties

  final localeVersion = '1.0.0';
  LocaleConstant get getDefaultTranslations =>
      LocaleConstant.defaultLocale;
  LocaleConstant _currentLocale =
      LocaleConstant.defaultLocale;
  LocaleConstant _systemLocale =
      LocaleConstant.defaultLocale;
  List<Locale> get getSupportedLocales =>
      LocaleConstant.getAvalibleLocales
          .map(
            (e) => e.countryCode != null
                ? Locale(e.languageCode, e.countryCode)
                : Locale(e.languageCode),
          )
          .toList();
  Locale get getDefaultLocale {
    final defaultLocale = LocaleConstant.defaultLocale;
    return defaultLocale.countryCode != null
        ? Locale(
            defaultLocale.languageCode,
            defaultLocale.countryCode,
          )
        : Locale(defaultLocale.languageCode);
  }

  // MARK: - Init

  LocaleUtil._internal();

  // MARK: - Public Method

  /// 註冊
  static LocaleUtil register() {
    if (Get.isRegistered<LocaleUtil>()) {
      return Get.find<LocaleUtil>();
    }
    final LocaleUtil service = LocaleUtil._internal();
    Get.put<LocaleUtil>(service, permanent: true);
    service._genSystemLocale();
    service._readFromStorage();
    return service;
  }

  /// 註銷
  static void unregister() {
    if (Get.isRegistered<LocaleUtil>()) {
      Get.delete<LocaleUtil>(force: true);
    }
  }

  /// 單例
  static LocaleUtil get instance {
    if (!Get.isRegistered<LocaleUtil>()) {
      register();
    }
    return Get.find<LocaleUtil>();
  }

  /// 切換語系
  Future<bool> switchLocale(
    LocaleConstant newLocale,
  ) async {
    try {
      await _saveToStorage(newLocale);
      _currentLocale = newLocale;
      await Get.updateLocale(getCurrentLocale);
      return true;
    } on Exception catch (e) {
      LogUtil.e('切換語系失敗', e);
      return false;
    }
  }

  Locale get getCurrentLocale {
    final localeConstant =
        (_currentLocale == LocaleConstant.system)
            ? _systemLocale
            : _currentLocale;
    return localeConstant.countryCode != null
        ? Locale(
            localeConstant.languageCode,
            localeConstant.countryCode,
          )
        : Locale(localeConstant.languageCode);
  }

  // MARK: - Private Method

  /// 比對系統語系
  void _genSystemLocale() {
    final deviceLocale = Get.deviceLocale;

    if (deviceLocale == null) {
      _systemLocale = LocaleConstant.defaultLocale;
    } else {
      final deviceCode = deviceLocale.countryCode != null
          ? '${deviceLocale.languageCode}_${deviceLocale.countryCode}'
          : deviceLocale.languageCode;

      _systemLocale = LocaleConstant.fromCode(deviceCode);
    }
  }

  void _readFromStorage() {
    try {
      final savedCode = StorageUtil.read<String>(
        EnumStorageKey.locale.key,
      );

      if (savedCode != null && savedCode.isNotEmpty) {
        if (savedCode == 'system') {
          _currentLocale = LocaleConstant.system;
        } else {
          _currentLocale =
              LocaleConstant.fromCode(savedCode);
        }
        LogUtil.i(
          EnumLogType.storage,
          '載入用戶語系: ${_currentLocale.displayName}',
        );
        return;
      }
    } on Exception catch (e) {
      LogUtil.e('載入語系失敗', e);
    }

    // 如果沒有保存的 code 或載入失敗，使用系統語系
    _currentLocale = LocaleConstant.system;
    LogUtil.i(
      EnumLogType.storage,
      '使用系統語系: ${_currentLocale.displayName}',
    );
  }

  /// 保存語言設置到存儲
  Future<void> _saveToStorage(LocaleConstant locale) async {
    // 如果是系統語言，保存 'system'，否則保存完整的 code
    final codeToSave = locale == LocaleConstant.system
        ? 'system'
        : locale.code;
    await StorageUtil.write(
      EnumStorageKey.locale.key,
      codeToSave,
    );
    LogUtil.i(
      EnumLogType.storage,
      '保存語言成功: ${locale.displayName}',
    );
  }

  /// 取得當前選擇的語言（不包括系統匹配的結果）
  LocaleConstant get currentSelectedLocale =>
      _currentLocale;
}
