import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/ui/dialog_item_edit_quantity/dialog_item_edit_quantity_widget_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/service/warehouse_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/util/cabinet_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'dialog_item_edit_quantity_widget_interactive.dart';
part 'dialog_item_edit_quantity_widget_route.dart';

class DialogItemEditQuantityWidgetController extends GetxController {
  // MARK: - Properties

  final DialogItemEditQuantityWidgetModel _model = DialogItemEditQuantityWidgetModel();
  final _service = WarehouseService.instance;
  String get getItemName => _model.combineItem?.name ?? '';
  int get getOldQuantity => _model.combineItem?.quantity ?? 0;
  int get getMaxNewPositions => _model.maxNewPositions;
  List<ItemPositionModel> get getOldPositions => _model.oldPositions ?? [];
  List<ItemPositionModel> get getNewPositions => _model.newPositions.value;
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  RxReadonly<int> get newQuantityRx => _model.newQuantity.readonly;
  RxReadonly<List<ItemPositionModel>> get newPositionsRx => _model.newPositions.readonly;
  final List<TextEditingController> quantityControllers = [];
  List<String> get getRoomNameList => CabinetUtil.getRoomNameList();
  List<CabinetInfo> get getFlattenAllCabinets => CabinetUtil.flattenAllCabinets();
  RoomCabinetInfo? getRoomByName(String? roomName) => CabinetUtil.getRoomByName(roomName);
  CabinetInfo? getCabinetByName(String? cabinetName) => CabinetUtil.getCabinetByName(cabinetName);
  List<String> getVisibleCabinetNameList(String? roomName) => CabinetUtil.getVisibleCabinetNameList(
        roomName,
        includeUnboundRoom: true,
      );

  // MARK: - Init

  DialogItemEditQuantityWidgetController(String itemId) {
    _model.itemId = itemId;
  }

  @override
  void onInit() {
    super.onInit();
    LogService.instance.i(
      EnumLogType.debug,
      '[DialogItemEditQuantityWidgetController] onInit - $hashCode',
    );
    _loadData();
  }

  @override
  void onClose() {
    LogService.instance.i(
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
    final cabinetCount = getFlattenAllCabinets.length;
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

        if (cabinetCount == 0) {
          routerHandle(
            EnumDialogItemEditQuantityWidgetRoute.showSnackBar,
            data: EnumLocale.warehouseNoCabinetInRoom.tr,
          );
          return;
        }

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
            roomId: room.roomId,
            cabinetName: cabinet.name,
            quantity: cabinet.quantity,
          ),
        );
      }
    }

    return result;
  }

  List<DialogItemEditQuantityOutputModel>? checkOutputData() {
    final outputData = <DialogItemEditQuantityOutputModel>[];
    final oldCabinets = getOldPositions.expand<ItemPositionCabinetModel>((position) => position.cabinets).toList();
    final newCabinets = getNewPositions.expand<ItemPositionCabinetModel>((position) => position.cabinets).toList();

    if (newCabinets.any((cab) => cab.id.isEmpty)) {
      routerHandle(
        EnumDialogItemEditQuantityWidgetRoute.showSnackBar,
        data: EnumLocale.warehouseCabinetNotSelected.tr,
      );
      return null;
    }

    // 取得所有 oldCabinets 的 ID 集合
    final oldCabinetIds = oldCabinets.map((cabinet) => cabinet.id).where((id) => id.isNotEmpty).toSet();

    // 找出第一個重複的 cabinet name
    final duplicateCabinet = newCabinets.firstWhereOrNull(
      (cabinet) => cabinet.id.isNotEmpty && oldCabinetIds.contains(cabinet.id),
    );

    // 如果有重複的 ID，顯示錯誤並返回 null
    if (duplicateCabinet != null) {
      routerHandle(
        EnumDialogItemEditQuantityWidgetRoute.showSnackBar,
        data: EnumLocale.warehouseDuplicateRoomCabinet.tr,
      );
      return null;
    }

    // 處理 oldCabinets：如果 quantity 與 textfield 的 quantity 一樣，代表沒變，所以不用加到 outputData 內
    for (int i = 0; i < oldCabinets.length; i++) {
      final cabinet = oldCabinets[i];
      final textFieldQuantity = int.tryParse(quantityControllers[i].text.trim()) ?? 0;
      final originalQuantity = cabinet.quantity;

      // 如果 quantity 有變化，才加入 outputData
      if (textFieldQuantity != originalQuantity) {
        outputData.add(
          DialogItemEditQuantityOutputModel(
            cabinetId: cabinet.id.isEmpty ? null : cabinet.id,
            quantity: textFieldQuantity,
          ),
        );
      }
    }

    // 處理 newCabinets：如果 textfield 的 quantity 為 0 也直接忽略
    final oldCabinetsCount = oldCabinets.length;
    for (int i = 0; i < newCabinets.length; i++) {
      final cabinet = newCabinets[i];
      final textFieldQuantity = int.tryParse(quantityControllers[oldCabinetsCount + i].text.trim()) ?? 0;

      // 如果 quantity 不為 0，才加入 outputData
      if (textFieldQuantity > 0) {
        outputData.add(
          DialogItemEditQuantityOutputModel(
            cabinetId: cabinet.id.isEmpty ? null : cabinet.id,
            quantity: textFieldQuantity,
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

    _model.allRoomCabinetInfo.value = _service.getRoomCabinetInfos;
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
