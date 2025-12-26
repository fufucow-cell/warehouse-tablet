import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:get/get.dart';

class DialogItemEditQuantityLocationModel {
  final String locationId;
  final String locationName;
  final int quantity;

  DialogItemEditQuantityLocationModel({
    required this.locationId,
    required this.locationName,
    required this.quantity,
  });
}

class NewLocationItemModel {
  String? selectedRoom;
  String? selectedCabinet;
  int quantity;

  NewLocationItemModel({
    this.selectedRoom,
    this.selectedCabinet,
    this.quantity = 1,
  });
}

class DialogItemEditQuantityWidgetModel {
  String itemId = '';
  Item? combineItem;
  final itemName = Rxn<String>();
  final currentQuantity = Rxn<int>();
  final locations = Rx<List<DialogItemEditQuantityLocationModel>>([]);
  final newLocations = Rx<List<NewLocationItemModel>>([]);

  int get totalQuantity {
    final existingQuantity = locations.value.fold<int>(
      0,
      (sum, location) => sum + location.quantity,
    );
    final newQuantity = newLocations.value.fold<int>(
      0,
      (sum, location) => sum + location.quantity,
    );
    return existingQuantity + newQuantity;
  }
}
