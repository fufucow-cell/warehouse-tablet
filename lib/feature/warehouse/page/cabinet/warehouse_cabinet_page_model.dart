import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/room.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

class WarehouseCabinetPageModel {
  final allRoomCabinets = Rxn<List<Room>>();
  final allVisibleCabinets = Rx<List<RoomCabinetInfo>>([]);
  final filterRuleForRooms = <WarehouseNameIdModel>[];
  Worker? allRoomCabinetsWorker;
}

class RoomCabinetInfo {
  final String roomId;
  final String roomName;
  final List<CabinetInfo> cabinets;

  RoomCabinetInfo({
    required this.roomId,
    required this.roomName,
    required this.cabinets,
  });
}

class CabinetInfo {
  final String cabinetId;
  final String cabinetName;
  final int quantity;

  CabinetInfo({
    required this.cabinetId,
    required this.cabinetName,
    required this.quantity,
  });
}
