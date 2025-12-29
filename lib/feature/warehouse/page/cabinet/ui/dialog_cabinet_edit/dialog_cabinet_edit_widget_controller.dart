import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_edit/dialog_cabinet_edit_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/dialog_message_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_cabinet_edit_widget_interactive.dart';
part 'dialog_cabinet_edit_widget_route.dart';

class DialogCabinetEditWidgetController extends GetxController {
  // MARK: - Properties

  final DialogCabinetEditWidgetModel _model = DialogCabinetEditWidgetModel();
  final _service = WarehouseService.instance;
  WarehouseNameIdModel get getRoom => _model.room!;
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  RxReadonly<List<EditModel>> get editModelsRx => _model.editModels.readonly;
  List<EditModel> get getEditModels => _model.editModels.value;

  // MARK: - Init

  DialogCabinetEditWidgetController(WarehouseNameIdModel room) {
    _model.room = room;
  }

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(
      EnumLogType.debug,
      '[DialogCabinetEditWidgetController] onInit - $hashCode',
    );
    _checkData();
  }

  @override
  void onClose() {
    LogUtil.i(
      EnumLogType.debug,
      '[DialogCabinetEditWidgetController] onClose - $hashCode',
    );
    for (var model in _model.editModels.value) {
      model.textController.dispose();
    }
    super.onClose();
  }

  // MARK: - Public Method

  // 檢查輸出資料
  Future<List<DialogCabinetEditOutputModel>?> checkOutputModel() async {
    List<DialogCabinetEditOutputModel> result = [];

    for (EditModel model in _model.editModels.value) {
      final textController = model.textController;
      final newName = textController.text.trim();

      if (newName.isEmpty) {
        return null;
      }

      final newRoom = model.newRoom;
      final hasNewName = newName != model.oldCabinet.name;
      if (newRoom != null || hasNewName || model.isDelete) {
        result.add(
          DialogCabinetEditOutputModel(
            cabinetId: model.oldCabinet.id!,
            isDelete: model.isDelete,
            newCabinetName: hasNewName ? newName : null,
            newRoomId: newRoom?.id,
          ),
        );
      }
    }

    return result;
  }

  List<String> getRoomNameList({bool isExcludeOldRoomName = false}) {
    if (isExcludeOldRoomName) {
      return _service.rooms.where((room) => room.name != getRoom.name).map((room) => room.name ?? '').toList();
    }

    return _service.rooms.map((room) => room.name ?? '').toList();
  }

  String? getRoomIdByName(String name) {
    return _service.rooms.firstWhereOrNull((room) => room.name == name)?.id;
  }

  Future<bool> showDeleteHint() async {
    final deleteCabnites = getEditModels.where((editModel) => editModel.isDelete).toList();

    if (deleteCabnites.isNotEmpty) {
      final isConfirm = await _routerHandle<bool>(
        EnumDialogCabinetEditWidgetRoute.showDialogDeleteHint,
        data: _genDeleteHintMessage(deleteCabnites),
      );
      return isConfirm ?? true;
    }

    return true;
  }

  // MARK: - Private Method

  void _setLoadingStatus(bool isLoading) {
    _model.isLoading.value = isLoading;
  }

  void _checkData() {
    final cabinets = _service.getAllRoomCabinetItems.firstWhereOrNull((e) {
          if ((_model.room?.id?.isEmpty ?? true) && (e.roomId?.isEmpty ?? true)) {
            return true;
          }

          return e.roomId == _model.room?.id;
        })?.cabinets ??
        [];

    if (cabinets.isEmpty) {
      return;
    }

    _model.editModels.value = cabinets
        .map(
          (e) => EditModel(
            oldCabinet: WarehouseNameIdModel(
              id: e.id,
              name: e.name,
            ),
            textController: TextEditingController(text: e.name),
          ),
        )
        .toList();
  }

  void _updateEditModels(ChangeRoomModel model) {
    final copyEditModels = List<EditModel>.from(_model.editModels.value);
    final editModel = model.editModel;
    final newRoomName = model.newRoomName ?? '';
    final newRoomId = getRoomIdByName(newRoomName);

    if (newRoomId != null) {
      editModel.newRoom = WarehouseNameIdModel(id: newRoomId, name: newRoomName);
    }

    _model.editModels.value = copyEditModels;
  }

  String _genDeleteHintMessage(List<EditModel> editModels) {
    final names = editModels.map((editModel) => editModel.oldCabinet.name).map((e) => '「$e」').join(', ');
    return EnumLocale.editCabinetDeleteMultipleMessage.trArgs([names]);
  }
}
