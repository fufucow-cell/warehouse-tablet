import 'package:engo_terminal_app3/feature/smart_home/service/smart_home_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/warehouse_main_page_model.dart';
import 'package:get/get.dart';

part 'smart_home_warehouse_page_interactive.dart';
part 'smart_home_warehouse_page_route.dart';

class SmartHomeWarehousePageController extends GetxController {
  // MARK: - Properties

  SmartHomeService get _service => SmartHomeService.instance;

  // MARK: - Init

  SmartHomeWarehousePageController();

  // MARK: - Public Method

  WarehouseMainPageRouterData get getWarehouseMainPageRouterData => WarehouseMainPageRouterData.mock(
        theme: _service.getCurrentThemeName,
        locale: _service.getCurrentLocaleCode,
        isModuleMode: false,
        env: _service.getCurrentEnvironment,
      );
}
