import 'package:flutter_smart_home_tablet/feature/warehouse/util/record_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:get/get.dart';

class DialogItemHistoryWidgetModel {
  Item? combineItem;
  final records = Rxn<List<CombineRecord>>();
}
