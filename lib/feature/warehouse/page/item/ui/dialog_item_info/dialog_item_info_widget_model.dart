import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';

class DialogItemInfoWidgetModel {
  // MARK: - Properties

  String itemId = '';
  Item? combineItem;
  List<ItemPositionModel>? positions;
}
