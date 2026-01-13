import 'package:flutter/foundation.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/log_service/log_service_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/time_util.dart';
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
