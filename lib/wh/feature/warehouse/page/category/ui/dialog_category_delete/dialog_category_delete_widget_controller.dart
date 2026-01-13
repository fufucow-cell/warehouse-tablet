import 'package:engo_terminal_app3/wh/feature/warehouse/page/category/ui/dialog_category_delete/dialog_category_delete_widget_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/service/warehouse_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'dialog_category_delete_widget_interactive.dart';
part 'dialog_category_delete_widget_route.dart';

class DialogCategoryDeleteWidgetController extends GetxController {
  // MARK: - Properties

  final DialogCategoryDeleteWidgetModel _model = DialogCategoryDeleteWidgetModel();
  final _service = WarehouseService.instance;
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  String get categoryName => _model.category?.name ?? '';

  // MARK: - Init

  DialogCategoryDeleteWidgetController(Category category) {
    _model.category = category;
  }

  @override
  void onInit() {
    super.onInit();
    LogService.instance.i(
      EnumLogType.debug,
      '[DialogCategoryDeleteWidgetController] onInit - $hashCode',
    );
  }

  @override
  void onClose() {
    LogService.instance.i(
      EnumLogType.debug,
      '[DialogCategoryDeleteWidgetController] onClose - $hashCode',
    );
    super.onClose();
  }

  // MARK: - Public Method

  // 檢查輸出資料
  Future<DialogCategoryDeleteOutputModel?> checkOutputModel() async {
    if (_model.category == null || _model.category?.id == null) {
      return null;
    }

    return DialogCategoryDeleteOutputModel(
      categoryId: _model.category!.id!,
    );
  }

  String getMessage() {
    final hasChildren = _model.category?.children?.isNotEmpty ?? false;
    if (hasChildren) {
      return EnumLocale.deleteCategoryMessageWithChildren.trArgs([categoryName]);
    } else {
      return EnumLocale.deleteCategoryMessageNoChildren.trArgs([categoryName]);
    }
  }

  // MARK: - Private Method

  void _setLoadingStatus(bool isLoading) {
    _model.isLoading.value = isLoading;
  }
}
