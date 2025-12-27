import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/dialog_category_create/dialog_category_create_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_category_create_widget_interactive.dart';
part 'dialog_category_create_widget_route.dart';

class DialogCategoryCreateWidgetController extends GetxController {
  // MARK: - Properties

  final DialogCategoryCreateWidgetModel _model = DialogCategoryCreateWidgetModel();
  final _service = WarehouseService.instance;
  final nameController = TextEditingController();
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  RxReadonly<Category?> get selectedParentCategoryRx => _model.selectedParentCategory.readonly;
  RxReadonly<List<Category>> get visibleParentCategoriesRx => _model.visibleParentCategories.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[DialogCategoryCreateWidgetController] onInit - $hashCode');
    _genParentCategoryList();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[DialogCategoryCreateWidgetController] onClose - $hashCode');
    nameController.dispose();
    super.onClose();
  }

  // MARK: - Public Method

  // 檢查輸出資料
  Future<DialogCategoryCreateOutputModel?> checkOutputModel() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      return null;
    }

    return DialogCategoryCreateOutputModel(
      name: name,
      parentCategoryId: _model.selectedParentCategory.value?.id,
    );
  }

  // 獲取父分類名稱列表（扁平化所有分類）
  List<String> getParentCategoryNameList() {
    return _flattenCategories(_model.visibleParentCategories.value)
        .map((cat) => cat.name ?? '')
        .toList();
  }

  // MARK: - Private Method

  // 設置加載狀態
  void _setLoadingStatus(bool isLoading) {
    _model.isLoading.value = isLoading;
  }

  // 扁平化分類列表（遞歸獲取所有層級的分類）
  List<Category> _flattenCategories(List<Category> categories) {
    final List<Category> result = [];
    for (final category in categories) {
      result.add(category);
      if (category.children != null && category.children!.isNotEmpty) {
        result.addAll(_flattenCategories(category.children!));
      }
    }
    return result;
  }

  // 生成父分類列表
  void _genParentCategoryList() {
    _model.selectedParentCategory.value = null;
    _model.visibleParentCategories.value = _service.getAllCategories;
  }

  // 選擇父分類
  void _changeSelectedParentCategory(String? categoryName) {
    final allCategories = _flattenCategories(_model.visibleParentCategories.value);
    final category = allCategories.firstWhereOrNull((cat) => cat.name == categoryName);
    _model.selectedParentCategory.value = category;
  }
}
