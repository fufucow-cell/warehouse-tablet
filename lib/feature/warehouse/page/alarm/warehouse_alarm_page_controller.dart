part of 'warehouse_alarm_page.dart';

class WarehouseAlarmPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseAlarmPageModel();
  final _service = WarehouseService.instance;
  List<int> get columnRatio => _model.columnRatio;
  List<Item> get allAlarmItemsRx => _model.allAlarmItems;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[WarehouseAlarmPageController] onInit - $hashCode');
    _loadData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[WarehouseAlarmPageController] onClose - $hashCode');
    super.onClose();
  }

  // MARK: - Public Method

  int getStockDifference(Item item) {
    return item.minStockAlert! - item.quantity!;
  }

  // MARK: - Private Method

  void _loadData() {
    final items = _service.getAllCombineItems;
    _model.allAlarmItems = items.where(_isLowStock).toList();
  }

  bool _isLowStock(Item item) {
    final minStockAlert = item.minStockAlert ?? 0;
    final quantity = item.quantity ?? 0;

    if (minStockAlert > 0) {
      return quantity < minStockAlert;
    }

    return false;
  }

  Future<bool> _updateItemQuantity(Item item, List<DialogItemEditQuantityOutputModel> models) async {
    String errMsg = '';
    final requestModel = WarehouseItemEditQuantityRequestModel(
      householdId: _service.getHouseholdId,
      itemId: item.id,
      cabinets: models.map((model) => QuantityCabinetRequestModel(cabinetId: model.cabinetId, quantity: model.quantity)).toList(),
    );

    final response = await _service.apiReqUpdateItemQuantity(
      requestModel,
      onError: (error) {
        errMsg = '[${error.code}] ${error.message ?? ''}';
      },
    );

    final isSuccess = response != null;
    _service.showSnackBar(
      title: isSuccess ? EnumLocale.warehouseItemUpdateSuccess.tr : EnumLocale.warehouseItemUpdateFailed.tr,
      message: errMsg,
    );
    return isSuccess;
  }
}
