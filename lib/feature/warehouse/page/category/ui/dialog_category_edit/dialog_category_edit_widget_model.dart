import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:get/get.dart';

class DialogCategoryEditWidgetModel {
  final isLoading = false.obs;
  Category? category;
  final name = ''.obs;
  final selectedLevel1 = Rxn<Category>();
  final selectedLevel2 = Rxn<Category>();
  final level1IsMax = false.obs;
  final level2IsMax = false.obs;
  final hintText = ''.obs;
  String combineName = '';
  int childLevel = 0;
}

class DialogCategoryEditOutputModel {
  String name;
  String? parentId;

  DialogCategoryEditOutputModel({
    required this.name,
    this.parentId,
  });
}
