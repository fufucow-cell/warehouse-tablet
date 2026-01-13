import 'package:get/get.dart';

/// 只讀的 Rx 包裝類，防止 view 直接修改 model 的值
/// View 只能讀取 value，無法設值
class RxReadonly<T> {
  final Rx<T> _rx;

  RxReadonly(this._rx);

  /// 獲取當前值（只讀）
  T get value => _rx.value;

  /// 獲取 stream（只讀）
  Stream<T> get stream => _rx.stream;

  /// 獲取用於監聽的 RxInterface（用於 ever、worker 等監聽方法）
  /// ⚠️ 注意：此方法返回的 RxInterface 僅用於監聽，不應該通過此返回值修改值
  RxInterface<T> get rx => _rx;

  @override
  String toString() => value.toString();
}

/// 擴展方法，方便將 Rx 轉換為 RxReadonly
extension RxReadonlyExtension<T> on Rx<T> {
  RxReadonly<T> get readonly => RxReadonly<T>(this);
}
