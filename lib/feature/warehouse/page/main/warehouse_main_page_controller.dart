part of 'warehouse_main_page.dart';

class WarehouseMainPageController extends BasePageController {
  // MARK: - Properties

  final _model = WarehouseMainPageModel();
  TabController? _tabController;
  TabController? get tabController => _tabController;
  bool get isTabControllerReady => _model.isTabControllerReady.value;
  RxBool get isTabControllerReadyRx => _model.isTabControllerReady;

  EnumWarehouseTabItem get selectedItem => _model.selectedItem.value;
  Rx<EnumWarehouseTabItem> get selectedItemRx => _model.selectedItem;
  List<Tab> get tabs => EnumWarehouseTabItem.values.map((item) => Tab(text: item.title)).toList();
  List<Widget> get tabViews => EnumWarehouseTabItem.values.map((item) => item.page).toList();

  // MARK: - Init

  WarehouseMainPageController(
    WarehouseMainPageRouterData routerData,
  ) {
    WarehouseService.register().updateData(routerData);
    _registerWarehouseApiUtil();
    super.init(isCallApiWhenInit: false);
  }

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(
      EnumLogType.debug,
      '[WarehouseMainPageController] onInit - $hashCode',
    );
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
    WarehouseService.instance.setRootContext(rootContext);
  }

  void initTabController(TickerProvider vsync) {
    _disposeTabController();
    _tabController = TabController(
      length: EnumWarehouseTabItem.values.length,
      vsync: vsync,
      initialIndex: EnumWarehouseTabItem.values.indexOf(_model.selectedItem.value),
    );
    _tabController!.addListener(_onTabChanged);
    isTabControllerReadyRx.value = true;
  }

  // MARK: - Private Method

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
}
