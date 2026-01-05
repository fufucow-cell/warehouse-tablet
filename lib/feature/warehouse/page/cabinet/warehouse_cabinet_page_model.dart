import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

class WarehouseCabinetPageModel {
  final allVisibleCabinets = Rxn<List<RoomCabinetInfo>>();
  final filterRuleForRooms = <WarehouseNameIdModel>[];
  Worker? allRoomCabinetsWorker;
}
