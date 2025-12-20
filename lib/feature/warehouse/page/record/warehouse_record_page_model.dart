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

  EnumLocale get titleLocale => switch (this) {
        EnumLogType.unknown => EnumLocale.warehouseLogTypeUnknown,
        EnumLogType.general => EnumLocale.warehouseLogTypeGeneral,
        EnumLogType.alarm => EnumLocale.warehouseLogTypeAlarm,
      };

  String get title => titleLocale.tr;

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

  EnumLocale get titleLocale => switch (this) {
        EnumOperateType.unknown => EnumLocale.warehouseOperateTypeUnknown,
        EnumOperateType.create => EnumLocale.warehouseOperateTypeCreate,
        EnumOperateType.update => EnumLocale.warehouseOperateTypeUpdate,
        EnumOperateType.delete => EnumLocale.warehouseOperateTypeDelete,
      };

  String get title => titleLocale.tr;

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

  EnumLocale get titleLocale => switch (this) {
        EnumEntityType.unknown => EnumLocale.warehouseEntityTypeUnknown,
        EnumEntityType.cabinet => EnumLocale.warehouseEntityTypeCabinet,
        EnumEntityType.item => EnumLocale.warehouseEntityTypeItem,
      };

  String get title => titleLocale.tr;

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
