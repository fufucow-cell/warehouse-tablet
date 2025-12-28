import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:get/get.dart';

class DialogCategoryCreateWidgetModel {
  final isLoading = false.obs;
  final name = ''.obs;
  final selectedLevel1 = Rxn<Category>();
  final selectedLevel2 = Rxn<Category>();
  final hintText = ''.obs;
}

class DialogCategoryCreateOutputModel {
  String name;
  String? parentId;

  DialogCategoryCreateOutputModel({
    required this.name,
    this.parentId,
  });
}
