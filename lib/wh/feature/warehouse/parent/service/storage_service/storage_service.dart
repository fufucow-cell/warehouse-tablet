import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/storage_service/storage_service_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// 本地存儲管理工具類
class StorageService extends GetxService {
  // MARK: - Properties

  final _model = StorageServiceModel();
  static StorageService get instance => Get.find<StorageService>();

  // MARK: - Init

  StorageService._internal() {
    _model.storage = GetStorage();
  }

  /// 註冊
  static Future<void> register() async {
    if (Get.isRegistered<StorageService>()) {
      return;
    }
    await GetStorage.init();
    final StorageService service = StorageService._internal();
    Get.put<StorageService>(service, permanent: true);
  }

  /// 註銷
  static void unregister() {
    if (Get.isRegistered<StorageService>()) {
      Get.delete<StorageService>(force: true);
    }
  }

  // MARK: - Public Method

  /// 讀取數據
  T? read<T>(EnumStorageKey key) {
    try {
      final value = _model.storage.read<T>(key.key);
      LogService.instance.i(
        EnumLogType.storage,
        '讀取: ${key.key} = $value',
      );
      return value;
    } on Exception catch (e) {
      LogService.instance.e('讀取失敗: ${key.key}', e);
      return null;
    }
  }

  /// 寫入數據
  Future<void> write<T>(EnumStorageKey key, T value) async {
    try {
      await _model.storage.write(key.key, value);
      LogService.instance.i(
        EnumLogType.storage,
        '寫入: ${key.key} = $value',
      );
    } on Exception catch (e) {
      LogService.instance.e('寫入失敗: ${key.key} = $value', e);
    }
  }

  /// 刪除數據
  Future<void> remove(EnumStorageKey key) async {
    try {
      await _model.storage.remove(key.key);
      LogService.instance.i(
        EnumLogType.storage,
        '刪除: ${key.key}',
      );
    } on Exception catch (e) {
      LogService.instance.e('刪除失敗: ${key.key}', e);
    }
  }

  /// 清空所有數據
  Future<void> erase() async {
    await _model.storage.erase();
  }
}
