import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_edit/dialog_cabinet_edit_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_cabinet_edit_widget_interactive.dart';
part 'dialog_cabinet_edit_widget_route.dart';

class DialogCabinetEditWidgetController extends GetxController {
  // MARK: - Properties

  final DialogCabinetEditWidgetModel _model = DialogCabinetEditWidgetModel();
  final _service = WarehouseService.instance;
  final nameController = TextEditingController();
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  RxReadonly<String?> get selectedRoomIdRx => _model.selectedRoomId.readonly;

  // MARK: - Init

  DialogCabinetEditWidgetController(Cabinet cabinet) {
    _model.cabinet = cabinet;
  }

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[DialogCabinetEditWidgetController] onInit - $hashCode');
    _checkData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[DialogCabinetEditWidgetController] onClose - $hashCode');
    nameController.dispose();
    super.onClose();
  }

  // MARK: - Public Method

  // 檢查輸出資料
  Future<DialogCabinetEditOutputModel?> checkOutputModel() async {
    final name = nameController.text.trim();
    final roomId = _model.selectedRoomId.value;

    if (name.isEmpty || roomId == null || roomId.isEmpty) {
      return null;
    }

    return DialogCabinetEditOutputModel(
      name: name,
      roomId: roomId,
    );
  }

  List<String> getRoomNameList() {
    return _service.rooms.map((room) => room.name ?? '').toList();
  }

  String? getRoomIdByName(String name) {
    return _service.rooms.firstWhereOrNull((room) => room.name == name)?.id;
  }

  // MARK: - Private Method

  void _setLoadingStatus(bool isLoading) {
    _model.isLoading.value = isLoading;
  }

  void _checkData() {
    final cabinet = _model.cabinet;

    if (cabinet == null) {
      return;
    }

    nameController.text = cabinet.name ?? '';

    // 查找 cabinet 所在的 room
    final allRoomCabinetItems = _service.allRoomCabinetItemsRx.value;
    if (allRoomCabinetItems != null) {
      for (final room in allRoomCabinetItems) {
        final foundCabinet = room.cabinets?.firstWhereOrNull((c) => c.id == cabinet.id);
        if (foundCabinet != null) {
          _model.selectedRoomId.value = room.roomId;
          break;
        }
      }
    }
  }
}
