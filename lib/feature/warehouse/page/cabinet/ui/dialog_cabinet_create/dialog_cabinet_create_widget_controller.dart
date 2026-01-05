import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_create/dialog_cabinet_create_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_cabinet_create_widget_interactive.dart';
part 'dialog_cabinet_create_widget_route.dart';

class DialogCabinetCreateWidgetController extends GetxController {
  // MARK: - Properties

  final DialogCabinetCreateWidgetModel _model = DialogCabinetCreateWidgetModel();
  final _service = WarehouseService.instance;
  final nameController = TextEditingController();
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  RxReadonly<WarehouseNameIdModel?> get selectedRoomRx => _model.selectedRoom.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(
      EnumLogType.debug,
      '[DialogCabinetCreateWidgetController] onInit - $hashCode',
    );
  }

  @override
  void onClose() {
    LogUtil.i(
      EnumLogType.debug,
      '[DialogCabinetCreateWidgetController] onClose - $hashCode',
    );
    nameController.dispose();
    super.onClose();
  }

  // MARK: - Public Method

  // 檢查輸出資料
  Future<DialogCabinetCreateOutputModel?> checkOutputModel() async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      return null;
    }

    return DialogCabinetCreateOutputModel(
      name: name,
      roomId: selectedRoomRx.value?.id,
    );
  }

  List<String> getRoomNameList() {
    return _service.rooms.map((room) => room.name ?? '').toList();
  }

  WarehouseNameIdModel? getRoomByName(String name) {
    return _service.rooms.firstWhereOrNull((room) => room.name == name);
  }

  // MARK: - Private Method

  void _setLoadingStatus(bool isLoading) {
    _model.isLoading.value = isLoading;
  }
}
