import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/constant/storage_constant.dart';
import 'package:flutter_smart_home_tablet/constant/theme_constant.dart';
import 'package:flutter_smart_home_tablet/util/log_util.dart';
import 'package:flutter_smart_home_tablet/util/storage_util.dart';
import 'package:get/get.dart';

/// 主題管理工具類
class ThemeUtil extends GetxService {
  // MARK: - Properties

  static const EnumThemeMode defaultMode = EnumThemeMode.system;
  final Rx<EnumThemeMode> _currentThemeMode = defaultMode.obs;
  EnumThemeMode get currentThemeMode => _currentThemeMode.value;
  ThemeMode get themeMode => currentThemeMode.themeMode;

  // MARK: - Init

  ThemeUtil._internal();

  // MARK: - Public Method

  /// 註冊
  static ThemeUtil register() {
    if (Get.isRegistered<ThemeUtil>()) {
      return Get.find<ThemeUtil>();
    }
    final ThemeUtil service = ThemeUtil._internal();
    Get.put<ThemeUtil>(service, permanent: true);
    service._loadTheme();
    return service;
  }

  /// 註銷
  static void unregister() {
    if (Get.isRegistered<ThemeUtil>()) {
      Get.delete<ThemeUtil>(force: true);
    }
  }

  /// 單例
  static ThemeUtil get instance {
    if (!Get.isRegistered<ThemeUtil>()) {
      register();
    }
    return Get.find<ThemeUtil>();
  }

  /// 切換主題模式
  Future<void> switchTheme(EnumThemeMode mode) async {
    try {
      await StorageUtil.write(
        EnumStorageKey.theme.key,
        mode.name,
      );
      _currentThemeMode.value = mode;
      Get.changeThemeMode(mode.themeMode);
      LogUtil.i(
        EnumLogType.storage,
        '切換主題成功: ${mode.displayName}',
      );
    } on Exception catch (e) {
      LogUtil.e('切換主題失敗', e);
    }
  }

  // MARK: - Private Method

  void _loadTheme() {
    try {
      final savedTheme = StorageUtil.read<String>(EnumStorageKey.theme.key);
      final themeMode = EnumThemeMode.values.firstWhereOrNull(
            (e) => e.name == savedTheme,
          ) ??
          defaultMode;
      _currentThemeMode.value = themeMode;
      LogUtil.i(
        EnumLogType.storage,
        '載入主題成功: ${themeMode.displayName}',
      );
    } on Exception catch (e) {
      LogUtil.e('載入主題失敗', e);
    }
  }
}
