import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/alarm/warehouse_alarm_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/warehouse_cabinet_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/warehouse_category_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/warehouse_item_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog_item_create/dialog_item_create_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog_item_create/dialog_item_create_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog_item_search/dialog_item_search_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_category_read_request_model/warehouse_category_read_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_create_request_model/warehouse_item_create_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_request_model/warehouse_item_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/api_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/environment_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'warehouse_main_page_interactive.dart';
part 'warehouse_main_page_route.dart';

class WarehouseMainPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseMainPageModel();
  WarehouseService get _service => WarehouseService.instance;
  TabController? _tabController;
  TabController? get tabController => _tabController;
  RxReadonly<bool> get isTabControllerReadyRx =>
      _model.isTabControllerReady.readonly;
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  RxReadonly<EnumWarehouseTabItem> get selectedItemRx =>
      _service.mainPageSelectedTabItemRx;
  List<Tab> get tabs =>
      EnumWarehouseTabItem.values.map((item) => Tab(text: item.title)).toList();
  List<Widget> get tabViews =>
      EnumWarehouseTabItem.values.map((item) => item.page).toList();

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(
      EnumLogType.debug,
      '[WarehouseMainPageController] onInit - $hashCode',
    );
    _listen();
  }

  @override
  void onClose() {
    LogUtil.i(
      EnumLogType.debug,
      '[WarehouseMainPageController] onClose - $hashCode',
    );
    _disposeTabController();
    _disposeTabPageControllers();
    WarehouseService.unregister();
    _unregisterWarehouseApiUtil();
    super.onClose();
  }

  // MARK: - Public Method

  void setRouterData(WarehouseMainPageRouterData routerData) {
    WarehouseService.register().updateData(routerData);
    _registerWarehouseApiUtil();
    _queryApiData();
  }

  void setRootContext(BuildContext context) {
    BuildContext? rootContext;

    try {
      final rootNavigator = Navigator.maybeOf(context, rootNavigator: true);

      if (rootNavigator != null) {
        rootContext = rootNavigator.context;
      } else {
        BuildContext? currentContext = context;

        while (currentContext != null) {
          final materialApp =
              currentContext.findAncestorWidgetOfExactType<MaterialApp>();

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
      LogUtil.e(
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
      _service.apiReqFetchItems(WarehouseItemRequestModel()),
      _service.apiReqReadCategory(WarehouseCategoryReadRequestModel()),
    ]);

    final items = responses[0];
    final categories = responses[1];
    _model.isLoading.value = (items == null || categories == null);
  }

  void _listen() {
    ever(
      selectedItemRx.rx,
      (value) {
        _tabController?.animateTo(EnumWarehouseTabItem.values.indexOf(value));
      },
    );
  }

  void _registerWarehouseApiUtil() {
    final envUtil = EnvironmentUtil.instance;
    ApiUtil.register(envUtil.apiBaseUrl);
  }

  void _unregisterWarehouseApiUtil() {
    ApiUtil.unregister();
  }

  void _disposeTabController() {
    if (_tabController != null) {
      try {
        _tabController!.removeListener(_onTabChanged);
        _tabController!.dispose();
      } on Object catch (e) {
        LogUtil.d(
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
    String errMsg = '';
    final requestModel = WarehouseItemCreateRequestModel(
      name: model.name,
      description: model.description,
      quantity: model.quantity,
      minStockAlert: model.minStockAlert,
      photo: model.photo,
      cabinetId: model.cabinetId,
      categoryId: model.categoryId,
      householdId: _service.getHouseholdId,
    );

    final response = await _service.apiReqCreateItem(
      requestModel,
      onError: (error) {
        errMsg = '[${error.code}] ${error.message ?? ''}';
      },
    );

    final isSuccess = response != null;
    _service.showSnackBar(
      title: isSuccess
          ? EnumLocale.warehouseItemCreateSuccess.tr
          : EnumLocale.warehouseItemCreateFailed.tr,
      message: errMsg,
    );
    return isSuccess;
  }
}
