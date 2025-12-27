import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/warehouse_cabinet_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/dialog_cabinet_create.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_request_model/warehouse_item_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/room.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'warehouse_cabinet_page_interactive.dart';
part 'warehouse_cabinet_page_route.dart';

class WarehouseCabinetPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseCabinetPageModel();
  final _service = WarehouseService.instance;
  RxReadonly<List<Room>?> get allItemsRx => _model.allRoomCabinetItems.readonly;
  List<WarehouseNameIdModel> get getRoomsInfo => _service.rooms;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[WarehouseCabinetPageController] onInit - $hashCode');
    _checkData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[WarehouseCabinetPageController] onClose - $hashCode');
    super.onClose();
  }

  // MARK: - Public Method

  Room? getRoom(WarehouseNameIdModel roomNameId) {
    final allRoomCabinetItems = _model.allRoomCabinetItems.value;
    return allRoomCabinetItems?.firstWhereOrNull((room) => room.roomId == roomNameId.id);
  }

  List<Cabinet> getCabinets(WarehouseNameIdModel roomNameId) {
    final allRoomCabinetItems = _model.allRoomCabinetItems.value;
    final room = allRoomCabinetItems?.firstWhereOrNull((room) => room.roomId == roomNameId.id);
    return room?.cabinets ?? <Cabinet>[];
  }

  int getTotalCabinetsCount() {
    final allRoomCabinetItems = _model.allRoomCabinetItems.value;
    if (allRoomCabinetItems == null) {
      return 0;
    }
    return allRoomCabinetItems.fold<int>(
      0,
      (sum, room) => sum + (room.cabinets?.length ?? 0),
    );
  }

  // MARK: - Private Method

  void _checkData() {
    final allRoomCabinetItems = _service.allRoomCabinetItemsRx.value;

    if (allRoomCabinetItems == null) {
      _queryApiData();
    } else {
      _model.allRoomCabinetItems.value = allRoomCabinetItems;
    }
  }

  Future<void> _queryApiData() async {
    final response = await _service.apiReqFetchItems(WarehouseItemRequestModel());

    if (response == null) {
      return;
    }

    _model.allRoomCabinetItems.value = response;
  }
}
