import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_quantity/dialog_item_edit_quantity_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_item_edit_quantity_widget_interactive.dart';
part 'dialog_item_edit_quantity_widget_route.dart';

class DialogItemEditQuantityWidgetController extends GetxController {
  // MARK: - Properties

  final DialogItemEditQuantityWidgetModel _model = DialogItemEditQuantityWidgetModel();
  final _service = WarehouseService.instance;
  String get getItemName => _model.combineItem?.name ?? '';
  String get getOldQuantity => (_model.combineItem?.quantity ?? 0).toString();
  int get getMaxNewPositions => _model.maxNewPositions;
  List<ItemPositionModel> get getOldPositions => _model.oldPositions ?? [];
  List<ItemPositionModel> get getNewPositions => _model.newPositions.value;
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  RxReadonly<int> get newQuantityRx => _model.newQuantity.readonly;
  RxReadonly<List<ItemPositionModel>> get newPositionsRx => _model.newPositions.readonly;
  final List<TextEditingController> quantityControllers = [];

  // MARK: - Init

  DialogItemEditQuantityWidgetController(String itemId) {
    _model.itemId = itemId;
  }

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(
      EnumLogType.debug,
      '[DialogItemEditQuantityWidgetController] onInit - $hashCode',
    );
    _loadData();
  }

  @override
  void onClose() {
    LogUtil.i(
      EnumLogType.debug,
      '[DialogItemEditQuantityWidgetController] onClose - $hashCode',
    );
    super.onClose();
    for (var controller in quantityControllers) {
      controller.dispose();
    }
    quantityControllers.clear();
  }

  // MARK: - Public Methods

  void genNewPosition() {
    final roomCount = _service.rooms.length;
    final cabinetCount = _flattenAllCabinets().length;
    final model = ItemPositionModel(
      roomId: '',
      roomName: roomCount > 0 ? EnumLocale.optionPleaseSelectRoom.tr : EnumLocale.optionNoData.tr,
      cabinets: [
        ItemPositionCabinetModel(
          id: '',
          name: cabinetCount > 0 ? EnumLocale.optionPleaseSelectCabinet.tr : EnumLocale.optionNoData.tr,
          quantity: 1,
        ),
      ],
    );
    final newList = List<ItemPositionModel>.from(_model.newPositions.value);
    newList.add(model);
    _model.newPositions.value = newList;
    final controller = TextEditingController();
    quantityControllers.add(controller);
    _listen(controller);
    controller.text = '1';
  }

  void updateNewPositionRoom(UpdatePositionModel model) {
    final list = List<ItemPositionModel>.from(_model.newPositions.value);

    if (model.index < list.length) {
      final newName = model.position.name ?? '';
      final oldName = list[model.index].roomName;

      if (newName != oldName) {
        final cabinetCount = getVisibleCabinetNameList(newName).length;
        final newPosition = ItemPositionModel(
          roomId: model.position.id ?? '',
          roomName: model.position.name ?? '',
          cabinets: [
            ItemPositionCabinetModel(
              id: '',
              name: cabinetCount > 0 ? EnumLocale.optionPleaseSelectCabinet.tr : EnumLocale.optionNoData.tr,
              quantity: 1,
            ),
          ],
        );
        list[model.index] = newPosition;
        _model.newPositions.value = list;
      }
    }
  }

  void updateNewPositionCabinet(UpdatePositionModel model) {
    final list = List<ItemPositionModel>.from(_model.newPositions.value);

    if (model.index < list.length) {
      final newName = model.position.name ?? '';
      final oldName = list[model.index].cabinets[0].name;

      if (newName != oldName) {
        final newPosition = ItemPositionModel(
          roomId: list[model.index].roomId,
          roomName: list[model.index].roomName,
          cabinets: [
            ItemPositionCabinetModel(
              id: model.position.id ?? '',
              name: model.position.name ?? '',
              quantity: 1,
            ),
          ],
        );
        list[model.index] = newPosition;
        _model.newPositions.value = list;
      }
    }
  }

  void updateNewPositionQuantity(
    int positionIndex,
    int cabinetIndex,
    int quantity,
  ) {
    final newList = List<ItemPositionModel>.from(_model.newPositions.value);

    if (positionIndex < newList.length && cabinetIndex < newList[positionIndex].cabinets.length) {
      final position = newList[positionIndex];
      final cabinets = List<ItemPositionCabinetModel>.from(position.cabinets);
      cabinets[cabinetIndex] = ItemPositionCabinetModel(
        id: cabinets[cabinetIndex].id,
        name: cabinets[cabinetIndex].name,
        quantity: quantity,
      );
      newList[positionIndex] = ItemPositionModel(
        roomId: position.roomId,
        roomName: position.roomName,
        cabinets: cabinets,
      );
      _model.newPositions.value = newList;
    }
  }

  void updateOldPositionQuantity(
    int positionIndex,
    int cabinetIndex,
    int quantity,
  ) {
    final oldList = List<ItemPositionModel>.from(_model.oldPositions ?? []);

    if (positionIndex < oldList.length && cabinetIndex < oldList[positionIndex].cabinets.length) {
      final position = oldList[positionIndex];
      final cabinets = List<ItemPositionCabinetModel>.from(position.cabinets);
      cabinets[cabinetIndex] = ItemPositionCabinetModel(
        id: cabinets[cabinetIndex].id,
        name: cabinets[cabinetIndex].name,
        quantity: quantity,
      );
      oldList[positionIndex] = ItemPositionModel(
        roomId: position.roomId,
        roomName: position.roomName,
        cabinets: cabinets,
      );
      _model.oldPositions = oldList;
    }
  }

  // 取得所有房間名稱
  List<String> getRoomNameList() {
    return _service.rooms.map((room) => room.name ?? '').where((name) => name.isNotEmpty).toList();
  }

  // 比對房間
  WarehouseNameIdModel? getRoomByName(String? roomName) {
    return _service.rooms.firstWhereOrNull((room) => room.name == roomName);
  }

  // 比對櫃位
  WarehouseNameIdModel? getCabinetByName(String? cabinetName) {
    final cabinet = _flattenAllCabinets().firstWhereOrNull((cabinet) => cabinet.name == cabinetName);
    if (cabinet == null) {
      return null;
    }
    return WarehouseNameIdModel(id: cabinet.id ?? '', name: cabinet.name ?? '');
  }

  // 取得可顯示的櫃位名稱
  List<String> getVisibleCabinetNameList(String? roomName) {
    final matchRoom = _service.rooms.firstWhereOrNull((room) => room.name == roomName);
    return getCabinetsForRoom(matchRoom).map((cabinet) => cabinet.name ?? '').where((name) => name.isNotEmpty).toList();
  }

  // 扁平化所有櫥櫃
  List<Cabinet> _flattenAllCabinets() {
    return _service.getAllRoomCabinetItems.expand<Cabinet>((room) => room.cabinets ?? []).toList();
  }

  List<WarehouseNameIdModel> getCabinetsForRoom(WarehouseNameIdModel? room) {
    if (room == null) {
      return _flattenAllCabinets()
          .map(
            (cabinet) => WarehouseNameIdModel(
              id: cabinet.id ?? '',
              name: cabinet.name ?? '',
            ),
          )
          .toList();
    }

    return _service.getAllRoomCabinetItems
            .firstWhereOrNull((e) => e.roomId == room.id)
            ?.cabinets
            ?.map(
              (cabinet) => WarehouseNameIdModel(
                id: cabinet.id ?? '',
                name: cabinet.name ?? '',
              ),
            )
            .toList() ??
        [];
  }

  List<DisplayPositionModel> get getOldDisplayPositionList {
    final result = <DisplayPositionModel>[];
    final positions = getOldPositions;

    for (int i = 0; i < positions.length; i++) {
      final room = positions[i];

      for (int j = 0; j < room.cabinets.length; j++) {
        final cabinet = room.cabinets[j];

        result.add(
          DisplayPositionModel(
            roomName: room.roomName,
            cabinetName: cabinet.name,
            quantity: cabinet.quantity,
          ),
        );
      }
    }

    return result;
  }

  List<DisplayPositionModel> get getNewDisplayPositionList {
    final result = <DisplayPositionModel>[];
    final positions = getNewPositions;

    for (int i = 0; i < positions.length; i++) {
      final room = positions[i];

      for (int j = 0; j < room.cabinets.length; j++) {
        final cabinet = room.cabinets[j];

        result.add(
          DisplayPositionModel(
            roomName: room.roomName,
            cabinetName: cabinet.name,
            quantity: cabinet.quantity,
          ),
        );
      }
    }

    return result;
  }

  List<DialogItemEditQuantityOutputModel> checkOutputData() {
    final outputData = <DialogItemEditQuantityOutputModel>[];
    final oldCabinets = getOldPositions.expand<ItemPositionCabinetModel>((position) => position.cabinets).toList();
    final newCabinets = getNewPositions.expand<ItemPositionCabinetModel>((position) => position.cabinets).toList();

    for (var cabinet in [...oldCabinets, ...newCabinets]) {
      if (cabinet.id.isNotEmpty) {
        outputData.add(
          DialogItemEditQuantityOutputModel(
            cabinetId: cabinet.id,
            quantity: cabinet.quantity,
          ),
        );
      }
    }

    return outputData;
  }

  // MARK: - Private Methods

  void _loadData() {
    final item = _service.getAllCombineItems.firstWhereOrNull((item) => item.id == _model.itemId);

    if (item == null) {
      return;
    }

    _model.combineItem = item;
    _model.oldPositions = _service.genItemPositionsFromRoomCabinet(item);
    _model.newQuantity.value = _model.oldPositions
            ?.expand<ItemPositionCabinetModel>((position) => position.cabinets)
            .fold<int>(0, (sum, cabinet) => sum + cabinet.quantity) ??
        0;

    final displayList = getOldDisplayPositionList;
    for (var i = 0; i < displayList.length; i++) {
      final controller = TextEditingController(text: displayList[i].quantity.toString());
      quantityControllers.add(controller);
      _listen(controller);
    }
  }

  void _listen(TextEditingController controller) {
    controller.addListener(() {
      _model.newQuantity.value = quantityControllers.fold<int>(
        0,
        (sum, controller) => sum + (int.tryParse(controller.text) ?? 0),
      );
    });
  }

  // 設置加載狀態
  void _setLoadingStatus(bool isLoading) {
    _model.isLoading.value = isLoading;
  }
}
