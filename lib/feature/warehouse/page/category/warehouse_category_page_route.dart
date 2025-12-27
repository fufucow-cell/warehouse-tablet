part of 'warehouse_category_page.dart';

enum EnumWarehouseCategoryPageRoute {
  showSomeDialog,
  showCreateCategoryDialog,
  showEditCategoryDialog,
}

extension WarehouseCategoryPageRouteExtension on WarehouseCategoryPageController {
  void routerHandle(EnumWarehouseCategoryPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseCategoryPageRoute.showSomeDialog:
        break;
      case EnumWarehouseCategoryPageRoute.showCreateCategoryDialog:
        _showCreateCategoryDialog();
        break;
      case EnumWarehouseCategoryPageRoute.showEditCategoryDialog:
        _showEditCategoryDialog(data);
        break;
    }
  }

  Future<void> _showCreateCategoryDialog() async {
    try {
      // TODO: Implement create category dialog
      // final service = WarehouseService.instance;
      // service.showAlert(const DialogCategoryCreate());
    } on Exception catch (e) {
      // 错误处理
      final context = Get.context;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(EnumLocale.warehouseErrorFetchData.trArgs([e.toString()])),
          ),
        );
      }
    }
  }

  Future<void> _showEditCategoryDialog(dynamic data) async {
    try {
      final service = WarehouseService.instance;
      if (data is Category) {
        service.showAlert(DialogCategoryEdit(category: data));
      } else {
        service.showAlert(const DialogCategoryEdit());
      }
    } on Exception catch (e) {
      // 错误处理
      final context = Get.context;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(EnumLocale.warehouseErrorFetchData.trArgs([e.toString()])),
          ),
        );
      }
    }
  }
}
