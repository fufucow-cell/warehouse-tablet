import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/util/record_util.dart';
import 'package:get/get.dart';

class DialogItemHistoryWidgetModel {
  Item? combineItem;
  final records = Rxn<List<CombineRecord>>();
}
