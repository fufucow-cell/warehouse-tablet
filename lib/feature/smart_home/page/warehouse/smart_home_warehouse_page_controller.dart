part of 'smart_home_warehouse_page.dart';

class SmartHomeWarehousePageController extends GetxController {
  // MARK: - Init

  SmartHomeWarehousePageController();

  // MARK: - Public Method

  WarehouseMainPageRouterData get getWarehouseMainPageRouterData => WarehouseMainPageRouterData.mock(
        theme: ThemeService.instance.currentTheme.name,
        locale: LocaleService.instance.getCurrentLocaleCode,
        isModuleMode: false,
      );
}
