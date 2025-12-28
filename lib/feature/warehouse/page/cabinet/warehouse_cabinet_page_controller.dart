import 'dart:async';

import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_create/dialog_cabinet_create_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_create/dialog_cabinet_create_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_delete/dialog_cabinet_delete_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_delete/dialog_cabinet_delete_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_edit/dialog_cabinet_edit_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_edit/dialog_cabinet_edit_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/warehouse_cabinet_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_request_model/warehouse_cabinet_request_model.dart';
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
  int get getTotalRoomsCount => _service.rooms.length;
  RxReadonly<List<Room>?> get allItemsRx => _model.allRoomCabinetItems.readonly;

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
    final room = allRoomCabinetItems?.firstWhereOrNull((room) {
      if (roomNameId.id?.isEmpty ?? true) {
        if (room.roomId?.isEmpty ?? true) {
          return true;
        }
      }

      return room.roomId == roomNameId.id;
    });
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

  List<WarehouseNameIdModel> getRoomsInfo() {
    final result = List<WarehouseNameIdModel>.from(_service.rooms);
    // 是否有未綁定房間的櫃位
    bool hasNoBindRoomCabinet = _service.getAllRoomCabinetItems.any((room) => room.roomId == null);

    if (hasNoBindRoomCabinet) {
      result.add(WarehouseNameIdModel(id: '', name: '未綁定'));
    }

    return result;
  }

  // MARK: - Private Method

  void _checkData() {
    final allRoomCabinetItems = _service.allRoomCabinetItemsRx.value;

    if (allRoomCabinetItems == null) {
      _readCabinet();
    } else {
      _model.allRoomCabinetItems.value = allRoomCabinetItems;
    }
  }

  Future<bool> _createCabinet(DialogCabinetCreateOutputModel outputModel) async {
    final request = WarehouseCabinetRequestModel(
      homeId: _service.getHouseholdId,
      roomId: outputModel.roomId,
    );

    final response = await _service.apiReqCreateCabinet(request);

    if (response != null) {
      unawaited(_readCabinet());
      return true;
    }

    return false;
  }

  Future<bool> _updateCabinet(DialogCabinetEditOutputModel outputModel, String cabinetId) async {
    final request = WarehouseCabinetRequestModel(
      homeId: _service.getHouseholdId,
      cabinetId: cabinetId,
      roomId: outputModel.roomId,
    );

    final response = await _service.apiReqModifyCabinet(request);

    if (response != null) {
      unawaited(_readCabinet());
      return true;
    }

    return false;
  }

  Future<void> _readCabinet() async {
    final response = await _service.apiReqFetchItems(WarehouseItemRequestModel());

    if (response == null) {
      return;
    }

    _model.allRoomCabinetItems.value = response;
  }

  Future<bool> _deleteCabinet(DialogCabinetDeleteOutputModel outputModel) async {
    final request = WarehouseCabinetRequestModel(
      homeId: _service.getHouseholdId,
      cabinetId: outputModel.cabinetId,
    );

    final response = await _service.apiReqDeleteCabinet(request);

    if (response != null) {
      unawaited(_readCabinet());
      return true;
    }

    return false;
  }
}
