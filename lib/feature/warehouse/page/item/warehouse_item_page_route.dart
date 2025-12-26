part of 'warehouse_item_page.dart';

enum EnumWarehouseItemPageRoute {
  showDialogItemNormalEdit,
  showDialogItemQuantityEdit,
  showDialogItemPositionEdit,
  showDialogItemInfo,
}

extension WarehouseItemPageRouteExtension on WarehouseItemPageController {
  void routerHandle(EnumWarehouseItemPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseItemPageRoute.showDialogItemNormalEdit:
        if (data is Item) {
          _service.showAlert(
            DialogItemNormalEditWidget(
              itemId: data.id!,
              onConfirm: (outputModel) async {
                return await _updateItemNormal(data, outputModel);
              },
            ),
          );
        }
      case EnumWarehouseItemPageRoute.showDialogItemQuantityEdit:
        if (data is Item && (data.id?.isNotEmpty ?? false)) {
          _service.showAlert(
            DialogItemEditQuantityWidget(
              itemId: data.id!,
              onConfirm: (outputModel) async {
                return await _updateItemQuantity(data, outputModel);
              },
            ),
          );
        }
      case EnumWarehouseItemPageRoute.showDialogItemPositionEdit:
        if (data is Item && (data.id?.isNotEmpty ?? false)) {
          _service.showAlert(
            DialogItemEditPositionWidget(
              itemId: data.id!,
              onConfirm: (outputModel) async {
                return await _updateItemPosition(data, outputModel);
              },
            ),
          );
        }
      case EnumWarehouseItemPageRoute.showDialogItemInfo:
        if (data is Item && (data.id?.isNotEmpty ?? false)) {
          _service.showAlert(
            DialogItemInfoWidget(data.id!),
          );
        }
    }
  }
}
