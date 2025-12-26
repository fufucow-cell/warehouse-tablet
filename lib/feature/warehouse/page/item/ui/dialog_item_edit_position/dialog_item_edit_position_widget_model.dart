import 'package:get/get.dart';

class DialogItemEditPositionLocationModel {
  final String locationId;
  final String locationName;
  final int quantity;

  DialogItemEditPositionLocationModel({
    required this.locationId,
    required this.locationName,
    required this.quantity,
  });
}

class DialogItemEditPositionWidgetModel {
  String itemId = '';
  final itemName = Rxn<String>();
  final currentQuantity = Rxn<int>();
  final locations = Rx<List<DialogItemEditPositionLocationModel>>([]);
}
