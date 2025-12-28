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
        if (data is Category) {
          final categoryId = data.id ?? '';
          _service.showAlert(
            DialogCategoryEditWidget(
              category: data,
              onConfirm: (outputModel) async {
                return await _updateCategory(outputModel, categoryId);
              },
            ),
          );
        }
      case EnumWarehouseCategoryPageRoute.showDialogDeleteCategory:
        if (data is Category) {
          _service.showAlert(
            DialogCategoryDeleteWidget(
              category: data,
              onConfirm: (outputModel) async {
                return await _deleteCategory(outputModel);
              },
            ),
          );
        }
    }
  }
}
