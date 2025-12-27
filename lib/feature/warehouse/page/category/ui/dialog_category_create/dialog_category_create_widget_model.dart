import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:get/get.dart';

class DialogCategoryCreateWidgetModel {
  final isLoading = false.obs;
  final name = ''.obs;
  final selectedParentCategory = Rxn<Category>();
  final visibleParentCategories = Rx<List<Category>>([]);
}

class DialogCategoryCreateOutputModel {
  String name;
  String? parentCategoryId;

  DialogCategoryCreateOutputModel({
    required this.name,
    this.parentCategoryId,
  });
}
