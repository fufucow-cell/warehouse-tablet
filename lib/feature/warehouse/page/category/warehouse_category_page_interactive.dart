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
        routerHandle(EnumWarehouseCategoryPageRoute.showCreateCategoryDialog);
      case EnumWarehouseCategoryPageInteractive.tapEditCategory:
        routerHandle(
          EnumWarehouseCategoryPageRoute.showEditCategoryDialog,
          data: data,
        );
      case EnumWarehouseCategoryPageInteractive.tapDeleteCategory:
        // TODO: 实现删除分类逻辑
        break;
      case EnumWarehouseCategoryPageInteractive.tapExpandCategory:
        if (data is Category) {
          toggleCategoryExpanded(data);
        }
    }
  }
}
