import 'package:engo_terminal_app3/wh/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:get/get.dart';

class WarehouseCategoryPageModel {
  final allCategories = Rxn<List<Category>>();
  final expandedCategoryIds = Rx<Set<String>>({});
  Worker? allCategoriesWorker;
}
