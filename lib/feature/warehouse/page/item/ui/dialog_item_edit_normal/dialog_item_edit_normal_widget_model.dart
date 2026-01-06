import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

class DialogItemEditNormalWidgetModel {
  final isLoading = false.obs;
  final filePath = Rxn<String>();
  final photoUrl = Rxn<String>();
  String itemId = '';
  Item? combineItem;
  final selectedCategoryLevel1 = Rxn<WarehouseNameIdModel>();
  final selectedCategoryLevel2 = Rxn<WarehouseNameIdModel>();
  final selectedCategoryLevel3 = Rxn<WarehouseNameIdModel>();
  final visibleCategoryLevel1 = Rx<List<Category>>([]);
  final visibleCategoryLevel2 = Rx<List<Category>>([]);
  final visibleCategoryLevel3 = Rx<List<Category>>([]);
}

class DialogItemEditNormalOutputModel {
  String? name;
  int? minStockAlert;
  String? description;
  String? photo;
  String? categoryId;

  DialogItemEditNormalOutputModel({
    this.name,
    this.minStockAlert,
    this.description,
    this.photo,
    this.categoryId,
  });
}

class DialogItemEditNormalNormalOutputModel {
  String? name;
  int? minStockAlert;
  String? description;
  String? photo;
  String? categoryId;

  DialogItemEditNormalNormalOutputModel({
    this.name,
    this.minStockAlert,
    this.description,
    this.photo,
    this.categoryId,
  });
}
