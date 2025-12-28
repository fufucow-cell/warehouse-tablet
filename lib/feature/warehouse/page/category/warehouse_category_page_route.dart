part of 'warehouse_category_page_controller.dart';

enum EnumWarehouseCategoryPageRoute {
  showDialogCreateCategory,
  showDialogEditCategory,
  showDialogDeleteCategory,
}

extension WarehouseCategoryPageRouteExtension on WarehouseCategoryPageController {
  void routerHandle(EnumWarehouseCategoryPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseCategoryPageRoute.showDialogCreateCategory:
        _service.showAlert(
          DialogCategoryCreateWidget(
            onConfirm: (outputModel) async {
              return await _createCategory(outputModel);
            },
          ),
        );
      case EnumWarehouseCategoryPageRoute.showDialogEditCategory:
        // _showDialogEditCategory(data);
        break;
      case EnumWarehouseCategoryPageRoute.showDialogDeleteCategory:
        // _showDialogDeleteCategory(data);
        break;
    }
  }
}
