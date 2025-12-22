part of 'warehouse_alarm_page.dart';

class WarehouseAlarmPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseAlarmPageModel();
  final _service = WarehouseService.instance;
  List<int> get columnRatio => _model.columnRatio;
  RxReadonly<List<Room>?> get allItemsRx => _model.allRoomCabinetItems.readonly;
  RxReadonly<List<Item>> get visibleItemsRx => _model.visibleItems.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(
        EnumLogType.debug, '[WarehouseAlarmPageController] onInit - $hashCode');
    _checkData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug,
        '[WarehouseAlarmPageController] onClose - $hashCode');
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
    final allItems = _service.getAllRoomCabinetItems;

    if (allItems == null) {
      _queryApiData();
    } else {
      _model.allRoomCabinetItems.value = allItems;
      _genVisibleItems();
    }
  }

  Future<void> _queryApiData() async {
    final response =
        await _service.apiReqFetchItems(WarehouseItemRequestModel());
    _model.allRoomCabinetItems.value = response;
    _genVisibleItems();
  }

  void _genVisibleItems() {
    final allRoomCabinetItems = _model.allRoomCabinetItems.value;

    if (allRoomCabinetItems == null) {
      _model.visibleItems.value = [];
      return;
    }

    final allItems = allRoomCabinetItems
        .expand((room) => room.cabinets ?? <Cabinet>[])
        .expand((cabinet) => cabinet.items ?? <Item>[])
        .toList();
    final alarmItems = allItems
        .where((item) => (item.quantity ?? 0) < (item.minStockAlert ?? 0))
        .toList();
    _model.visibleItems.value = alarmItems;
  }
}
