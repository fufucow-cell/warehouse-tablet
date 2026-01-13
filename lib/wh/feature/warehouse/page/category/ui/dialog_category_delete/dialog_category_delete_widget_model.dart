import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:get/get.dart';

class DialogCategoryDeleteWidgetModel {
  final isLoading = false.obs;
  Category? category;
}

class DialogCategoryDeleteOutputModel {
  String categoryId;

  DialogCategoryDeleteOutputModel({
    required this.categoryId,
  });
}
