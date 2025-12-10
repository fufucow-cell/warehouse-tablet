import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/storage_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_data.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/theme_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_string.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/storage_util.dart';
import 'package:get/get.dart';

/// 主題管理工具類
class ThemeUtil extends GetxService {
  // MARK: - Properties

  final themeVersion = '1.0.0';
  static const _imageRootPath =
      'lib/feature/warehouse/parent/assets/images';
  static const EnumThemeMode _defaultTheme =
      EnumThemeMode.system;
  final _currentTheme = _defaultTheme.obs;
  EnumThemeMode get currentTheme => _currentTheme.value;
  ThemeMode get getCurrentThemeMode =>
      currentTheme.themeMode;
  Color get getLightSeedColor =>
      colorDataMap['brand']!.light;
  Color get getDarkSeedColor => colorDataMap['brand']!.dark;

  // MARK: - Init

  ThemeUtil._internal();

  static ThemeUtil register() {
    if (Get.isRegistered<ThemeUtil>()) {
      return Get.find<ThemeUtil>();
    }
    final ThemeUtil service = ThemeUtil._internal();
    Get.put<ThemeUtil>(service, permanent: true);
    service._readFromStorage();
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<ThemeUtil>()) {
      Get.delete<ThemeUtil>(force: true);
    }
  }

  static ThemeUtil get instance {
    if (!Get.isRegistered<ThemeUtil>()) {
      register();
    }
    return Get.find<ThemeUtil>();
  }

  // MARK: - Public Method

  /// 切換主題模式
  Future<bool> switchFromMode(
    EnumThemeMode newTheme,
  ) async {
    try {
      await _writeToStorage(newTheme);
      _currentTheme.value = newTheme;
      Get.changeThemeMode(getCurrentThemeMode);
      LogUtil.i(
        EnumLogType.storage,
        '切換主題成功: ${newTheme.displayName}',
      );
      return true;
    } on Exception catch (e) {
      LogUtil.e('切換主題失敗', e);
    }

    return false;
  }

  Future<bool> switchFromString(String? strMode) async =>
      switchFromMode(_convertThemeFromString(strMode));

  EnumThemeMode get getThemeFromSystem {
    final platformBrightness = WidgetsBinding
        .instance.platformDispatcher.platformBrightness;
    return platformBrightness == Brightness.dark
        ? EnumThemeMode.dark
        : EnumThemeMode.light;
  }

  /// 取得圖片路徑
  String getImagePath(EnumImage img) {
    final enumName = img.name;
    bool isCommon = enumName[0] == 'c';
    final baseName = enumName.substring(1).toSnakeCase();
    String folderName = '';

    if (isCommon) {
      folderName = 'common';
    } else {
      folderName = switch (currentTheme) {
        EnumThemeMode.system => getThemeFromSystem.name,
        _ => currentTheme.name,
      };
    }

    return '$_imageRootPath/$folderName/$baseName.png';
  }

  /// 取得圖片 Widget
  Widget getImageWidget(
    EnumImage img, {
    Size? size,
    Color? color,
  }) {
    return Image.asset(
      getImagePath(img),
      width: size?.width,
      height: size?.height,
      color: color,
    );
  }

  // MARK: - Private Method

  /// 比對字串主題
  EnumThemeMode _convertThemeFromString(String? str) {
    return EnumThemeMode.values.firstWhereOrNull(
          (e) => e.name == str,
        ) ??
        _defaultTheme;
  }

  /// 讀取主題
  void _readFromStorage() {
    try {
      final savedTheme = StorageUtil.read<String?>(
        EnumStorageKey.theme,
      );
      _currentTheme.value =
          _convertThemeFromString(savedTheme);
      Get.changeThemeMode(getCurrentThemeMode);
      LogUtil.i(
        EnumLogType.storage,
        '載入主題成功: ${currentTheme.displayName}',
      );
    } on Exception catch (e) {
      LogUtil.e('載入主題失敗', e);
    }
  }

  /// 寫入主題
  Future<void> _writeToStorage(
    EnumThemeMode newTheme,
  ) async {
    await StorageUtil.write(
      EnumStorageKey.theme,
      newTheme.name,
    );
  }
}
