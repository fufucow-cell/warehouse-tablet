part of 'warehouse_category_page.dart';

class WarehouseCategoryPageController extends BasePageController {
  // MARK: - Properties

  final _model = WarehouseCategoryPageModel();
  List<Category>? get categories => _model.categories;
  Rx<bool> get isEditModeRx => _model.isEditMode;
  String? get filterName => _model.filterName;
  int? get filterLevel => _model.filterLevel;

  // MARK: - Init

  WarehouseCategoryPageController() {
    super.init();
  }

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[WarehouseCategoryPageController] onInit - $hashCode');
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[WarehouseCategoryPageController] onClose - $hashCode');
    super.onClose();
  }

  // MARK: - Methods

  @override
  Future<void> apiProcessing() async {
    final response = await ApiUtil.sendRequest<WarehouseCategoryResponseModel>(
      EnumApiInfo.categoryFetch,
      requestModel: WarehouseCategoryRequestModel(),
      fromJson: WarehouseCategoryResponseModel.fromJson,
    );

    _model.allCategories = response?.data;
    _applyFilters();
    update();
  }

  // 应用筛选条件
  void applyFilters({
    String? name,
    int? level,
  }) {
    _model.filterName = name;
    _model.filterLevel = level;
    _applyFilters();
    update();
  }

  // 内部筛选方法
  void _applyFilters() {
    if (_model.allCategories == null) {
      _model.categories = null;
      return;
    }

    List<Category> filteredCategories = List.from(_model.allCategories!);

    // 按名称筛选（递归搜索所有分类及其子分类）
    if (_model.filterName != null && _model.filterName!.isNotEmpty) {
      final searchName = _model.filterName!.toLowerCase();
      filteredCategories = _filterByName(filteredCategories, searchName);
    }

    // 按階層筛选
    if (_model.filterLevel != null) {
      filteredCategories =
          _filterByLevel(filteredCategories, _model.filterLevel!);
    }

    _model.categories = filteredCategories;
  }

  // 按名称筛选（递归搜索）
  List<Category> _filterByName(List<Category> categories, String searchName) {
    final List<Category> result = [];

    bool matchesName(Category category) {
      final categoryName = category.name?.toLowerCase() ?? '';
      return categoryName.contains(searchName);
    }

    Category? childrenToCategory(Category? children) {
      return null;
      // if (children == null) return null;
      // return Category(
      //   id: children.id,
      //   name: children.name,
      //   parentId: children.parentId,
      //   children: children.children is Map<String, dynamic>
      //       ? Category.fromJson(
      //           children.children as Map<String, dynamic>,
      //         )
      //       : null,
      // );
    }

    void traverse(Category category, bool parentMatches) {
      final currentMatches = matchesName(category);
      final shouldInclude = currentMatches || parentMatches;

      if (shouldInclude) {
        result.add(category);
      }

      // 遍历子分类
      // final childCategory = childrenToCategory(category.children);
      // if (childCategory != null) {
      //   traverse(childCategory, shouldInclude);
      // }
    }

    for (final category in categories) {
      traverse(category, false);
    }

    return result;
  }

  // 按階層筛选
  List<Category> _filterByLevel(List<Category> categories, int targetLevel) {
    final List<Category> result = [];

    Category? childrenToCategory(Category? children) {
      return null;
      // if (children == null) return null;
      // return Category(
      //   id: children.id,
      //   name: children.name,
      //   parentId: children.parentId,
      //   children: children.children is Map<String, dynamic>
      //       ? Category.fromJson(
      //           children.children as Map<String, dynamic>,
      //         )
      //       : null,
      // );
    }

    void traverse(Category category, int currentLevel) {
      // 只添加目标階層的分类
      if (currentLevel == targetLevel) {
        result.add(category);
        // 如果匹配，还需要包含其子分类以保持层级关系
        // final childCategory = childrenToCategory(category.children);
        // if (childCategory != null) {
        //   traverse(childCategory, currentLevel + 1);
        // }
      } else if (currentLevel < targetLevel) {
        // 当前階層小于目标階層，继续向下搜索
        // final childCategory = childrenToCategory(category.children);
        // if (childCategory != null) {
        //   traverse(childCategory, currentLevel + 1);
        // }
      }
      // 如果 currentLevel > targetLevel，不再向下搜索
    }

    return result;
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
    return [];
  }

  // 切换分类的展开/收合状态
  void toggleCategoryExpansion(Category category) {
    // final categoryId = category.categoryId;
    // if (categoryId == null) return;

    // if (_model.expandedCategoryIds.contains(categoryId)) {
    //   _model.expandedCategoryIds.remove(categoryId);
    // } else {
    //   _model.expandedCategoryIds.add(categoryId);
    // }
    // update();
  }

  // 检查分类是否展开
  bool isCategoryExpanded(Category category) {
    // return _model.expandedCategoryIds.contains(category.categoryId);
    return false;
  }

  // 切换编辑模式
  void toggleEditMode() {
    // _model.isEditMode.value = !_model.isEditMode.value;
    // Obx 会自动响应变化，但调用 update() 可以确保其他使用 GetBuilder 的部分也更新
    // update();
  }

  // 删除分类
  void deleteCategory(Category category) {
    // TODO: 实现删除分类的逻辑
    // print('删除分类: ${category.name} (${category.categoryId})');
  }
}
