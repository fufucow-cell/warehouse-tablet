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
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_read_request_model/warehouse_cabinet_read_request_model.dart';
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
  RxReadonly<List<RoomCabinetInfo>> get allVisibleCabinetsRx => _model.allVisibleCabinets.readonly;
  RxReadonly<List<Room>?> get allCabinetsRx => _model.allRoomCabinets.readonly;

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

  Room? getRoom(WarehouseNameIdModel roomNameId) {
    final allRoomCabinets = _model.allRoomCabinets.value;
    return allRoomCabinets?.firstWhereOrNull((room) => room.roomId == roomNameId.id);
  }

  List<Cabinet> getCabinets(WarehouseNameIdModel roomNameId) {
    final allRoomCabinets = _model.allRoomCabinets.value;
    final room = allRoomCabinets?.firstWhereOrNull((room) {
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
    final allRoomCabinets = _model.allRoomCabinets.value;
    if (allRoomCabinets == null) {
      return 0;
    }
    return allRoomCabinets.fold<int>(
      0,
      (sum, room) => sum + (room.cabinets?.length ?? 0),
    );
  }

  List<WarehouseNameIdModel> getRoomsInfo() {
    final result = List<WarehouseNameIdModel>.from(_service.rooms);
    // 是否有未綁定房間的櫃位
    bool hasNoBindRoomCabinet = _service.getAllRoomCabinets.any((room) => room.roomId == null);

    if (hasNoBindRoomCabinet) {
      result.add(WarehouseNameIdModel(id: '', name: EnumLocale.warehouseUnboundRoom.tr));
    }

    return result;
  }

  // MARK: - Private Method

  Future<void> _checkData() async {
    final allRoomCabinets = _service.allRoomCabinetsRx.value;

    if (allRoomCabinets == null) {
      unawaited(_readCabinets());
    } else {
      _model.allRoomCabinets.value = allRoomCabinets;
      _genAllVisibleCabinets();
    }
  }

  void _genAllVisibleCabinets() {
    final resultCabinets = _service.rooms.map((room) => RoomCabinetInfo(roomId: room.id ?? '', roomName: room.name ?? '', cabinets: [])).toList();
    resultCabinets.add(RoomCabinetInfo(roomId: '', roomName: EnumLocale.warehouseUnboundRoom.tr, cabinets: []));

    for (var room in _model.allRoomCabinets.value ?? []) {
      final roomId = room.roomId ?? '';
      final matchedRoomCabinetInfo = resultCabinets.firstWhereOrNull(
        (roomCabinetInfo) => roomCabinetInfo.roomId == roomId,
      );

      if (matchedRoomCabinetInfo != null && room.cabinets != null) {
        final cabinets = room.cabinets! as List<Cabinet>;
        final cabinetInfos = cabinets.map((cabinet) {
          return CabinetInfo(
            cabinetId: cabinet.id ?? '',
            cabinetName: cabinet.name ?? EnumLocale.warehouseUnboundCabinet.tr,
            quantity: cabinet.quantity ?? 0,
          );
        }).toList();
        matchedRoomCabinetInfo.cabinets.addAll(cabinetInfos);
      }
    }

    resultCabinets.removeWhere(
      (roomCabinetInfo) => roomCabinetInfo.roomId == '' && roomCabinetInfo.cabinets.isEmpty,
    );

    _model.allVisibleCabinets.value = resultCabinets;
  }

  void _addListeners() {
    _model.allRoomCabinetsWorker = ever(_service.allRoomCabinetsRx.rx, (value) {
      _model.allRoomCabinets.value = value;
      _genAllVisibleCabinets();
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
