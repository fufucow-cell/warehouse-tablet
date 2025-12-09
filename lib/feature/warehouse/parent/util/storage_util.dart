import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
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
  static Future<void> register() async {
    if (Get.isRegistered<StorageUtil>()) {
      return;
    }
    await GetStorage.init();
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
  static Future<void> write(
    String key,
    dynamic value,
  ) async {
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
      // 如果 StorageUtil 未註冊，應該在 main 中先調用 register()
      // 這裡不應該調用 register()，因為它是 async 的
      throw Exception(
        'StorageUtil 未初始化，請在 main() 中先調用 StorageUtil.register()',
      );
    }
    return Get.find<StorageUtil>();
  }
}
