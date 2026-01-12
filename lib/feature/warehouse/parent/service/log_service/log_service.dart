import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/log_service/log_service_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/time_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

/// 日誌管理工具類
class LogService extends GetxService {
  // MARK: - Properties

  final _model = LogServiceModel();
  static LogService get instance => Get.find<LogService>();

  // MARK: - Init

  LogService._internal();

  static void register() {
    if (Get.isRegistered<LogService>()) {
      return;
    }
    final LogService service = LogService._internal();
    Get.put<LogService>(service, permanent: true);
  }

  static void unregister() {
    if (Get.isRegistered<LogService>()) {
      Get.delete<LogService>(force: true);
    }
  }

  // MARK: - Public Method

  void showSnackBar({required String title, required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.all(16.0),
        isDismissible: true,
        shouldIconPulse: false,
        titleText: const SizedBox.shrink(),
        messageText: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 50.0.scale,
                vertical: 20.0.scale,
              ),
              decoration: BoxDecoration(
                color: EnumColor.backgroundSecondary.color,
                borderRadius: BorderRadius.circular(20.0.scale),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.0.scale,
                    offset: Offset(0, 10.0.scale),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetUtil.textWidget(
                    title,
                    size: 32.0.scale,
                    weightType: EnumFontWeightType.bold,
                  ),
                  if (message.isNotEmpty) ...[
                    SizedBox(height: 16.0.scale),
                    WidgetUtil.textWidget(
                      message,
                      size: 28.0.scale,
                      color: EnumColor.textSecondary.color,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void setEnableLog(bool enable) {
    instance._model.enableLog = enable && kDebugMode;
  }

  /// 打印調試資訊
  static void d(
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    instance._log(EnumLogType.debug, message, error, stackTrace);
  }

  /// 打印錯誤資訊
  static void e(
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    instance._log(EnumLogType.error, message, error, stackTrace);
  }

  /// 打印一般資訊
  static void i(EnumLogType type, String message) {
    instance._log(type, message);
  }

  // MARK: - Private Method

  /// 打印日誌
  void _log(
    EnumLogType type,
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    if (!_model.enableLog && !type.enable) {
      return;
    }

    final timestamp = TimeUtil.getTaipeiTimeString();

    if (error != null) {
      if (stackTrace != null) {
        debugPrint(
          '[$timestamp] [${type.displayName}] $message\n$error\n$stackTrace',
        );
      } else {
        debugPrint('[$timestamp] [${type.displayName}] $message\n$error');
      }
    } else {
      debugPrint('[$timestamp] [${type.displayName}] $message');
    }
  }
}
