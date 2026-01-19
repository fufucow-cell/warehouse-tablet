part of 'app_main_page.dart';

class AppMainPageController extends GetxController {
  // MARK: - Properties

  final _model = AppMainPageModel();
  final _appService = AppService.instance;
  EnumAppMainTabItem get getSelectedItem => _model.selectedItem.value;
  String get getInitRoutePath => AppService.rootRouter.path;
  GlobalKey<NavigatorState> get getNavigatorKey => _appService.nestedNavigatorKey;
  AppService get getRouterUtil => _appService;

  // MARK: - Init

  AppMainPageController() {
    SmartHomeService.register();
  }

  // MARK: - Override Method

  @override
  void onClose() {
    SmartHomeService.unregister();
    super.onClose();
  }

  // MARK: - Public Method

  Route<dynamic> generateRoute(RouteSettings settings) => getRouterUtil.generateRoute(settings);

  // MARK: - Private Method

  Future<void> _selectItem(EnumAppMainTabItem item) async {
    if (_model.selectedItem.value != item) {
      _model.selectedItem.value = item;
      await routerHandle(
        EnumAppMainPageRoute.switchContentPage,
        data: item,
      );
      update();
    }
  }
}
