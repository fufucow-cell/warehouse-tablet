import 'package:collection/collection.dart';

enum EnumFeatureMap {
  code100(100, 'Warehouse'),
  code101(101, 'Warehouse Item'),
  code102(102, 'Warehouse Cabinet'),
  code103(103, 'Warehouse Category'),
  code104(104, 'Warehouse Record'),
  code105(105, 'Warehouse Alarm');

  const EnumFeatureMap(this.code, this.message);
  final int code;
  final String message;

  /// 根據錯誤代碼獲取錯誤消息
  static String getMessageByCode(int code) {
    return EnumFeatureMap.values
            .firstWhereOrNull(
              (e) => e.code == code,
            )
            ?.message ??
        '';
  }
}
