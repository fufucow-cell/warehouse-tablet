import 'package:flutter_smart_home_tablet/feature/warehouse/page/alarm/warehouse_alarm_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_quantity/dialog_item_edit_quantity_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_quantity/dialog_item_edit_quantity_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_info/dialog_item_info_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_edit_quantity_request_model/warehouse_item_edit_quantity_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'warehouse_alarm_page_interactive.dart';
part 'warehouse_alarm_page_route.dart';

class WarehouseAlarmPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseAlarmPageModel();
  final _service = WarehouseService.instance;
  List<int> get columnRatio => _model.columnRatio;
  RxReadonly<List<Item>?> get allAlarmItemsRx => _model.allAlarmItems.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(
      EnumLogType.debug,
      '[WarehouseAlarmPageController] onInit - $hashCode',
    );
    _loadData();
  }

  @override
  void onClose() {
    LogUtil.i(
      EnumLogType.debug,
      '[WarehouseAlarmPageController] onClose - $hashCode',
    );
    super.onClose();
  }

  // MARK: - Public Method

  int getStockDifference(Item item) {
    return item.minStockAlert! - item.quantity!;
  }

  // MARK: - Private Method

  void _loadData() {
    final items = _service.getAllCombineItems;
    _model.allAlarmItems.value = items.where(_isLowStock).toList();
  }

  bool _isLowStock(Item item) {
    final minStockAlert = item.minStockAlert ?? 0;
    final quantity = item.quantity ?? 0;

    if (minStockAlert > 0) {
      return quantity < minStockAlert;
    }

    return false;
  }

  Future<bool> _updateItemQuantity(
    Item item,
    List<DialogItemEditQuantityOutputModel> models,
  ) async {
    final requestModel = WarehouseItemEditQuantityRequestModel(
      householdId: _service.getHouseholdId,
      itemId: item.id,
      cabinets: models
          .map(
            (model) => QuantityCabinetRequestModel(
              cabinetId: model.cabinetId,
              quantity: model.quantity,
            ),
          )
          .toList(),
    );

    final response = await _service.apiReqUpdateItemQuantity(
      requestModel,
    );

    return response != null;
  }
}
