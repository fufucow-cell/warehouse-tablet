import 'package:flutter_smart_home_tablet/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/util/log_util.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// 本地存儲管理工具類
class StorageUtil extends GetxService {
  // MARK: - Properties

  /// GetStorage 物件
  late final GetStorage _storage;

  // MARK: - Init

  StorageUtil._internal() {
    _storage = GetStorage();
  }

  // MARK: - Public Method

  /// 註冊
  static void register() {
    if (Get.isRegistered<StorageUtil>()) {
      return;
    }
    final StorageUtil service = StorageUtil._internal();
    Get.put<StorageUtil>(service, permanent: true);
  }

  /// 註銷
  static void unregister() {
    if (Get.isRegistered<StorageUtil>()) {
      Get.delete<StorageUtil>(force: true);
    }
  }

  /// 讀取數據
  static T? read<T>(String key) {
    try {
      final value = _instance._storage.read<T>(key);
      LogUtil.i(
        EnumLogType.storage,
        '讀取: $key = $value',
      );
      return value;
    } on Exception catch (e) {
      LogUtil.e('讀取失敗: $key', e);
      return null;
    }
  }

  /// 寫入數據
  static Future<void> write(String key, dynamic value) async {
    try {
      await _instance._storage.write(key, value);
      LogUtil.i(
        EnumLogType.storage,
        '寫入: $key = $value',
      );
    } on Exception catch (e) {
      LogUtil.e('寫入失敗: $key = $value', e);
    }
  }

  /// 刪除數據
  static Future<void> remove(String key) async {
    try {
      await _instance._storage.remove(key);
      LogUtil.i(
        EnumLogType.storage,
        '刪除: $key',
      );
    } on Exception catch (e) {
      LogUtil.e('刪除失敗: $key', e);
    }
  }

  // MARK: - Private Method

  /// 單例
  static StorageUtil get _instance {
    if (!Get.isRegistered<StorageUtil>()) {
      register();
    }
    return Get.find<StorageUtil>();
  }
}
