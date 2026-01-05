import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:get/get.dart';

class WarehouseCategoryPageModel {
  final allCategories = Rxn<List<Category>>();
  final expandedCategoryIds = Rx<Set<String>>({});
  Worker? allCategoriesWorker;
}
