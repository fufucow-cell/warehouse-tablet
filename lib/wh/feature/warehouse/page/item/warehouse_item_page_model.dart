import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/ui/dialog_item_search/dialog_item_search_widget_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/room.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

class WarehouseItemPageModel {
  final allRoomCabinetItems = Rxn<List<Room>>();
  final allRoomCabinets = Rxn<List<Room>>();
  final allItemsForCategory = <Item>[];
  final visibleItems = Rx<List<Item>>([]);
  final filterRuleForRooms = <WarehouseNameIdModel>[];
  final filterRuleForCabinets = Rx<List<WarehouseNameIdModel>>([]);
  final filterRuleForCategories = Rx<List<WarehouseNameIdModel>>([]);
  final filterIndexForRooms = 0.obs;
  final filterIndexForCabinets = 0.obs;
  final filterIndexForCategories = Rx<Set<int>>({});
  final isFilterExpanded = false.obs;
  final searchCondition = Rxn<DialogItemSearchOutputModel>();
  Worker? allRoomCabinetItemsWorker;
  Worker? allRoomCabinetsWorker;
  Worker? searchConditionWorker;
}
