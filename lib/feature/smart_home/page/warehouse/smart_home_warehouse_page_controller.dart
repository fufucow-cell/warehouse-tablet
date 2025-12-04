import 'dart:async';

import 'package:flutter_smart_home_tablet/feature/smart_home/page/warehouse/smart_home_warehouse_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/inherit/base_page_controller.dart';

class SmartHomeWarehousePageController extends BasePageController {
  // MARK: - Init

  SmartHomeWarehousePageController() {
    super.init();
  }

  // MARK: - Properties

  // MARK: - Methods

  @override
  Future<void> apiProcessing() async {}

  // MARK: - UserEvent

  void interactive(
    EnumSmartHomeWarehouseUserEvent type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumSmartHomeWarehouseUserEvent.tapSomeWidget:
        break;
    }
  }

  // MARK: - Router

  void _routerHandle(
    EnumSmartHomeWarehouseRoute type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumSmartHomeWarehouseRoute.goOtherPage:
        break;
      case EnumSmartHomeWarehouseRoute.showSomeDialog:
        break;
    }
  }
}
