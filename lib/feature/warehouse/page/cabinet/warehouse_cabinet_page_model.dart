import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/room.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

class WarehouseCabinetPageModel {
  final allRoomCabinetItems = Rxn<List<Room>>();
  final filterRuleForRooms = <WarehouseNameIdModel>[];
}
