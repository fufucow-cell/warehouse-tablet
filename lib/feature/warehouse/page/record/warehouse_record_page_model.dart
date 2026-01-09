import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/util/record_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:get/get.dart';

class WarehouseRecordPageModel {
  final allLogs = Rxn<List<CombineRecord>>();
  final visibleLogs = Rx<List<CombineRecord>>([]);
  final isShowFilterMenu = false.obs;
  final filterType = Rx<EnumFilterType>(EnumFilterType.all);
  final columnRatio = [170, 705, 280, 280];
}

enum EnumFilterType {
  today,
  lastWeek,
  all;

  String get title => switch (this) {
        EnumFilterType.today => EnumLocale.warehouseFilterDateToday.tr,
        EnumFilterType.lastWeek => EnumLocale.warehouseFilterDateLastWeek.tr,
        EnumFilterType.all => EnumLocale.all.tr,
      };

  DateTime? get startDate => switch (this) {
        EnumFilterType.today => DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
        EnumFilterType.lastWeek =>
          DateTime.now().subtract(const Duration(days: 7)),
        EnumFilterType.all => null,
      };

  static EnumFilterType fromString(String? value) {
    return EnumFilterType.values.firstWhereOrNull((e) => e.title == value) ??
        EnumFilterType.all;
  }
}

enum EnumOperateType {
  unknown,
  create,
  update,
  delete;

  EnumLocale get titleLocale => switch (this) {
        EnumOperateType.unknown => EnumLocale.unknown,
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
    return EnumOperateType.values
            .firstWhereOrNull((e) => e.index - 1 == value) ??
        EnumOperateType.unknown;
  }
}

enum EnumEntityType {
  unknown,
  cabinet,
  itemNormal,
  category,
  itemQuantity,
  itemPosition;

  String get title => switch (this) {
        EnumEntityType.unknown => EnumLocale.unknown.tr,
        EnumEntityType.cabinet => EnumLocale.warehouseEntityTypeCabinet.tr,
        EnumEntityType.itemNormal => EnumLocale.item.tr,
        EnumEntityType.category => EnumLocale.category.tr,
        EnumEntityType.itemQuantity => EnumLocale.item.tr,
        EnumEntityType.itemPosition => EnumLocale.item.tr,
      };

  static EnumEntityType fromInt(int? value) {
    return EnumEntityType.values
            .firstWhereOrNull((e) => e.index - 1 == value) ??
        EnumEntityType.unknown;
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
        EnumTagType.unknown => EnumLocale.unknown.tr,
        EnumTagType.createItem => EnumLocale.createItem.tr,
        EnumTagType.createCabinet =>
          EnumLocale.warehouseTagTypeCreateCabinet.tr,
        EnumTagType.createCategory => EnumLocale.createCategory.tr,
        EnumTagType.updateItem => EnumLocale.warehouseTagTypeUpdateItem.tr,
        EnumTagType.updateCabinet =>
          EnumLocale.warehouseTagTypeUpdateCabinet.tr,
        EnumTagType.updateCategory =>
          EnumLocale.warehouseTagTypeUpdateCategory.tr,
        EnumTagType.updateQuantity =>
          EnumLocale.warehouseTagTypeUpdateQuantity.tr,
        EnumTagType.updatePosition => EnumLocale.editPosition.tr,
        EnumTagType.deleteItem => EnumLocale.warehouseTagTypeDeleteItem.tr,
        EnumTagType.deleteCabinet =>
          EnumLocale.warehouseTagTypeDeleteCabinet.tr,
        EnumTagType.deleteCategory => EnumLocale.deleteCategory.tr,
      };

  static EnumTagType fromInt(int? value) {
    return EnumTagType.values.firstWhereOrNull((e) => e.index == value) ??
        EnumTagType.unknown;
  }

  EnumOperateType get operateType => switch (this) {
        EnumTagType.createItem => EnumOperateType.create,
        EnumTagType.createCabinet => EnumOperateType.create,
        EnumTagType.createCategory => EnumOperateType.create,
        EnumTagType.updateItem => EnumOperateType.update,
        EnumTagType.updateCabinet => EnumOperateType.update,
        EnumTagType.updateCategory => EnumOperateType.update,
        EnumTagType.updateQuantity => EnumOperateType.update,
        EnumTagType.updatePosition => EnumOperateType.update,
        EnumTagType.deleteItem => EnumOperateType.delete,
        EnumTagType.deleteCabinet => EnumOperateType.delete,
        EnumTagType.deleteCategory => EnumOperateType.delete,
        _ => EnumOperateType.unknown,
      };
}
