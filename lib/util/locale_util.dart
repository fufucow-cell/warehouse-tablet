import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/constant/locale_constant.dart';
import 'package:flutter_smart_home_tablet/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/constant/storage_constant.dart';
import 'package:flutter_smart_home_tablet/util/log_util.dart';
import 'package:flutter_smart_home_tablet/util/storage_util.dart';
import 'package:get/get.dart';

/// 語言管理工具類
class LocaleUtil extends GetxService {
  // MARK: - Properties

  static const EnumLocale defaultEnumLocale = EnumLocale.zhTW;
  List<Locale> get supportedLocales => EnumLocale.availableLocales.map((e) => e.locale!).toList();
  final Rx<EnumLocale> _enumLocale = defaultEnumLocale.obs;
  EnumLocale get enumLocale => _enumLocale.value;

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
    service._loadEnumLocale();
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
  Future<void> switchLocale(EnumLocale locale) async {
    try {
      _enumLocale.value = locale;
      await _saveLocale(locale);
      await Get.updateLocale(currentLocale);
      LogUtil.i(
        EnumLogType.userAction,
        '切換語系成功: ${locale.displayName}',
      );
    } on Exception catch (e) {
      LogUtil.e('切換語系失敗', e);
    }
  }

  /// 取得語系
  Locale get currentLocale {
    if (enumLocale == EnumLocale.system) {
      return _matchSystemLocale.locale ?? defaultEnumLocale.locale!;
    }

    return enumLocale.locale ?? defaultEnumLocale.locale!;
  }

  // MARK: - Private Method

  void _loadEnumLocale() {
    try {
      final savedCode = StorageUtil.read<String>(EnumStorageKey.locale.key);
      final enumLocale = savedCode != null && savedCode.isNotEmpty
          ? EnumLocale.values.firstWhereOrNull(
                (e) => e.code == savedCode,
              ) ??
              defaultEnumLocale
          : defaultEnumLocale;
      _enumLocale.value = enumLocale;
      LogUtil.i(
        EnumLogType.storage,
        '載入語系成功: ${enumLocale.displayName}',
      );
    } on Exception catch (e) {
      LogUtil.e('載入語系失敗', e);
    }
  }

  /// 比對系統語系
  EnumLocale get _matchSystemLocale {
    final deviceLocale = Get.deviceLocale;

    if (deviceLocale == null) {
      return defaultEnumLocale;
    }

    final locales = EnumLocale.availableLocales;

    // 先比對 locale code（例如：zh_TW, zh_CN, en_US）
    final matchedByFullCode = locales.firstWhereOrNull(
      (e) => e.code == '${deviceLocale.languageCode}_${deviceLocale.countryCode}',
    );

    if (matchedByFullCode != null) {
      return matchedByFullCode;
    }

    // 再比對 language code
    final matchedByLanguageCode = locales.firstWhereOrNull(
      (e) => e.languageCode == deviceLocale.languageCode,
    );

    if (matchedByLanguageCode != null) {
      return matchedByLanguageCode;
    }

    // 比對不到回傳預設值
    return defaultEnumLocale;
  }

  Future<void> _saveLocale(EnumLocale locale) async {
    try {
      await StorageUtil.write(
        EnumStorageKey.locale.key,
        locale.code,
      );
      LogUtil.i(
        EnumLogType.storage,
        '保存語言成功: ${locale.displayName}',
      );
    } on Exception catch (e) {
      LogUtil.e('保存語言設置到本地存儲失敗', e);
      // 如果保存失敗，忽略錯誤
    }
  }
}
