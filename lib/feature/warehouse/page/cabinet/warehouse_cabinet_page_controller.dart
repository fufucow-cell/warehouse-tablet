import 'dart:async';

import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_create/dialog_cabinet_create_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_create/dialog_cabinet_create_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_edit/dialog_cabinet_edit_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_edit/dialog_cabinet_edit_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/warehouse_cabinet_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_create_request_model/warehouse_cabinet_create_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_read_request_model/warehouse_cabinet_read_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_update_request_model/request_cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_update_request_model/warehouse_cabinet_update_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_request_model/warehouse_item_request_model.dart';
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
  bool get hasRoom => _service.rooms.isNotEmpty;
  RxReadonly<List<RoomCabinetInfo>?> get allVisibleCabinetsRx => _model.allVisibleCabinets.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(
      EnumLogType.debug,
      '[WarehouseCabinetPageController] onInit - $hashCode',
    );
    _addListeners();
    _checkData();
  }

  @override
  void onClose() {
    LogUtil.i(
      EnumLogType.debug,
      '[WarehouseCabinetPageController] onClose - $hashCode',
    );
    _model.allRoomCabinetsWorker?.dispose();
    super.onClose();
  }

  // MARK: - Public Method

  int getTotalCabinetsCount() {
    final allRoomCabinets = _model.allVisibleCabinets.value ?? [];
    return allRoomCabinets.fold<int>(
      0,
      (sum, room) => sum + (room.cabinets.length),
    );
  }

  // MARK: - Private Method

  Future<void> _checkData() async {
    final allRoomCabinets = _service.allRoomCabinetsRx.value;

    if (allRoomCabinets == null) {
      unawaited(_readCabinets());
    } else {
      _model.allVisibleCabinets.value = _service.roomCabinetInfos;
    }
  }

  void _addListeners() {
    _model.allRoomCabinetsWorker = ever(_service.allRoomCabinetsRx.rx, (_) {
      _model.allVisibleCabinets.value = _service.roomCabinetInfos;
    });
  }

  Future<void> _readCabinets() async {
    unawaited(
      _service.apiReqReadCabinets(
        WarehouseCabinetReadRequestModel(
          householdId: _service.getHouseholdId,
        ),
      ),
    );
  }

  Future<bool> _createCabinet(
    DialogCabinetCreateOutputModel outputModel,
  ) async {
    final response = await _service.apiReqCreateCabinet(
      WarehouseCabinetCreateRequestModel(
        householdId: _service.getHouseholdId,
        roomId: outputModel.roomId,
        name: outputModel.name,
        userName: _service.userName,
      ),
    );

    final isSuccess = response != null;

    if (isSuccess) {
      unawaited(_readCabinets());
    }

    return isSuccess;
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
