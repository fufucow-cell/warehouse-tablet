import 'dart:async';

import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_create/dialog_cabinet_create_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_create/dialog_cabinet_create_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_edit/dialog_cabinet_edit_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_edit/dialog_cabinet_edit_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/warehouse_cabinet_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/util/cabinet_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/log_service/log_service_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_create_request_model/warehouse_cabinet_create_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_delete_request_model/delete_cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_delete_request_model/warehouse_cabinet_delete_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_read_request_model/warehouse_cabinet_read_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_update_request_model/update_cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_update_request_model/warehouse_cabinet_update_request_model.dart';

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
    LogService.i(
      EnumLogType.debug,
      '[WarehouseCabinetPageController] onInit - $hashCode',
    );
    _addListeners();
    _checkData();
  }

  @override
  void onClose() {
    LogService.i(
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
      _model.allVisibleCabinets.value = _service.getRoomCabinetInfos;
    }
  }

  void _addListeners() {
    _model.allRoomCabinetsWorker = ever(_service.allRoomCabinetsRx.rx, (_) {
      _model.allVisibleCabinets.value = _service.getRoomCabinetInfos;
    });
  }

  Future<bool> _groupCabinets(
    List<DialogCabinetEditOutputModel> outputModel,
  ) async {
    final updateCabinets = outputModel
        .where((e) => !e.isDelete)
        .map(
          (e) => UpdateCabinet(
            cabinetId: e.cabinetId,
            newCabinetName: e.newCabinetName,
            newRoomId: e.newRoomId,
            oldRoomName: CabinetUtil.getRoomNameByCabinetId(e.cabinetId) ?? EnumLocale.warehouseUnboundRoom.tr,
            newRoomName: e.newRoomName,
          ),
        )
        .toList();
    final deleteCabinets = outputModel
        .where((e) => e.isDelete)
        .map(
          (e) => DeleteCabinet(
            cabinetId: e.cabinetId,
            oldRoomName: CabinetUtil.getRoomNameByCabinetId(e.cabinetId) ?? EnumLocale.warehouseUnboundRoom.tr,
          ),
        )
        .toList();
    final results = await Future.wait([
      if (updateCabinets.isNotEmpty) _updateCabinet(updateCabinets),
      if (deleteCabinets.isNotEmpty) _deleteCabinet(deleteCabinets),
    ]);

    if (results.firstOrNull == true || results.lastOrNull == true) {
      unawaited(_readCabinets());
      return true;
    }

    return false;
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
        roomName: outputModel.roomName,
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
    List<UpdateCabinet> models,
  ) async {
    final reqModel = WarehouseCabinetUpdateRequestModel(
      householdId: _service.getHouseholdId,
      cabinets: models,
      userName: _service.userName,
    );

    final response = await _service.apiReqUpdateCabinet(reqModel);
    return response != null;
  }

  Future<bool> _deleteCabinet(
    List<DeleteCabinet> cabinets,
  ) async {
    final reqModel = WarehouseCabinetDeleteRequestModel(
      householdId: _service.getHouseholdId,
      cabinets: cabinets,
      userName: _service.userName,
    );

    final response = await _service.apiReqDeleteCabinet(reqModel);
    return response != null;
  }
}
