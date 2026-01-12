part of 'smart_home_warehouse_page.dart';

class SmartHomeWarehousePageController extends GetxController {
  // MARK: - Properties

  WarehouseMainPageRouterData getMockData() =>
      WarehouseMainPageRouterData.mock(theme: ThemeService.instance.currentTheme.name, locale: LocaleService.instance.getCurrentLocaleCode);

  // MARK: - Init

  SmartHomeWarehousePageController();

  // MARK: - Methods

  WarehouseMainPageRouterData getWarehouseMainPageRouterData() {
    final service = SmartHomeService.instance;
    final userData = service.getUserData;
    final houseData = service.getHouseholdData;

    return WarehouseMainPageRouterData(
      domain: service.getDomain,
      userId: userData?.id ?? '',
      userName: userData?.userName ?? '',
      language: LocaleService.instance.getCurrentLocaleCode,
      theme: ThemeService.instance.currentTheme.name,
      environment: EnvironmentService.instance.currentEnvironment.name,
      // language: userData?.preferences?.languageCode ?? '',
      // theme: userData?.preferences?.theme ?? '',
      accessToken: userData?.accessToken ?? '',
      refreshToken: userData?.refreshToken ?? '',
      household: WarehouseHomeRouterData(
        id: houseData?.householdId?.toString() ?? '',
        name: houseData?.homeName ?? '',
      ),
      rooms: houseData?.rooms
              ?.map(
                (room) => WarehouseHomeRouterData(
                  id: room.id?.toString() ?? '',
                  name: room.roomName ?? '',
                ),
              )
              .toList() ??
          [],
      userRoleType: userData?.household?.first.roleType ?? 0,
    );
  }
}
