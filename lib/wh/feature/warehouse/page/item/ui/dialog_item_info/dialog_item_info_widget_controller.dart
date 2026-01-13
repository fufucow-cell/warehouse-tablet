import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/ui/dialog_item_history/dialog_item_history_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/ui/dialog_item_info/dialog_item_info_widget_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/service/warehouse_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'dialog_item_info_widget_interactive.dart';
part 'dialog_item_info_widget_route.dart';

class DialogItemInfoWidgetController extends GetxController {
  // MARK: - Properties

  final DialogItemInfoWidgetModel _model = DialogItemInfoWidgetModel();
  final _service = WarehouseService.instance;
  Item? get combineItem => _model.combineItem;
  String get getTitle => _model.combineItem?.name ?? '';
  String get getDescription => _model.combineItem?.description ?? '';
  String get getPhoto => _model.combineItem?.photo ?? '';
  String get getMinStockAlert => _model.combineItem?.minStockAlert?.toString() ?? '0';
  String get getCategoryName => _service.convertCategoriesName(_model.combineItem);
  List<ItemPositionModel> get getPositions => _model.positions ?? [];

  // MARK: - Init

  DialogItemInfoWidgetController(String itemId) {
    _model.itemId = itemId;
  }

  @override
  void onInit() {
    super.onInit();
    LogService.instance.i(
      EnumLogType.debug,
      '[DialogItemInfoWidgetController] onInit - $hashCode',
    );
    _loadItemData();
  }

  @override
  void onClose() {
    LogService.instance.i(
      EnumLogType.debug,
      '[DialogItemInfoWidgetController] onClose - $hashCode',
    );
    super.onClose();
  }

  // MARK: - Private Method

  void _loadItemData() {
    final item = _service.getAllCombineItems.firstWhereOrNull((item) => item.id == _model.itemId);

    if (item == null) {
      return;
    }

    _model.combineItem = item;
    _model.positions = _service.genItemPositionsFromRoomCabinet(item);
  }
}
