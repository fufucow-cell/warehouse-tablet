part of 'warehouse_main_page.dart';

class WarehouseMainPageController extends BasePageController {
  // MARK: - Properties

  final _model = WarehouseMainPageModel();
  final navigatorKey = GlobalKey<NavigatorState>();

  EnumWarehouseTabItem get selectedItem => _model.selectedItem.value;

  // MARK: - Init

  WarehouseMainPageController(
    WarehouseMainPageRouterData routerData,
  ) {
    UserData.register().updateData(routerData);
    super.init(isCallApiWhenInit: false);
    _registerWarehousePages();
  }

  @override
  void onClose() {
    UserData.unregister();
    super.onClose();
  }

  // MARK: - Private Method

  void _registerWarehousePages() {
    final warehousePages = AppRouter.getWarehousePages();
    Get.addPages(warehousePages);
  }

  /// 检查最近的 Navigator 是否是 root Navigator
  bool isRootNavigator(BuildContext context) {
    try {
      final rootNavigator =
          Navigator.of(context, rootNavigator: true);
      final currentNavigator =
          Navigator.of(context, rootNavigator: false);
      // 如果 root 和 current 是同一个实例，说明当前是 root Navigator
      return identical(rootNavigator, currentNavigator);
    } catch (e) {
      // 如果无法获取 Navigator，默认创建新的
      return true;
    }
  }
}
