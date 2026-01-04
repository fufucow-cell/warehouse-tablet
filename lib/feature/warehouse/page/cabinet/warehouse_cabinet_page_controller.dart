import 'dart:async';

import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_create/dialog_cabinet_create_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_create/dialog_cabinet_create_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_edit/dialog_cabinet_edit_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_edit/dialog_cabinet_edit_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/warehouse_cabinet_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_create_request_model/warehouse_cabinet_create_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_update_request_model/request_cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_update_request_model/warehouse_cabinet_update_request_model.dart';
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
  Worker? _allRoomCabinetItemsWorker;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(
      EnumLogType.debug,
      '[WarehouseCabinetPageController] onInit - $hashCode',
    );
    _checkData();
    _addListeners();
  }

  @override
  void onClose() {
    LogUtil.i(
      EnumLogType.debug,
      '[WarehouseCabinetPageController] onClose - $hashCode',
    );
    _allRoomCabinetItemsWorker?.dispose();
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
      result.add(WarehouseNameIdModel(id: '', name: EnumLocale.warehouseUnbound.tr));
    }

    return result;
  }

  // MARK: - Private Method

  Future<void> _checkData() async {
    final allRoomCabinetItems = _service.allRoomCabinetItemsRx.value;

    if (allRoomCabinetItems == null) {
      final response = await _service.apiReqReadItems(WarehouseItemRequestModel());

      if (response != null) {
        _model.allRoomCabinetItems.value = response;
      }
    } else {
      _model.allRoomCabinetItems.value = allRoomCabinetItems;
    }
  }

  void _addListeners() {
    _allRoomCabinetItemsWorker = ever(_service.allRoomCabinetItemsRx.rx, (value) {
      _model.allRoomCabinetItems.value = value;
    });
  }

  Future<bool> _createCabinet(
    DialogCabinetCreateOutputModel outputModel,
  ) async {
    final request = WarehouseCabinetCreateRequestModel(
      householdId: _service.getHouseholdId,
      roomId: outputModel.roomId,
    );

    final response = await _service.apiReqCreateCabinet(request);

    if (response != null) {
      unawaited(_service.apiReqReadItems(WarehouseItemRequestModel()));
      return true;
    }

    return false;
  }

  Future<bool> _updateCabinet(
    List<DialogCabinetEditOutputModel> outputModel,
  ) async {
    final reqModel = WarehouseCabinetUpdateRequestModel(
      householdId: _service.getHouseholdId,
      cabinets: outputModel
          .map(
            (e) => RequestCabinet(
              cabinetId: e.cabinetId,
              newRequestCabinetName: e.newCabinetName,
              newRoomId: e.newRoomId,
              isDelete: e.isDelete,
            ),
          )
          .toList(),
    );

    final response = await _service.apiReqUpdateCabinet(reqModel);

    if (response != null) {
      unawaited(_service.apiReqReadItems(WarehouseItemRequestModel()));
      return true;
    }

    return false;
  }
}
