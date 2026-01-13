import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_string.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/storage_service/storage_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/storage_service/storage_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_data.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 主題管理工具類
class ThemeService extends GetxService {
  // MARK: - Properties

  final _model = ThemeServiceModel();
  EnvironmentService get _envService => EnvironmentService.instance;
  StorageService get _storageService => StorageService.instance;
  EnumThemeMode get currentTheme => _model.currentTheme.value;
  ThemeMode get getCurrentThemeMode => currentTheme.themeMode;
  Color get getLightSeedColor => colorDataMap['brand']!.light;
  Color get getDarkSeedColor => colorDataMap['brand']!.dark;
  static ThemeService get instance => Get.find<ThemeService>();

  // MARK: - Init

  ThemeService._internal();

  static ThemeService register() {
    if (Get.isRegistered<ThemeService>()) {
      return Get.find<ThemeService>();
    }
    final ThemeService service = ThemeService._internal();
    Get.put<ThemeService>(service, permanent: true);
    service._readFromStorage();
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<ThemeService>()) {
      Get.delete<ThemeService>(force: true);
    }
  }

  // MARK: - Public Method

  /// 切換主題模式
  Future<bool> switchFromMode(
    EnumThemeMode newTheme,
  ) async {
    try {
      _model.currentTheme.value = newTheme;
      await _writeToStorage(newTheme);
      LogService.instance.i(
        EnumLogType.storage,
        '切換主題成功: ${newTheme.displayName}',
      );
      return true;
    } on Exception catch (e) {
      LogService.instance.e('切換主題失敗', e);
    }

    return false;
  }

  Future<bool> switchFromString(String? strMode) async => switchFromMode(_convertThemeFromString(strMode));

  EnumThemeMode get getThemeFromSystem {
    final platformBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return platformBrightness == Brightness.dark ? EnumThemeMode.dark : EnumThemeMode.light;
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

    return '${_model.imageRootPath}/$folderName/$baseName.png';
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
      CustSnackBar.show(
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
      CustSnackBar.show(
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
      CustSnackBar.show(
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
      CustSnackBar.show(
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
      CustSnackBar.show(
        title: EnumLocale.errorConvertImageToBase64Failed.tr,
        message: e.toString(),
      );
      return null;
    }
  }

  // MARK: - Private Method

  void _readFromStorage() {
    if (_envService.isModuleMode) {
      return;
    }

    try {
      final String? themeString = _storageService.read<String>(EnumStorageKey.theme);

      if (themeString != null) {
        final savedTheme = _convertThemeFromString(themeString);
        _model.currentTheme.value = savedTheme;

        if (!_envService.isModuleMode) {
          Get.changeThemeMode(getCurrentThemeMode);
        }

        LogService.instance.i(
          EnumLogType.storage,
          '從 Storage 讀取主題: ${savedTheme.displayName}',
        );
      } else {
        // 如果沒有保存的主題，使用默認主題
        _model.currentTheme.value = _model.defaultTheme;
        LogService.instance.i(
          EnumLogType.storage,
          '使用默認主題: ${_model.defaultTheme.displayName}',
        );
      }
    } on Exception catch (e) {
      LogService.instance.e('從 Storage 讀取主題失敗', e);
    }
  }

  /// 寫入主題到 Storage
  Future<void> _writeToStorage(EnumThemeMode theme) async {
    if (_envService.isModuleMode) {
      return;
    }

    try {
      Get.changeThemeMode(getCurrentThemeMode);
      await _storageService.write<String>(EnumStorageKey.theme, theme.name);
      LogService.instance.i(
        EnumLogType.storage,
        '寫入主題到 Storage: ${theme.displayName}',
      );
    } on Exception catch (e) {
      LogService.instance.e('寫入主題到 Storage 失敗', e);
    }
  }

  /// 比對字串主題
  EnumThemeMode _convertThemeFromString(String? str) {
    return EnumThemeMode.values.firstWhereOrNull(
          (e) => e.name == str,
        ) ??
        _model.defaultTheme;
  }
}
