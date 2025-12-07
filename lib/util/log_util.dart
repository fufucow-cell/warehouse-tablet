import 'package:flutter/foundation.dart';
import 'package:flutter_smart_home_tablet/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/util/time_util.dart';
import 'package:get/get.dart';

/// 日誌管理工具類
class LogUtil extends GetxService {
  // MARK: - Properties

  /// 是否啟用日誌
  bool _enableLog = kDebugMode;
  bool get enableLog => _enableLog;

  // MARK: - Init

  LogUtil._internal();

  // MARK: - Public Method

  /// 註冊
  static void register() {
    if (Get.isRegistered<LogUtil>()) {
      return;
    }
    final LogUtil service = LogUtil._internal();
    Get.put<LogUtil>(service, permanent: true);
  }

  /// 註銷
  static void unregister() {
    if (Get.isRegistered<LogUtil>()) {
      Get.delete<LogUtil>(force: true);
    }
  }

  /// 設置是否啟用日誌
  static void setEnableLog(bool enable) {
    _instance._enableLog = enable && kDebugMode;
  }

  /// 打印調試資訊
  static void d(
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    _log(EnumLogType.debug, message, error, stackTrace);
  }

  /// 打印錯誤資訊
  static void e(
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    _log(EnumLogType.error, message, error, stackTrace);
  }

  /// 打印一般資訊
  static void i(EnumLogType type, String message) {
    _log(type, message);
  }

  // MARK: - Private Method

  /// 實例化
  static LogUtil get _instance {
    if (!Get.isRegistered<LogUtil>()) {
      register();
    }
    return Get.find<LogUtil>();
  }

  /// 打印日誌
  static void _log(
    EnumLogType type,
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    if (!_instance.enableLog && !type.enable) {
      return;
    }

    final timestamp = TimeUtil.getTaipeiTimeString();

    if (error != null) {
      if (stackTrace != null) {
        debugPrint(
          '[$timestamp] [$type.displayName] $message\n$error\n$stackTrace',
        );
      } else {
        debugPrint('[$timestamp] [$type.displayName] $message\n$error');
      }
    } else {
      debugPrint('[$timestamp] [$type.displayName] $message');
    }
  }
}
