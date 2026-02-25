import 'package:collection/collection.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/ui/dialog_item_edit_position/dialog_item_edit_position_widget_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/service/warehouse_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/util/cabinet_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'dialog_item_edit_position_widget_interactive.dart';
part 'dialog_item_edit_position_widget_route.dart';

class DialogItemEditPositionWidgetController extends GetxController {
  // MARK: - Properties

  final DialogItemEditPositionWidgetModel _model = DialogItemEditPositionWidgetModel();
  final _service = WarehouseService.instance;
  String get getItemName => _model.combineItem?.name ?? '';
  int get getOriginQuantity => _model.combineItem?.quantity ?? 0;
  List<DisplayPositionModel> get getPositions => _model.positions;
  List<RoomCabinetInfo> get getRoomCabinetInfos => _service.getRoomCabinetInfos;
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  RxReadonly<List<NewPositionModel>> get changePositionsRx => _model.changePositions.readonly;
  List<TextEditingController> get getQuantityControllers => _model.quantityControllers;

  /// 獲取指定 controller 索引對應的最大數量（DisplayPositionModel 的 quantity）
  int getMaxQuantityForController(int controllerIndex) {
    if (controllerIndex >= 0 && controllerIndex < _model.positions.length) {
      return _model.positions[controllerIndex].quantity;
    }
    return 0;
  }

  List<String> get getRoomNameList => CabinetUtil.getRoomNameList();
  List<CabinetInfo> get getFlattenAllCabinets => CabinetUtil.flattenAllCabinets();
  RoomCabinetInfo? getRoomByName(String? roomName) => CabinetUtil.getRoomByName(roomName);
  CabinetInfo? getCabinetByName(String? cabinetName) => CabinetUtil.getCabinetByName(cabinetName);
  List<String> getVisibleCabinetNameList(
    String? roomName, {
    bool includeUnboundRoom = false,
  }) =>
      CabinetUtil.getVisibleCabinetNameList(
        roomName,
        includeUnboundRoom: true,
      );

  // MARK: - Init

  DialogItemEditPositionWidgetController(String itemId) {
    _model.itemId = itemId;
  }

  @override
  void onInit() {
    super.onInit();
    LogService.instance.i(
      EnumLogType.debug,
      '[DialogItemEditPositionWidgetController] onInit - $hashCode',
    );
    _loadData();
  }

  @override
  void onClose() {
    LogService.instance.i(
      EnumLogType.debug,
      '[DialogItemEditPositionWidgetController] onClose - $hashCode',
    );
    super.onClose();
  }

  // MARK: - Public Methods

  void updatePositionRoom(UpdatePositionModel roomModel) {
    final list = _model.positions;
    final changePositions = List<NewPositionModel>.from(_model.changePositions.value);

    if (roomModel.index < list.length) {
      final newName = roomModel.position.name ?? '';
      final oldName = changePositions[roomModel.index].room.name!;

      if (newName != oldName) {
        changePositions[roomModel.index].room = roomModel.position;
        final availableCabinets = CabinetUtil.getAllCabinetsFromRoom(roomId: roomModel.position.id);

        if (availableCabinets.isEmpty) {
          _routerHandle(
            EnumDialogItemEditPositionWidgetRoute.showSnackBar,
            data: EnumLocale.warehouseNoCabinetInRoom.tr,
          );
          return;
        }

        changePositions[roomModel.index].cabinet = WarehouseNameIdModel(
          id: '',
          name: availableCabinets.isNotEmpty ? EnumLocale.optionPleaseSelect.tr : EnumLocale.optionNoData.tr,
        );
        _model.changePositions.value = changePositions;
      }
    }
  }

  void updatePositionCabinet(UpdatePositionModel cabinetModel) {
    final list = _model.positions;
    final changePositions = List<NewPositionModel>.from(_model.changePositions.value);

    if (cabinetModel.index < list.length) {
      final newName = cabinetModel.position.name ?? '';
      final oldName = changePositions[cabinetModel.index].cabinet.name!;

      if (newName != oldName) {
        changePositions[cabinetModel.index].cabinet = cabinetModel.position;
        _model.changePositions.value = changePositions;
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

  List<DialogItemEditPositionOutputModel>? checkOutputData() {
    final outputData = <DialogItemEditPositionOutputModel>[];
    final oldList = _model.positions;
    final newList = _model.changePositions.value;

    for (var idx = 0; idx < newList.length; idx++) {
      final oldCabinetModel = oldList[idx];
      final newRoom = newList[idx].room;
      final newCabinet = newList[idx].cabinet;
      final newQuantity = int.tryParse(_model.quantityControllers[idx].text) ?? 0;

      if (oldCabinetModel.isDelete) {
        if (oldCabinetModel.quantity > 0 && (newCabinet.id?.isEmpty ?? true)) {
          _routerHandle(
            EnumDialogItemEditPositionWidgetRoute.showSnackBar,
            data: '${oldCabinetModel.cabinetName}${EnumLocale.warehouseDeleteCabinetItemMustMoveFirst.tr}',
          );
          return null;
        } else {
          outputData.add(
            DialogItemEditPositionOutputModel(
              oldCabinetId: oldCabinetModel.cabinetId!,
              newCabinetId: '',
              moveQuantity: 0,
              isDelete: oldCabinetModel.isDelete,
            ),
          );
        }
      } else if (newRoom.id?.isNotEmpty ?? false) {
        if (newQuantity <= 0) {
          continue;
        }

        if (newCabinet.id?.isEmpty ?? true) {
          _routerHandle(
            EnumDialogItemEditPositionWidgetRoute.showSnackBar,
            data: EnumLocale.warehouseCabinetNotSelected.tr,
          );
          return null;
        }

        if (oldCabinetModel.quantity < newQuantity) {
          _routerHandle(
            EnumDialogItemEditPositionWidgetRoute.showSnackBar,
            data: '${oldCabinetModel.cabinetName}${EnumLocale.warehouseMoveQuantityInsufficient.tr}',
          );
          return null;
        }

        if (newCabinet.id == oldCabinetModel.cabinetId) {
          _routerHandle(
            EnumDialogItemEditPositionWidgetRoute.showSnackBar,
            data: EnumLocale.warehouseMoveToSameCabinet.tr,
          );
          return null;
        }

        outputData.add(
          DialogItemEditPositionOutputModel(
            oldCabinetId: oldCabinetModel.cabinetId ?? '',
            newCabinetId: newCabinet.id!,
            moveQuantity: newQuantity,
            isDelete: oldCabinetModel.isDelete,
          ),
        );
      }
    }

    if (outputData.isEmpty) {
      _routerHandle(
        EnumDialogItemEditPositionWidgetRoute.showSnackBar,
        data: EnumLocale.warehouseNoChange.tr,
      );
      return null;
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
            final roomName = roomInfo?.name ?? EnumLocale.warehouseUnboundRoom.tr;
            final cabinetName = cabinet.name ?? EnumLocale.warehouseUnboundCabinet.tr;

            final positionModel = DisplayPositionModel(
              index: positions.length,
              roomId: room.roomId,
              roomName: roomName,
              cabinetId: cabinet.id,
              cabinetName: cabinetName,
              quantity: matchItem.quantity ?? 0,
            );

            positions.add(positionModel);
            _model.changePositions.value.add(
              NewPositionModel(
                room: WarehouseNameIdModel(
                  id: '',
                  name: EnumLocale.optionPleaseSelect.tr,
                ),
                cabinet: WarehouseNameIdModel(
                  id: '',
                  name: EnumLocale.optionPleaseSelect.tr,
                ),
              ),
            );
            _model.quantityControllers.add(TextEditingController(text: matchItem.quantity?.toString() ?? '0'));
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
