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

  @override
  String toString() => value.toString();
}

/// 擴展方法，方便將 Rx 轉換為 RxReadonly
extension RxReadonlyExtension<T> on Rx<T> {
  RxReadonly<T> get readonly => RxReadonly<T>(this);
}
