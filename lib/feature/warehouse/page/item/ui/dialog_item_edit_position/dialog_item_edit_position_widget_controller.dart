import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_position/dialog_item_edit_position_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_item_edit_position_widget_interactive.dart';
part 'dialog_item_edit_position_widget_route.dart';

class DialogItemEditPositionWidgetController extends GetxController {
  // MARK: - Properties

  final DialogItemEditPositionWidgetModel _model = DialogItemEditPositionWidgetModel();
  final _service = WarehouseService.instance;

  RxReadonly<String?> get itemNameRx => _model.itemName.readonly;
  RxReadonly<int?> get currentQuantityRx => _model.currentQuantity.readonly;
  RxReadonly<List<DialogItemEditPositionLocationModel>> get locationsRx => _model.locations.readonly;

  // MARK: - Init

  DialogItemEditPositionWidgetController(String itemId) {
    _model.itemId = itemId;
  }

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[DialogItemEditPositionWidgetController] onInit - $hashCode');
    _loadData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[DialogItemEditPositionWidgetController] onClose - $hashCode');
    super.onClose();
  }

  // MARK: - Public Methods

  List<String> getRoomNameList() {
    return _service.rooms.map((room) => room.name ?? '').where((name) => name.isNotEmpty).toList();
  }

  List<String> getCabinetsForRoom(String? roomName) {
    if (roomName == null) return [];

    // 通过房间名称找到对应的 roomId
    final roomModel = _service.rooms.where((r) => r.name == roomName).firstOrNull;
    if (roomModel?.id == null) return [];

    // 通过 roomId 找到对应的 Room 对象
    final room = _service.getAllRoomCabinetItems
        .where(
          (room) => room.roomId == roomModel!.id,
        )
        .firstOrNull;
    return room?.cabinets?.map((cabinet) => cabinet.name ?? '').where((name) => name.isNotEmpty).toList() ?? [];
  }

  // MARK: - Private Methods

  void _loadData() {
    final item = _service.getAllCombineItems.firstWhereOrNull((item) => item.id == _model.itemId);

    if (item == null) {
      return;
    }

    _model.itemName.value = item.name;
    _loadLocations(item);
  }

  void _loadLocations(Item item) {
    final allRoomCabinetItems = _service.getAllRoomCabinetItems;
    final locations = <DialogItemEditPositionLocationModel>[];
    final itemId = item.id;

    if (allRoomCabinetItems.isNotEmpty && (itemId != null && itemId.isNotEmpty)) {
      for (final room in allRoomCabinetItems) {
        if (room.cabinets?.isEmpty ?? true) {
          continue;
        }

        for (final cabinet in room.cabinets!) {
          if (cabinet.items?.isEmpty ?? true) {
            continue;
          }

          final matchItem = cabinet.items!.where((i) => i.id == itemId).firstOrNull;

          if (matchItem != null) {
            final roomInfo = _service.rooms.where((e) => e.id == room.roomId).firstOrNull;
            final roomName = roomInfo?.name ?? '';
            final cabinetName = cabinet.name ?? '';
            final locationName = cabinetName.isNotEmpty ? '$roomName / $cabinetName' : roomName;
            final locationId = '${room.roomId}_${cabinet.id ?? ''}';

            locations.add(
              DialogItemEditPositionLocationModel(
                locationId: locationId,
                locationName: locationName,
                quantity: matchItem.quantity ?? 0,
              ),
            );
          }
        }
      }
    }

    final currentQuantity = locations.fold<int>(0, (sum, location) => sum + location.quantity);
    _model.currentQuantity.value = currentQuantity;
    _model.locations.value = locations;
  }
}
