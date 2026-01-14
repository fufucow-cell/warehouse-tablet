import 'dart:async';

import 'package:engo_terminal_app3/wh/feature/warehouse/page/alarm/warehouse_alarm_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/cabinet/warehouse_cabinet_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/category/warehouse_category_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/warehouse_item_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/ui/dialog_item_create/dialog_item_create_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/ui/dialog_item_create/dialog_item_create_widget_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/ui/dialog_item_search/dialog_item_search_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/warehouse_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/record/warehouse_record_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_cabinet_read_request_model/warehouse_cabinet_read_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_category_read_request_model/warehouse_category_read_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_item_create_request_model/warehouse_item_create_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_item_request_model/warehouse_item_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/device_service/device_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/service/warehouse_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'warehouse_main_page_interactive.dart';
part 'warehouse_main_page_route.dart';

class WarehouseMainPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseMainPageModel();
  WarehouseService get _service => WarehouseService.instance;
  TabController? _tabController;
  TabController? get tabController => _tabController;
  RxReadonly<bool> get isTabControllerReadyRx => _model.isTabControllerReady.readonly;
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  RxReadonly<EnumWarehouseTabItem> get selectedItemRx => _service.mainPageSelectedTabItemRx;
  List<Tab> get tabs => EnumWarehouseTabItem.values.map((item) => Tab(text: item.title)).toList();
  List<Widget> get tabViews => EnumWarehouseTabItem.values.map((item) => item.page).toList();
  Worker? _selectedItemWorker;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    _addListeners();
  }

  @override
  void onClose() {
    LogService.instance.i(
      EnumLogType.debug,
      '[WarehouseMainPageController] onClose - $hashCode',
    );
    _selectedItemWorker?.dispose();
    _disposeTabController();
    _disposeTabPageControllers();
    WarehouseService.unregister();
    super.onClose();
  }

  // MARK: - Public Method

  void setRouterData(WarehouseMainPageRouterData routerData) {
    WarehouseService.register().initData(routerData);
    _queryApiData();
  }

  void setRootContext(BuildContext context) {
    DeviceService.register(context);
    BuildContext? rootContext;

    try {
      final rootNavigator = Navigator.maybeOf(context, rootNavigator: true);

      if (rootNavigator != null) {
        rootContext = rootNavigator.context;
      } else {
        BuildContext? currentContext = context;

        while (currentContext != null) {
          final materialApp = currentContext.findAncestorWidgetOfExactType<MaterialApp>();

          if (materialApp != null) {
            final navigator = Navigator.maybeOf(
              currentContext,
              rootNavigator: true,
            );

            if (navigator != null) {
              rootContext = navigator.context;
              break;
            }

            rootContext = currentContext;
            break;
          }

          final parent = currentContext.findAncestorStateOfType<State>();

          if (parent != null && parent.mounted) {
            currentContext = parent.context;
          } else {
            break;
          }
        }
      }
    } on Object catch (e) {
      LogService.instance.e(
        '[WarehouseMainPageController] Error setting root context: $e',
      );
    }

    rootContext ??= context;
    _service.setRootContext(rootContext);
  }

  void initTabController(TickerProvider vsync) {
    _disposeTabController();
    final selectedTabItem = _service.mainPageSelectedTabItemRx.value;
    _tabController = TabController(
      length: EnumWarehouseTabItem.values.length,
      vsync: vsync,
      initialIndex: EnumWarehouseTabItem.values.indexOf(selectedTabItem),
    );
    _tabController!.addListener(_onTabChanged);
    _model.isTabControllerReady.value = true;
  }

  // MARK: - Private Method

  Future<void> _queryApiData() async {
    final responses = await Future.wait([
      _service.apiReqReadItems(
        WarehouseItemRequestModel(householdId: _service.getHouseholdId),
      ),
      _service.apiReqReadCabinets(
        WarehouseCabinetReadRequestModel(
          householdId: _service.getHouseholdId,
        ),
      ),
      _service.apiReqReadCategory(
        WarehouseCategoryReadRequestModel(
          householdId: _service.getHouseholdId,
        ),
      ),
    ]);

    final items = responses[0];
    final categories = responses[1];
    _model.isLoading.value = (items == null || categories == null);
  }

  void _addListeners() {
    _selectedItemWorker = ever(
      selectedItemRx.rx,
      (value) {
        if (_model.isTabControllerReady.value && _tabController != null && !_tabController!.indexIsChanging) {
          final targetIndex = EnumWarehouseTabItem.values.indexOf(value);
          if (targetIndex >= 0 && targetIndex < EnumWarehouseTabItem.values.length) {
            _tabController!.animateTo(targetIndex);
          }
        }
      },
    );
  }

  void _disposeTabController() {
    if (_tabController != null) {
      try {
        _tabController!.removeListener(_onTabChanged);
        _tabController!.dispose();
      } on Object catch (e) {
        LogService.instance.d(
          '[WarehouseMainPageController] Error disposing TabController: $e',
        );
      }
      _tabController = null;
      _model.isTabControllerReady.value = false;
    }
  }

  void _onTabChanged() {
    if (_tabController != null) {
      interactive(
        EnumWarehouseMainPageInteractive.selectTabItem,
        data: _tabController!.index,
      );
    }
  }

  void _disposeTabPageControllers() {
    if (Get.isRegistered<WarehouseItemPageController>()) {
      Get.delete<WarehouseItemPageController>(force: true);
    }
    if (Get.isRegistered<WarehouseCabinetPageController>()) {
      Get.delete<WarehouseCabinetPageController>(force: true);
    }
    if (Get.isRegistered<WarehouseCategoryPageController>()) {
      Get.delete<WarehouseCategoryPageController>(force: true);
    }
    if (Get.isRegistered<WarehouseRecordPageController>()) {
      Get.delete<WarehouseRecordPageController>(force: true);
    }
    if (Get.isRegistered<WarehouseAlarmPageController>()) {
      Get.delete<WarehouseAlarmPageController>(force: true);
    }
  }

  Future<bool> _createItem(DialogItemCreateOutputModel model) async {
    final requestModel = WarehouseItemCreateRequestModel(
      name: model.name,
      description: model.description,
      quantity: model.quantity,
      minStockAlert: model.minStockAlert,
      photo: model.photo,
      cabinetId: model.cabinetId,
      categoryId: model.categoryId,
      householdId: _service.getHouseholdId,
      userName: _service.userName,
    );

    final response = await _service.apiReqCreateItem(
      requestModel,
    );

    final isSuccess = response != null;

    if (isSuccess) {
      unawaited(_queryApiData());
    }

    return isSuccess;
  }
}
