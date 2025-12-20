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
  List<Tab> get tabs =>
      EnumWarehouseTabItem.values.map((item) => Tab(text: item.title)).toList();
  List<Widget> get tabViews =>
      EnumWarehouseTabItem.values.map((item) => item.page).toList();

  // MARK: - Init

  WarehouseMainPageController(
    WarehouseMainPageRouterData routerData,
  ) {
    WarehouseService.register().updateData(routerData);
    _registerWarehouseApiUtil();
    super.init(isCallApiWhenInit: false);
  }

  void initTabController(TickerProvider vsync) {
    _disposeTabController();
    _tabController = TabController(
      length: EnumWarehouseTabItem.values.length,
      vsync: vsync,
      initialIndex:
          EnumWarehouseTabItem.values.indexOf(_model.selectedItem.value),
    );
    _tabController!.addListener(_onTabChanged);
    isTabControllerReadyRx.value = true;
  }

  @override
  void onClose() {
    _disposeTabController();
    WarehouseService.unregister();
    _unregisterWarehouseApiUtil();
    TempRouterUtil.clear();
    super.onClose();
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
      } catch (e) {
        // TabController 可能已经被 dispose，忽略错误
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
}
