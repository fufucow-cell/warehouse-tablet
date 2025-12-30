part of 'warehouse_category_page_controller.dart';

enum EnumWarehouseCategoryPageInteractive {
  tapCreateCategory,
  tapEditCategory,
  tapDeleteCategory,
  tapExpandCategory,
}

extension WarehouseCategoryPageUserEventExtension on WarehouseCategoryPageController {
  void interactive(EnumWarehouseCategoryPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseCategoryPageInteractive.tapCreateCategory:
        routerHandle(EnumWarehouseCategoryPageRoute.showDialogCreateCategory);
      case EnumWarehouseCategoryPageInteractive.tapEditCategory:
        routerHandle(
          EnumWarehouseCategoryPageRoute.showDialogEditCategory,
          data: data,
        );
      case EnumWarehouseCategoryPageInteractive.tapDeleteCategory:
        routerHandle(
          EnumWarehouseCategoryPageRoute.showDialogDeleteCategory,
          data: data,
        );
      case EnumWarehouseCategoryPageInteractive.tapExpandCategory:
        if (data is Category) {
          toggleCategoryExpanded(data);
        }
    }
  }
}
