part of 'warehouse_category_page.dart';

class WarehouseCategoryPageController extends BasePageController {
  // MARK: - Properties

  final _model = WarehouseCategoryPageModel();
  List<Category>? get categories => _model.categories;
  Rx<bool> get isEditModeRx => _model.isEditMode;

  // MARK: - Init

  WarehouseCategoryPageController() {
    super.init();
  }

  // MARK: - Methods

  @override
  Future<void> apiProcessing() async {
    final response = await ApiUtil.sendRequest<WarehouseCategoryResponseModel>(
      EnumApiInfo.categoryFetch,
      requestModel: WarehouseCategoryRequestModel(),
      fromJson: WarehouseCategoryResponseModel.fromJson,
    );

    _model.categories = response.data;
    update();
  }

  @override
  Future<void> apiProcessFail(
    BaseApiResponseModel<dynamic> error, {
    bool isFirstLoad = false,
  }) async {
    print(error);
  }

  // 展平树形结构为列表（用于显示）
  List<Category> getFlattenedCategories() {
    final List<Category> result = [];

    Category? childrenToCategory(
      Children? children,
    ) {
      if (children == null) return null;
      return Category(
        categoryId: children.categoryId,
        name: children.name,
        parentId: children.parentId,
        level: children.level,
        children: children.children is Map<String, dynamic>
            ? Children.fromJson(
                children.children as Map<String, dynamic>,
              )
            : null,
      );
    }

    void traverse(
      Category? category,
    ) {
      if (category == null) return;
      result.add(category);

      // 如果是 level 1 或 level 2，检查是否展开
      // 如果未展开，则不遍历子分类（收合状态）
      final level = category.level ?? 0;
      if (level == 1 || level == 2) {
        final isExpanded = _model.expandedCategoryIds.contains(category.categoryId);
        if (!isExpanded) {
          return; // 未展开，不显示子分类
        }
      }

      // 遍历子分类
      final childCategory = childrenToCategory(category.children);
      if (childCategory != null) {
        traverse(childCategory);
      }
    }

    if (_model.categories != null) {
      for (final category in _model.categories!) {
        traverse(category);
      }
    }
    return result;
  }

  // 切换分类的展开/收合状态
  void toggleCategoryExpansion(Category category) {
    final categoryId = category.categoryId;
    if (categoryId == null) return;

    if (_model.expandedCategoryIds.contains(categoryId)) {
      _model.expandedCategoryIds.remove(categoryId);
    } else {
      _model.expandedCategoryIds.add(categoryId);
    }
    update();
  }

  // 检查分类是否展开
  bool isCategoryExpanded(Category category) {
    return _model.expandedCategoryIds.contains(category.categoryId);
  }

  // 切换编辑模式
  void toggleEditMode() {
    _model.isEditMode.value = !_model.isEditMode.value;
    // Obx 会自动响应变化，但调用 update() 可以确保其他使用 GetBuilder 的部分也更新
    update();
  }

  // 删除分类
  void deleteCategory(Category category) {
    // TODO: 实现删除分类的逻辑
    print('删除分类: ${category.name} (${category.categoryId})');
  }
}
