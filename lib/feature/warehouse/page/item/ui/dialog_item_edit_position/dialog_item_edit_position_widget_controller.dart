import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_position/dialog_item_edit_position_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_item_edit_position_widget_interactive.dart';
part 'dialog_item_edit_position_widget_route.dart';

class DialogItemEditPositionWidgetController extends GetxController {
  // MARK: - Properties

  final DialogItemEditPositionWidgetModel _model = DialogItemEditPositionWidgetModel();
  final _service = WarehouseService.instance;
  String get getItemName => _model.combineItem?.name ?? '';
  String get getOriginQuantity => (_model.combineItem?.quantity ?? 0).toString();
  List<DisplayPositionModel> get getPositions => _model.positions;
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  RxReadonly<List<WarehouseNameIdModel>> get changeRoomsRx => _model.changeRooms.readonly;
  RxReadonly<List<WarehouseNameIdModel>> get changeCabinetsRx => _model.changeCabinets.readonly;
  List<TextEditingController> get getQuantityControllers => _model.quantityControllers;

  // MARK: - Init

  DialogItemEditPositionWidgetController(String itemId) {
    _model.itemId = itemId;
  }

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(
      EnumLogType.debug,
      '[DialogItemEditPositionWidgetController] onInit - $hashCode',
    );
    _loadData();
  }

  @override
  void onClose() {
    LogUtil.i(
      EnumLogType.debug,
      '[DialogItemEditPositionWidgetController] onClose - $hashCode',
    );
    super.onClose();
  }

  // MARK: - Public Methods

  List<WarehouseNameIdModel> get getRoomList => _service.rooms;

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

  void updatePositionRoom(UpdatePositionModel model) {
    final list = _model.positions;
    final changeRooms = List<WarehouseNameIdModel>.from(_model.changeRooms.value);
    final changeCabinets = List<WarehouseNameIdModel>.from(_model.changeCabinets.value);

    if (model.index < list.length) {
      final newName = model.position.name ?? '';
      final oldName = changeRooms[model.index].name!;

      if (newName != oldName) {
        changeRooms[model.index] = model.position;
        final availableCabinets = getCabinetsForRoom(model.position);
        changeCabinets[model.index] = WarehouseNameIdModel(
          id: '',
          name: availableCabinets.isNotEmpty ? EnumLocale.optionPleaseSelect.tr : EnumLocale.optionNoData.tr,
        );
        _model.changeRooms.value = changeRooms;
        _model.changeCabinets.value = changeCabinets;
      }
    }
  }

  void updatePositionCabinet(UpdatePositionModel model) {
    final list = _model.positions;
    final changeCabinets = List<WarehouseNameIdModel>.from(_model.changeCabinets.value);

    if (model.index < list.length) {
      final newName = model.position.name ?? '';
      final oldName = changeCabinets[model.index].name!;

      if (newName != oldName) {
        changeCabinets[model.index] = model.position;
        _model.changeCabinets.value = changeCabinets;
      }
    }
  }

  String getPositionName(DisplayPositionModel model) {
    if ((model.roomName.isNotEmpty) && (model.cabinetName.isNotEmpty)) {
      return '${model.roomName} → ${model.cabinetName}';
    } else if ((model.roomName.isEmpty) && (model.cabinetName.isNotEmpty)) {
      return '${EnumLocale.warehouseUncategorized.tr} → ${model.cabinetName}';
    } else {
      return EnumLocale.warehouseUncategorized.tr;
    }
  }

  List<DialogItemEditPositionOutputModel> checkOutputData() {
    final outputData = <DialogItemEditPositionOutputModel>[];
    final oldList = _model.positions;
    final newList = _model.changeCabinets.value;

    for (var idx = 0; idx < newList.length; idx++) {
      final newCabinet = newList[idx];
      final newQuantity = int.tryParse(_model.quantityControllers[idx].text) ?? 0;

      if ((newCabinet.id?.isNotEmpty ?? false) && (newQuantity > 0)) {
        final oldCabinet = oldList[idx];
        outputData.add(
          DialogItemEditPositionOutputModel(
            oldCabinetId: oldCabinet.cabinetId!,
            newCabinetId: newCabinet.id!,
            moveQuantity: newQuantity,
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
    _initPositions();
  }

  void _initPositions() {
    final allRoomCabinetItems = _service.getAllRoomCabinetItems;
    final positions = <DisplayPositionModel>[];
    final itemId = _model.combineItem?.id;

    if (allRoomCabinetItems.isNotEmpty && (itemId?.isNotEmpty ?? false)) {
      for (final room in allRoomCabinetItems) {
        if (room.cabinets?.isEmpty ?? true) {
          continue;
        }

        for (final cabinet in room.cabinets!) {
          if (cabinet.items?.isEmpty ?? true) {
            continue;
          }

          final matchItem = cabinet.items!.where((i) => i.id == itemId).firstOrNull;

          if (matchItem != null) {
            final roomInfo = _service.rooms.where((e) => e.id == room.roomId).firstOrNull;
            final roomName = roomInfo?.name ?? EnumLocale.warehouseUncategorized.tr;
            final cabinetName = cabinet.name ?? EnumLocale.warehouseUncategorized.tr;

            final positionModel = DisplayPositionModel(
              index: positions.length,
              roomId: room.roomId,
              roomName: roomName,
              cabinetId: cabinet.id,
              cabinetName: cabinetName,
              quantity: matchItem.quantity ?? 0,
            );

            positions.add(positionModel);
            _model.changeRooms.value.add(
              WarehouseNameIdModel(
                id: '',
                name: EnumLocale.optionPleaseSelect.tr,
              ),
            );
            _model.changeCabinets.value.add(
              WarehouseNameIdModel(
                id: '',
                name: EnumLocale.optionPleaseSelect.tr,
              ),
            );
            _model.quantityControllers.add(TextEditingController(text: '0'));
          }
        }
      }
    }

    _model.positions.clear();
    _model.positions.addAll(positions);
  }

  void _setLoadingStatus(bool isLoading) {
    _model.isLoading.value = isLoading;
  }
}
