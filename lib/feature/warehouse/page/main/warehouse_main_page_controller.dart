part of 'warehouse_main_page.dart';

class WarehouseMainPageController extends BasePageController
    with SingleGetTickerProviderMixin {
  // MARK: - Properties

  final _model = WarehouseMainPageModel();
  late final TabController tabController;

  EnumWarehouseTabItem get selectedItem =>
      _model.selectedItem.value;
  List<Tab> get tabs => EnumWarehouseTabItem.values
      .map((item) => Tab(text: item.title))
      .toList();
  List<Widget> get tabViews => EnumWarehouseTabItem.values
      .map((item) => item.page)
      .toList();

  // MARK: - Init

  WarehouseMainPageController(
    WarehouseMainPageRouterData routerData,
  ) {
    WarehouseService.register().updateData(routerData);
    tabController = TabController(
      length: EnumWarehouseTabItem.values.length,
      vsync: this,
      initialIndex: EnumWarehouseTabItem.values
          .indexOf(_model.selectedItem.value),
    );
    tabController.addListener(_onTabChanged);
    super.init(isCallApiWhenInit: false);
  }

  @override
  void onClose() {
    tabController.removeListener(_onTabChanged);
    tabController.dispose();
    WarehouseService.unregister();
    super.onClose();
  }

  void _onTabChanged() {
    interactive(
      EnumWarehouseMainPageInteractive.selectTabItem,
      data: tabController.index,
    );
  }
}
