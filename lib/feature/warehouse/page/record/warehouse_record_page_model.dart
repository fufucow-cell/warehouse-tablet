part of 'warehouse_record_page.dart';

class WarehouseRecordPageModel {
  List<Log>? logs;
  List<Log>? allLogs; // 保存所有原始日志数据
  final isEditMode = false.obs;
  final selectedLogIds = <String>{}.obs;
  DateTime? startDate;
  DateTime? endDate;
  EnumOperateType? filterOperateType;
  EnumEntityType? filterEntityType;
}

enum EnumLogType {
  unknown,
  general,
  alarm;

  String get title => switch (this) {
        EnumLogType.unknown => '未知',
        EnumLogType.general => '一般',
        EnumLogType.alarm => '告警',
      };

  static EnumLogType fromInt(int? value) {
    if (value == null) return EnumLogType.unknown;
    return switch (value) {
      1 => EnumLogType.general,
      2 => EnumLogType.alarm,
      _ => EnumLogType.unknown,
    };
  }
}

enum EnumOperateType {
  unknown,
  create,
  update,
  delete;

  String get title => switch (this) {
        EnumOperateType.unknown => '未知',
        EnumOperateType.create => '創建',
        EnumOperateType.update => '更新',
        EnumOperateType.delete => '刪除',
      };

  static EnumOperateType fromInt(int? value) {
    if (value == null) {
      return EnumOperateType.unknown;
    }
    return switch (value) {
      1 => EnumOperateType.create,
      2 => EnumOperateType.update,
      3 => EnumOperateType.delete,
      _ => EnumOperateType.unknown,
    };
  }
}

enum EnumEntityType {
  unknown,
  cabinet,
  item;

  String get title => switch (this) {
        EnumEntityType.unknown => '未知',
        EnumEntityType.cabinet => '櫃子',
        EnumEntityType.item => '物品',
      };

  static EnumEntityType fromInt(int? value) {
    if (value == null) {
      return EnumEntityType.unknown;
    }
    return switch (value) {
      1 => EnumEntityType.item,
      2 => EnumEntityType.cabinet,
      _ => EnumEntityType.unknown,
    };
  }
}
