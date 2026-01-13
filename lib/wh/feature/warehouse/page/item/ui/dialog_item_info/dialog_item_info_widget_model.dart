import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/service/warehouse_service.dart';

class DialogItemInfoWidgetModel {
  // MARK: - Properties

  String itemId = '';
  Item? combineItem;
  List<ItemPositionModel>? positions;
}
