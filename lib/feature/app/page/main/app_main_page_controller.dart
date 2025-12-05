part of 'app_main_page.dart';

class AppMainPageController extends BasePageController {
  // MARK: - Properties

  final _model = AppMainPageModel();
  EnumAppMainTabItem get getSelectedItem =>
      _model.selectedItem.value;
  String get getInitRoutePath =>
      AppMainRouterUtil.rootRouter.path;
  GlobalKey<NavigatorState> get getNavigatorKey =>
      AppMainRouterUtil.instance.nestedNavigatorKey;
  AppMainRouterUtil get getRouterUtil =>
      AppMainRouterUtil.instance;

  // MARK: - Init

  AppMainPageController() {
    super.init(isCallApiWhenInit: false);
    AppMainRouterUtil.register();
    SmartHomeService.register();
  }

  // MARK: - Override Method

  @override
  void onClose() {
    SmartHomeService.unregister();
    AppMainRouterUtil.unregister();
    super.onClose();
  }

  // MARK: - Public Method

  Route<dynamic> generateRoute(RouteSettings settings) =>
      getRouterUtil.generateRoute(settings);

  // MARK: - Private Method

  Future<void> _selectItem(EnumAppMainTabItem item) async {
    if (_model.selectedItem.value != item) {
      _model.selectedItem.value = item;
      routerHandle(
        EnumAppMainPageRoute.switchContentPage,
        data: item,
      );
      update();
    }
  }
}
