part of 'warehouse_category_page.dart';

class WarehouseCategoryPageModel {
  List<Category>? categories;
  List<Category>? allCategories; // 保存所有原始分类数据
  final isEditMode = false.obs;
  // 记录展开的分类 ID (level 1 和 level 2)
  // 默认为空 Set，表示所有 level 1 分类默认都是收合状态
  final Set<String?> expandedCategoryIds = <String?>{};
  String? filterName;
  int? filterLevel;
}
