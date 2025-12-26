import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_record.dart';
import 'package:get/get.dart';

class DialogItemHistoryWidgetModel {
  Item? combineItem;
  final records = Rxn<List<ItemRecord>?>();
}

class DialogItemHistoryRecordModel {
  final String tag;
  final String content;
  final String date;

  DialogItemHistoryRecordModel({
    required this.tag,
    required this.content,
    required this.date,
  });
}
