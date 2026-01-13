import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

class DialogItemEditQuantityWidgetModel {
  String itemId = '';
  Item? combineItem;
  List<ItemPositionModel>? oldPositions;
  final isLoading = false.obs;
  final newQuantity = Rx<int>(0);
  final newPositions = Rx<List<ItemPositionModel>>([]);
  final maxNewPositions = 5;
  final allRoomCabinetInfo = Rx<List<RoomCabinetInfo>>([]);
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
  final String? cabinetId;
  final int quantity;

  DialogItemEditQuantityOutputModel({
    this.cabinetId,
    required this.quantity,
  });
}
