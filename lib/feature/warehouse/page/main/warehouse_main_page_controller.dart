part of 'warehouse_main_page.dart';

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
      _service.apiReqFetchCategories(WarehouseCategoryRequestModel()),
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

    if (isSuccess) {
      _service.showSnackBar(title: '創建物品成功');
      unawaited(_service.apiReqFetchItems(WarehouseItemRequestModel()));
      return true;
    } else {
      _service.showSnackBar(title: '創建物品失敗', message: errMsg);
      return false;
    }
  }
}
