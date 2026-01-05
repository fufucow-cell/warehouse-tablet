import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_history/dialog_item_history_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_info/dialog_item_info_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_record_read_request_model/warehouse_record_read_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_record.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_item_history_widget_interactive.dart';
part 'dialog_item_history_widget_route.dart';

class DialogItemHistoryWidgetController extends GetxController {
  // MARK: - Properties

  final DialogItemHistoryWidgetModel _model = DialogItemHistoryWidgetModel();
  final _service = WarehouseService.instance;
  RxReadonly<List<ItemRecord>?> get recordsRx => _model.records.readonly;
  String get getItemName => _model.combineItem?.name ?? '';
  int get getRecordCount => _model.records.value?.length ?? 0;

  // MARK: - Init

  DialogItemHistoryWidgetController(Item item) {
    _model.combineItem = item;
  }

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[DialogItemHistoryWidgetController] onInit - $hashCode');
    _loadData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[DialogItemHistoryWidgetController] onClose - $hashCode');
    super.onClose();
  }

  // MARK: - Private Methods

  Future<void> _loadData() async {
    final response = await _service.apiReqReadRecord(
      WarehouseRecordReadRequestModel(
        householdId: _service.getHouseholdId,
        itemId: _model.combineItem?.id,
      ),
      onError: (error) {
        _service.showSnackBar(title: '請求失敗', message: '[${error.code}] ${error.message ?? ''}');
      },
    );

    if (response != null) {
      _model.records.value = response;
    }
  }

  // MARK: - Public Methods

  String formatDate(int? timestamp) {
    if (timestamp == null) {
      return '-';
    }
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String genTag(ItemRecord log) {
    final operateType = EnumOperateType.fromInt(log.operateType);

    EnumTagType tagType;
    switch (operateType) {
      case EnumOperateType.create:
        tagType = EnumTagType.createItem;
      case EnumOperateType.update:
        tagType = EnumTagType.updateItem;
      case EnumOperateType.delete:
        tagType = EnumTagType.deleteItem;
      default:
        tagType = EnumTagType.unknown;
    }
    return tagType.title;
  }

  String genContent(ItemRecord log) {
    String result = '';

    if (log.itemName?.length == 1) {
      final newValue = (log.itemName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.itemName!.firstOrNull!;
      return newValue;
    } else if (log.itemName?.length == 2) {
      final oldValue = (log.itemName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.itemName!.firstOrNull!;
      final newValue = (log.itemName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.itemName!.lastOrNull!;
      final str = EnumLocale.warehouseNameUpdate.trArgs([oldValue, newValue]);
      result += str;
    }

    // 處理物品描述
    if (log.itemDescription?.length == 1) {
      final newValue = (log.itemDescription?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUndescribed.tr : log.itemDescription!.firstOrNull!;
      result += result.isEmpty ? '' : '\n';
      result += '${EnumLocale.warehouseDescriptionAdd.tr}: $newValue';
    } else if (log.itemDescription?.length == 2) {
      final oldValue = (log.itemDescription?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUndescribed.tr : log.itemDescription!.firstOrNull!;
      final lastValue = log.itemDescription?.lastOrNull;

      if (lastValue?.isEmpty ?? true) {
        result += result.isEmpty ? '' : '\n';
        result += '${EnumLocale.warehouseDescriptionRemove.tr}: $oldValue';
      } else {
        final newValue = lastValue!;
        result += result.isEmpty ? '' : '\n';
        result += EnumLocale.warehouseDescriptionUpdate.trArgs([oldValue, newValue]);
      }
    }

    // 處理分類
    if (log.categoryName?.length == 1) {
      final newValue = (log.categoryName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : log.categoryName!.firstOrNull!;
      result += result.isEmpty ? '' : '\n';
      result += '${EnumLocale.createCategory.tr}: $newValue';
    } else if (log.categoryName?.length == 2) {
      final oldValue = (log.categoryName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : log.categoryName!.firstOrNull!;
      final lastValue = log.categoryName?.lastOrNull;

      if (lastValue?.isEmpty ?? true) {
        result += result.isEmpty ? '' : '\n';
        result += '${EnumLocale.warehouseCategoryRemove.tr}: $oldValue';
      } else {
        final newValue = lastValue!;
        result += result.isEmpty ? '' : '\n';
        result += EnumLocale.warehouseCategoryUpdate.trArgs([oldValue, newValue]);
      }
    }

    // 處理照片
    if (log.itemPhoto?.length == 1) {
      result += result.isEmpty ? '' : '\n';
      result += EnumLocale.warehousePhotoAdd.tr;
    } else if (log.itemPhoto?.length == 2) {
      final lastPhoto = log.itemPhoto?.lastOrNull;

      if (lastPhoto?.isEmpty ?? true) {
        result += result.isEmpty ? '' : '\n';
        result += EnumLocale.warehousePhotoDelete.tr;
      } else {
        result += result.isEmpty ? '' : '\n';
        result += EnumLocale.warehousePhotoUpdate.tr;
      }
    }

    // 處理最低庫存數量
    if (log.itemMinStockCount?.length == 2) {
      final oldValue = log.itemMinStockCount?.firstOrNull;
      final newValue = log.itemMinStockCount?.lastOrNull;
      result += result.isEmpty ? '' : '\n';
      result += EnumLocale.warehouseMinStockUpdate.trArgs([
        oldValue?.toString() ?? '-',
        newValue?.toString() ?? '-',
      ]);
    }

    return result;
  }
}
