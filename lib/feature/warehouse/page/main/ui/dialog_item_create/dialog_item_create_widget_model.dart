import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

class DialogItemCreateWidgetModel {
  final isLoading = false.obs;
  final name = ''.obs;
  final description = ''.obs;
  final quantity = 0.obs;
  final minStockAlert = 0.obs;
  final filePath = Rxn<String>();
  final selectedRoom = Rxn<WarehouseNameIdModel>();
  final selectedCabinet = Rxn<WarehouseNameIdModel>();
  final selectedCategoryLevel1 = Rxn<WarehouseNameIdModel>();
  final selectedCategoryLevel2 = Rxn<WarehouseNameIdModel>();
  final selectedCategoryLevel3 = Rxn<WarehouseNameIdModel>();
  final visibleCabinets = Rx<List<WarehouseNameIdModel>>([]);
  final visibleCategoryLevel1 = Rx<List<Category>>([]);
  final visibleCategoryLevel2 = Rx<List<Category>>([]);
  final visibleCategoryLevel3 = Rx<List<Category>>([]);
}

class DialogItemCreateOutputModel {
  String name;
  int quantity;
  int minStockAlert;
  String? description;
  String? photo;
  String? cabinetId;
  String? categoryId;

  DialogItemCreateOutputModel({
    required this.name,
    required this.quantity,
    required this.minStockAlert,
    this.description,
    this.photo,
    this.cabinetId,
    this.categoryId,
  });
}
