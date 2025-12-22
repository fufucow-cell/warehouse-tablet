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
