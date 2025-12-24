part of 'warehouse_category_page.dart';

enum EnumWarehouseCategoryPageInteractive {
  tapSomeWidget,
  tapCreateCategory,
  tapEditCategory,
  tapDeleteCategory,
  tapExpandCategory,
}

extension WarehouseCategoryPageUserEventExtension on WarehouseCategoryPageController {
  void interactive(EnumWarehouseCategoryPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseCategoryPageInteractive.tapSomeWidget:
        break;
      case EnumWarehouseCategoryPageInteractive.tapCreateCategory:
        routerHandle(EnumWarehouseCategoryPageRoute.showCreateCategoryDialog);
        break;
      case EnumWarehouseCategoryPageInteractive.tapEditCategory:
        routerHandle(
          EnumWarehouseCategoryPageRoute.showEditCategoryDialog,
          data: data,
        );
        break;
      case EnumWarehouseCategoryPageInteractive.tapDeleteCategory:
        // TODO: 实现删除分类逻辑
        break;
      case EnumWarehouseCategoryPageInteractive.tapExpandCategory:
        if (data is Category) {
          toggleCategoryExpanded(data);
        }
        break;
    }
  }
}
