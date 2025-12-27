part of 'warehouse_category_page.dart';

class WarehouseCategoryPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseCategoryPageModel();
  final _service = WarehouseService.instance;
  final ScrollController scrollController = ScrollController();
  final Map<GlobalKey, double> _subHeaderPositions = {};
  final _showSubHeader = Rx<bool>(false);
  RxReadonly<List<Category>?> get allCategoriesRx => _model.allCategories.readonly;
  RxReadonly<Set<String>> get expandedCategoryIdsRx => _model.expandedCategoryIds.readonly;
  RxReadonly<bool> get showSubHeaderRx => _showSubHeader.readonly;
  Set<String> get getExpandedCategoryIds => _model.expandedCategoryIds.value;
  double get rowActionWidth => 280.0.scale;
  double get rowCountWidth => 400.0.scale;
  double get rowRightGap => 32.0.scale;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[WarehouseCategoryPageController] onInit - $hashCode');
    scrollController.addListener(_onScroll);
    _checkData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[WarehouseCategoryPageController] onClose - $hashCode');
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    final scrollOffset = scrollController.offset;
    // 检查是否有任何第二层 header 滚动到顶部
    bool shouldShowSubHeader = false;

    for (final position in _subHeaderPositions.values) {
      if (position > 0 && scrollOffset >= position - 100.0.scale) {
        shouldShowSubHeader = true;
        break;
      }
    }

    if (shouldShowSubHeader != _showSubHeader.value) {
      _showSubHeader.value = shouldShowSubHeader;
    }
  }

  void updateSubHeaderPosition(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final RenderBox? box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        final position = box.localToGlobal(Offset.zero);
        _subHeaderPositions[key] = position.dy;
        _onScroll();
      }
    }
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
        if (cat.children?.isNotEmpty ?? false) {
          count += countRecursive(cat.children!);
        }
      }
      return count;
    }

    return countRecursive(categories);
  }

  List<int> getEachLevelCategoryCount() {
    final categories = _model.allCategories.value;
    if (categories == null) {
      return [0, 0, 0];
    }

    final lv1 = categories.length;
    final lv2 = categories.fold<int>(0, (sum, category) => sum + (category.children?.length ?? 0));
    final lv3 = categories.fold<int>(
      0,
      (sum, category) => sum + (category.children?.fold<int>(0, (sum, category) => sum + (category.children?.length ?? 0)) ?? 0),
    );
    return [lv1, lv2, lv3];
  }

  List<Category> getChildrenList([Category? category]) {
    if (category == null) {
      return _service.getAllCategories;
    } else {
      return category.children ?? [];
    }
  }

  bool isCategoryExpanded(Category category) {
    return getExpandedCategoryIds.contains(category.id ?? '');
  }

  void toggleCategoryExpanded(Category category) {
    final expandedCategoryIds = Set<String>.from(getExpandedCategoryIds);

    if (getExpandedCategoryIds.contains(category.id)) {
      expandedCategoryIds.remove(category.id);
    } else {
      expandedCategoryIds.add(category.id!);
    }

    _model.expandedCategoryIds.value = expandedCategoryIds;
  }

  // MARK: - Private Method

  void _checkData() {
    final allCategories = _service.allCategoriesRx.value;
    _model.allCategories.value = allCategories;

    if (allCategories == null) {
      _queryApiData();
    }
  }

  Future<void> _queryApiData() async {
    _model.allCategories.value = null;
    final response = await _service.apiReqFetchCategories(WarehouseCategoryRequestModel());
    _model.allCategories.value = response;
  }
}
