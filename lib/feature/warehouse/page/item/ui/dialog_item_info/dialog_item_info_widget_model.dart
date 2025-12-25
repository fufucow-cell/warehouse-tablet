import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:get/get.dart';

class DialogItemInfoWidgetModel {
  // MARK: - Properties

  String itemId = '';
  Item? combineItem;
  List<DialogItemInfopPositionModel>? positions;
}

class DialogItemInfopPositionModel {
  final String roomId;
  final String roomName;
  final List<DialogItemInfoCabinetModel> cabinets;

  DialogItemInfopPositionModel({
    required this.roomId,
    required this.roomName,
    required this.cabinets,
  });
}

class DialogItemInfoCabinetModel {
  final String cabinetId;
  final String cabinetName;
  final int quantity;

  DialogItemInfoCabinetModel({
    required this.cabinetId,
    required this.cabinetName,
    required this.quantity,
  });
}
