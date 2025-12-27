part of 'warehouse_main_page_controller.dart';

enum EnumWarehouseMainPageRoute {
  showCreateItemDialog,
  showSearchDialog,
}

extension WarehouseMainPageRouteExtension on WarehouseMainPageController {
  void routerHandle(
    EnumWarehouseMainPageRoute type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumWarehouseMainPageRoute.showCreateItemDialog:
        _service.showAlert(
          DialogItemCreateWidget(
            onConfirm: (outputModel) async {
              return await _createItem(outputModel);
            },
          ),
        );
      case EnumWarehouseMainPageRoute.showSearchDialog:
        _service.showAlert(
          DialogItemSearchWidget(
            onConfirm: _service.addSearchCondition,
          ),
        );
    }
  }
}
