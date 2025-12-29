import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:get/get.dart';

class WarehouseAlarmPageModel {
  final allAlarmItems = Rxn<List<Item>>();
  final columnRatio = [170, 705, 280, 280];
}
