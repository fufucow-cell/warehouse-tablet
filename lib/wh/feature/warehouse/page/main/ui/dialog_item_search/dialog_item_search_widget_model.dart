import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

class DialogItemSearchWidgetModel {
  final searchText = ''.obs;
  final selectedCategoryLevel1 = Rxn<Category>();
  final selectedCategoryLevel2 = Rxn<Category>();
  final selectedCategoryLevel3 = Rxn<Category>();
  final visibleCategoryLevel1 = Rx<List<Category>>([]);
  final visibleCategoryLevel2 = Rx<List<Category>>([]);
  final visibleCategoryLevel3 = Rx<List<Category>>([]);
}

class DialogItemSearchOutputModel {
  String? searchText;
  WarehouseNameIdModel? categoryLevel1;
  WarehouseNameIdModel? categoryLevel2;
  WarehouseNameIdModel? categoryLevel3;

  DialogItemSearchOutputModel({
    this.searchText,
    this.categoryLevel1,
    this.categoryLevel2,
    this.categoryLevel3,
  });
}
