import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
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
  LogUtil get _logService => LogUtil.instance;
  static const _imageRootPath = 'lib/feature/warehouse/parent/assets/images';
  static const EnumThemeMode _defaultTheme = EnumThemeMode.system;
  final _currentTheme = _defaultTheme.obs;
  EnumThemeMode get currentTheme => _currentTheme.value;
  ThemeMode get getCurrentThemeMode => currentTheme.themeMode;
  Color get getLightSeedColor => colorDataMap['brand']!.light;
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
    final platformBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
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

  /// 將文件轉換為圖片 Widget
  Widget? convertFileToImage(
    String filePath, {
    double? fitWidth,
    double? fitHeight,
  }) {
    try {
      final File file = File(filePath);

      if (!file.existsSync()) {
        return null;
      }

      // 使用 Image.file 創建 Widget
      return Image.file(
        file,
        width: fitWidth,
        height: fitHeight,
        fit: BoxFit.contain,
      );
    } on Object catch (e) {
      _logService.showSnackBar(
        title: EnumLocale.errorReadImageFileFailed.tr,
        message: e.toString(),
      );
      return null;
    }
  }

  /// 壓縮文件，將寬或高較長的一邊 fit 至 100 size，保持寬高比
  Future<String?> compressImageFile(
    String imagePath, {
    int maxSide = 100,
  }) async {
    try {
      final File imageFile = File(imagePath);
      if (!imageFile.existsSync()) {
        return null;
      }

      // 讀取原始圖片數據
      final Uint8List imageBytes = await imageFile.readAsBytes();

      // 先解碼圖片以獲取原始尺寸
      final ui.Codec originalCodec = await ui.instantiateImageCodec(imageBytes);
      final ui.FrameInfo originalFrameInfo = await originalCodec.getNextFrame();
      final ui.Image originalImage = originalFrameInfo.image;
      final int originalWidth = originalImage.width;
      final int originalHeight = originalImage.height;
      originalImage.dispose();

      // 計算目標尺寸，保持寬高比，將較長的一邊 fit 至 100
      int targetWidth;
      int targetHeight;

      if (originalWidth >= originalHeight) {
        // 寬度較長，將寬度設為 100，高度按比例縮放
        targetWidth = maxSide;
        targetHeight = (originalHeight * maxSide / originalWidth).round();
      } else {
        // 高度較長，將高度設為 100，寬度按比例縮放
        targetHeight = maxSide;
        targetWidth = (originalWidth * maxSide / originalHeight).round();
      }

      // 重新解碼並縮放圖片
      final ui.Codec codec = await ui.instantiateImageCodec(
        imageBytes,
        targetWidth: targetWidth,
        targetHeight: targetHeight,
      );

      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ui.Image image = frameInfo.image;

      // 將圖片轉換為 PNG 格式的 byte data
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) {
        image.dispose();
        return null;
      }

      // 創建臨時文件保存壓縮後的圖片
      final String tempPath = '${imagePath}_compressed.png';
      final File compressedFile = File(tempPath);
      await compressedFile.writeAsBytes(byteData.buffer.asUint8List());

      // 釋放圖片資源
      image.dispose();

      return tempPath;
    } on Object catch (e) {
      _logService.showSnackBar(
        title: EnumLocale.errorCompressImageFailed.tr,
        message: e.toString(),
      );
      return null;
    }
  }

  /// 將文件轉換成 base64 字符串
  Future<String?> convertFileToBase64(String filePath) async {
    try {
      final File file = File(filePath);

      if (!file.existsSync()) {
        return null;
      }

      final Uint8List imageBytes = await file.readAsBytes();
      return base64Encode(imageBytes);
    } on Object catch (e) {
      _logService.showSnackBar(
        title: EnumLocale.errorConvertFileToBase64Failed.tr,
        message: e.toString(),
      );
      return null;
    }
  }

  /// 將 base64 字符串轉換為圖片 Widget
  Widget convertBase64ToImage(String base64String) {
    try {
      // 解碼 base64 字符串
      final Uint8List imageBytes = base64Decode(base64String);

      // 使用 Image.memory 創建 Widget
      return Image.memory(
        imageBytes,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: Center(
              child: Icon(
                Icons.error_outline,
                color: Colors.grey[600],
              ),
            ),
          );
        },
      );
    } on Object catch (e) {
      _logService.showSnackBar(
        title: EnumLocale.errorConvertBase64ToImageFailed.tr,
        message: e.toString(),
      );
      return Container(
        color: Colors.grey[300],
        child: Center(
          child: Icon(
            Icons.error_outline,
            color: Colors.grey[600],
          ),
        ),
      );
    }
  }

  /// 將圖片轉換為 base64 字符串
  Future<String?> convertImageToBase64(ui.Image image) async {
    try {
      // 將圖片轉換為 PNG 格式的 byte data
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) {
        return null;
      }

      // 編碼為 base64 字符串
      final Uint8List bytes = byteData.buffer.asUint8List();
      final String base64String = base64Encode(bytes);

      return base64String;
    } on Object catch (e) {
      _logService.showSnackBar(
        title: EnumLocale.errorConvertImageToBase64Failed.tr,
        message: e.toString(),
      );
      return null;
    }
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
      _currentTheme.value = _convertThemeFromString(savedTheme);
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
