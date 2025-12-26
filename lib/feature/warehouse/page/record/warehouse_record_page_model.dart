part of 'warehouse_record_page.dart';

class WarehouseRecordPageModel {
  final allLogs = Rxn<List<ItemRecord>>();
  final visibleLogs = Rx<List<ItemRecord>>([]);
  final isShowFilterMenu = false.obs;
  final filterType = Rx<EnumFilterType>(EnumFilterType.all);
  final columnRatio = [170, 705, 280, 280];
  final avatarUrl = 'https://cdn.vectorstock.com/i/500p/29/53/gray-silhouette-avatar-for-male-profile-picture-vector-56412953.jpg';
}

enum EnumFilterType {
  today,
  lastWeek,
  all;

  String get title => switch (this) {
        EnumFilterType.today => EnumLocale.warehouseFilterDateToday.tr,
        EnumFilterType.lastWeek => EnumLocale.warehouseFilterDateLastWeek.tr,
        EnumFilterType.all => EnumLocale.warehouseFilterDateAll.tr,
      };

  DateTime? get startDate => switch (this) {
        EnumFilterType.today => DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
        EnumFilterType.lastWeek => DateTime.now().subtract(const Duration(days: 7)),
        EnumFilterType.all => null,
      };

  static EnumFilterType fromString(String? value) {
    return EnumFilterType.values.firstWhereOrNull((e) => e.title == value) ?? EnumFilterType.all;
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

  Color get tagTextColor => switch (this) {
        EnumOperateType.create => EnumColor.accentGreen.color,
        EnumOperateType.update => EnumColor.accentBlue.color,
        EnumOperateType.delete => EnumColor.accentRed.color,
        _ => EnumColor.textPrimary.color,
      };

  Color get tagBgColor => switch (this) {
        EnumOperateType.create => EnumColor.backgroundAccentGreen.color,
        EnumOperateType.update => EnumColor.backgroundAccentBlue.color,
        EnumOperateType.delete => EnumColor.backgroundAccentRed.color,
        _ => Colors.transparent,
      };

  static EnumOperateType fromInt(int? value) {
    return EnumOperateType.values.firstWhereOrNull((e) => e.index == value) ?? EnumOperateType.unknown;
  }
}

enum EnumEntityType {
  unknown,
  cabinet,
  category,
  item;

  String get title => switch (this) {
        EnumEntityType.unknown => EnumLocale.warehouseEntityTypeUnknown.tr,
        EnumEntityType.cabinet => EnumLocale.warehouseEntityTypeCabinet.tr,
        EnumEntityType.category => EnumLocale.warehouseCategory.tr,
        EnumEntityType.item => EnumLocale.warehouseEntityTypeItem.tr,
      };

  static EnumEntityType fromInt(int? value) {
    return EnumEntityType.values.firstWhereOrNull((e) => e.index == value) ?? EnumEntityType.unknown;
  }
}

enum EnumTagType {
  unknown,
  createItem,
  createCabinet,
  createCategory,
  updateItem,
  updateCabinet,
  updateCategory,
  updateQuantity,
  updatePosition,
  deleteItem,
  deleteCabinet,
  deleteCategory;

  String get title => switch (this) {
        EnumTagType.unknown => EnumLocale.warehouseTagTypeUnknown.tr,
        EnumTagType.createItem => EnumLocale.warehouseTagTypeCreateItem.tr,
        EnumTagType.createCabinet => EnumLocale.warehouseTagTypeCreateCabinet.tr,
        EnumTagType.createCategory => EnumLocale.warehouseTagTypeCreateCategory.tr,
        EnumTagType.updateItem => EnumLocale.warehouseTagTypeUpdateItem.tr,
        EnumTagType.updateCabinet => EnumLocale.warehouseTagTypeUpdateCabinet.tr,
        EnumTagType.updateCategory => EnumLocale.warehouseTagTypeUpdateCategory.tr,
        EnumTagType.updateQuantity => EnumLocale.warehouseTagTypeUpdateQuantity.tr,
        EnumTagType.updatePosition => EnumLocale.warehouseTagTypeUpdatePosition.tr,
        EnumTagType.deleteItem => EnumLocale.warehouseTagTypeDeleteItem.tr,
        EnumTagType.deleteCabinet => EnumLocale.warehouseTagTypeDeleteCabinet.tr,
        EnumTagType.deleteCategory => EnumLocale.warehouseTagTypeDeleteCategory.tr,
      };

  static EnumTagType fromInt(int? value) {
    return EnumTagType.values.firstWhereOrNull((e) => e.index == value) ?? EnumTagType.unknown;
  }
}
