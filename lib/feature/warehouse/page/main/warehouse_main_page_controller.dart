part of 'warehouse_main_page.dart';

class WarehouseMainPageController extends BasePageController {
  // MARK: - Properties

  final _model = WarehouseMainPageModel();
  late final TabController tabController;

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
    tabController = TabController(
      length: EnumWarehouseTabItem.values.length,
      vsync: vsync,
      initialIndex:
          EnumWarehouseTabItem.values.indexOf(_model.selectedItem.value),
    );
    tabController.addListener(_onTabChanged);
  }

  @override
  void onClose() {
    tabController.removeListener(_onTabChanged);
    tabController.dispose();
    WarehouseService.unregister();
    _unregisterWarehouseApiUtil();
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

  void _onTabChanged() {
    interactive(
      EnumWarehouseMainPageInteractive.selectTabItem,
      data: tabController.index,
    );
  }
}
