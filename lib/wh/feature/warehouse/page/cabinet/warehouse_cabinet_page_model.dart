import 'package:engo_terminal_app3/wh/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

class WarehouseCabinetPageModel {
  final allVisibleCabinets = Rxn<List<RoomCabinetInfo>>();
  final filterRuleForRooms = <WarehouseNameIdModel>[];
  Worker? allRoomCabinetsWorker;
}
