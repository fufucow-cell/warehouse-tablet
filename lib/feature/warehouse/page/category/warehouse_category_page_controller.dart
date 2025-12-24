part of 'warehouse_category_page.dart';

class WarehouseCategoryPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseCategoryPageModel();
  final _service = WarehouseService.instance;
  RxReadonly<List<Category>?> get allCategoriesRx =>
      _model.allCategories.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug,
        '[WarehouseCategoryPageController] onInit - $hashCode');
    _checkData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug,
        '[WarehouseCategoryPageController] onClose - $hashCode');
    super.onClose();
  }

  // MARK: - Public Method

  int getTotalCategoryCount() {
    final categories = _model.allCategories.value;
    if (categories == null) {
      return 0;
    }

    int countRecursive(List<Category> cats) {
      int count = 0;
      for (final cat in cats) {
        count++; // Count current category
        if (cat.children != null && cat.children!.isNotEmpty) {
          count += countRecursive(cat.children!);
        }
      }
      return count;
    }

    return countRecursive(categories);
  }

  List<Category> getTopLevelCategories() {
    final categories = _model.allCategories.value;
    if (categories == null) {
      return [];
    }
    return categories.where((cat) => cat.parentId == null || cat.parentId!.isEmpty).toList();
  }

  bool isCategoryExpanded(Category category) {
    if (category.id == null) {
      return false;
    }
    return _model.expandedCategoryIds.contains(category.id);
  }

  void toggleCategoryExpanded(Category category) {
    if (category.id == null) {
      return;
    }
    if (_model.expandedCategoryIds.contains(category.id)) {
      _model.expandedCategoryIds.remove(category.id);
    } else {
      _model.expandedCategoryIds.add(category.id!);
    }
    update();
  }

  // MARK: - Private Method

  void _checkData() {
    final allCategories = _service.getAllCategories;

    if (allCategories == null) {
      _queryApiData();
    } else {
      _model.allCategories.value = allCategories;
    }
  }

  Future<void> _queryApiData() async {
    final response =
        await _service.apiReqFetchCategories(WarehouseCategoryRequestModel());
    _model.allCategories.value = response;
  }
}
