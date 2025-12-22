part of 'warehouse_cabinet_page.dart';

class WarehouseCabinetPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseCabinetPageModel();
  final _service = WarehouseService.instance;
  RxReadonly<List<Room>?> get allItemsRx => _model.allRoomCabinetItems.readonly;
  List<WarehouseNameIdModel> get getRoomsInfo => _service.rooms;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug,
        '[WarehouseCabinetPageController] onInit - $hashCode');
    _checkData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug,
        '[WarehouseCabinetPageController] onClose - $hashCode');
    super.onClose();
  }

  // MARK: - Public Method

  Room? getRoom(WarehouseNameIdModel roomNameId) {
    final allRoomCabinetItems = _model.allRoomCabinetItems.value;
    return allRoomCabinetItems
        ?.firstWhereOrNull((room) => room.roomId == roomNameId.id);
  }

  List<Cabinet> getCabinets(WarehouseNameIdModel roomNameId) {
    final allRoomCabinetItems = _model.allRoomCabinetItems.value;
    final room = allRoomCabinetItems
        ?.firstWhereOrNull((room) => room.roomId == roomNameId.id);
    return room?.cabinets ?? <Cabinet>[];
  }

  // MARK: - Private Method

  void _checkData() {
    final allRoomCabinetItems = _service.getAllRoomCabinetItems;

    if (allRoomCabinetItems == null) {
      _queryApiData();
    } else {
      _model.allRoomCabinetItems.value = allRoomCabinetItems;
    }
  }

  Future<void> _queryApiData() async {
    final response =
        await _service.apiReqFetchItems(WarehouseItemRequestModel());

    if (response == null) {
      return;
    }

    _model.allRoomCabinetItems.value = response;
  }
}
