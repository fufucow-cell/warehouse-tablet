import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_delete/dialog_cabinet_delete_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_cabinet_delete_widget_interactive.dart';
part 'dialog_cabinet_delete_widget_route.dart';

class DialogCabinetDeleteWidgetController extends GetxController {
  // MARK: - Properties

  final DialogCabinetDeleteWidgetModel _model = DialogCabinetDeleteWidgetModel();
  final _service = WarehouseService.instance;
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  String get cabinetName => _model.cabinet?.name ?? '';

  // MARK: - Init

  DialogCabinetDeleteWidgetController(Cabinet cabinet) {
    _model.cabinet = cabinet;
  }

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[DialogCabinetDeleteWidgetController] onInit - $hashCode');
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[DialogCabinetDeleteWidgetController] onClose - $hashCode');
    super.onClose();
  }

  // MARK: - Public Method

  // 檢查輸出資料
  Future<DialogCabinetDeleteOutputModel?> checkOutputModel() async {
    if (_model.cabinet == null || _model.cabinet?.id == null) {
      return null;
    }

    return DialogCabinetDeleteOutputModel(
      cabinetId: _model.cabinet!.id!,
    );
  }

  String getMessage() {
    final hasItems = _model.cabinet?.items?.isNotEmpty ?? false;
    if (hasItems) {
      return EnumLocale.deleteCabinetMessageWithItems.trArgs([cabinetName]);
    } else {
      return EnumLocale.deleteCabinetMessageNoItems.trArgs([cabinetName]);
    }
  }

  // MARK: - Private Method

  void _setLoadingStatus(bool isLoading) {
    _model.isLoading.value = isLoading;
  }
}
