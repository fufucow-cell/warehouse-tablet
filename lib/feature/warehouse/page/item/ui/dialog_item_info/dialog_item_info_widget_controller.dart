import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_info/dialog_item_info_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_item_info_widget_interactive.dart';
part 'dialog_item_info_widget_route.dart';

class DialogItemInfoWidgetController extends GetxController {
  // MARK: - Properties

  final DialogItemInfoWidgetModel _model = DialogItemInfoWidgetModel();
  final _service = WarehouseService.instance;
  Item? get combineItem => _model.combineItem;
  String get getTitle => _model.combineItem?.name ?? '';
  String get getDescription => _model.combineItem?.description ?? '';
  String get getPhoto => _model.combineItem?.photo ?? '';
  String get getMinStockAlert => _model.combineItem?.minStockAlert?.toString() ?? '0';
  String get getCategoryName => _service.convertCategoriesName(_model.combineItem);
  List<DialogItemInfopPositionModel> get getRooms => _model.positions ?? [];

  // MARK: - Init

  DialogItemInfoWidgetController(String itemId) {
    _model.itemId = itemId;
  }

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[DialogItemInfoWidgetController] onInit - $hashCode');
    _loadItemData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[DialogItemInfoWidgetController] onClose - $hashCode');
    super.onClose();
  }

  // MARK: - Private Method

  void _loadItemData() {
    final item = _service.getAllCombineItems.firstWhereOrNull((item) => item.id == _model.itemId);

    if (item == null) {
      return;
    }

    _model.combineItem = item;
    _filterItemFromRoomCabinet();
  }

  // 篩選物品所在的房間與櫥櫃
  void _filterItemFromRoomCabinet() {
    final allRoomCabinetItems = _service.getAllRoomCabinetItems;
    final combineItem = _model.combineItem;
    final result = <DialogItemInfopPositionModel>[];

    if (allRoomCabinetItems.isEmpty || (combineItem?.id?.isEmpty ?? true)) {
      return;
    }

    for (final room in allRoomCabinetItems) {
      if (room.cabinets?.isEmpty ?? true) {
        continue;
      }

      final matchCabinets = <DialogItemInfoCabinetModel>[];

      for (final cabinet in room.cabinets!) {
        if (cabinet.items?.isEmpty ?? true) {
          continue;
        }

        final matchItem = cabinet.items!.where((i) => i.id == combineItem?.id).firstOrNull;

        if (matchItem != null) {
          matchCabinets.add(
            DialogItemInfoCabinetModel(
              cabinetId: cabinet.id ?? '',
              cabinetName: cabinet.name ?? '',
              quantity: matchItem.quantity ?? 0,
            ),
          );
        }
      }

      if (matchCabinets.isNotEmpty) {
        final roomInfo = _service.rooms.where((e) => e.id == room.roomId).firstOrNull;

        result.add(
          DialogItemInfopPositionModel(
            roomId: roomInfo?.id ?? '',
            roomName: roomInfo?.name ?? EnumLocale.warehouseUncategorized.tr,
            cabinets: matchCabinets,
          ),
        );
      }
    }

    _model.positions = result;
  }
}
