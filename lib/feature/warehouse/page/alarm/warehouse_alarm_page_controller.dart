part of 'warehouse_alarm_page.dart';

class WarehouseAlarmPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseAlarmPageModel();
  final _service = WarehouseService.instance;
  List<int> get columnRatio => _model.columnRatio;
  RxReadonly<List<Item>?> get lowStockItemsRx => _model.lowStockItems.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[WarehouseAlarmPageController] onInit - $hashCode');
    _checkData();
    _listenItemsData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[WarehouseAlarmPageController] onClose - $hashCode');
    super.onClose();
  }

  // MARK: - Public Method

  int getStockDifference(Item item) {
    final stock = item.minStockAlert ?? 0;
    final quantity = item.quantity ?? 0;

    if (stock >= quantity) {
      return stock - quantity;
    }

    return 0;
  }

  // MARK: - Private Method

  void _checkData() {
    final items = _service.allLowStockItemsRx.value;

    if (items != null) {
      _model.lowStockItems.value = items;
    }
  }

  void _listenItemsData() {
    ever(_service.allLowStockItemsRx.rx, (_) => _checkData());
  }
}
