import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

class DialogItemEditQuantityWidgetModel {
  String itemId = '';
  Item? combineItem;
  List<ItemPositionModel>? oldPositions;
  final isLoading = false.obs;
  final newQuantity = Rx<int>(0);
  final newPositions = Rx<List<ItemPositionModel>>([]);
  final maxNewPositions = 5;
}

class UpdatePositionModel {
  int index;
  WarehouseNameIdModel position;

  UpdatePositionModel({
    required this.index,
    required this.position,
  });
}

class DisplayPositionModel {
  String? roomId;
  String roomName;
  String? cabinetId;
  String cabinetName;
  int quantity;

  DisplayPositionModel({
    this.roomId,
    required this.roomName,
    this.cabinetId,
    required this.cabinetName,
    required this.quantity,
  });
}

class DialogItemEditQuantityOutputModel {
  final String cabinetId;
  final int quantity;

  DialogItemEditQuantityOutputModel({
    required this.cabinetId,
    required this.quantity,
  });
}
