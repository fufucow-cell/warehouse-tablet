import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_history/dialog_item_history_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_info/dialog_item_info_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/util/record_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_record_read_request_model/warehouse_record_read_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_item_history_widget_interactive.dart';
part 'dialog_item_history_widget_route.dart';

class DialogItemHistoryWidgetController extends GetxController {
  // MARK: - Properties

  final DialogItemHistoryWidgetModel _model = DialogItemHistoryWidgetModel();
  final _service = WarehouseService.instance;
  RxReadonly<List<CombineRecord>?> get recordsRx => _model.records.readonly;
  String get getItemName => _model.combineItem?.name ?? '';
  int get getRecordCount => _model.records.value?.length ?? 0;

  // MARK: - Init

  DialogItemHistoryWidgetController(Item item) {
    _model.combineItem = item;
  }

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[DialogItemHistoryWidgetController] onInit - $hashCode');
    _loadData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[DialogItemHistoryWidgetController] onClose - $hashCode');
    super.onClose();
  }

  // MARK: - Private Methods

  Future<void> _loadData() async {
    final response = await _service.apiReqReadRecord(
      WarehouseRecordReadRequestModel(
        householdId: _service.getHouseholdId,
        itemId: _model.combineItem?.id,
      ),
      onError: (error) {
        _service.showSnackBar(title: EnumLocale.commonRequestFailed.tr, message: '[${error.code}] ${error.message ?? ''}');
      },
    );

    if (response != null) {
      _model.records.value = RecordUtil.combineItemRecords(response, isItemLog: true);
    }
  }
}
