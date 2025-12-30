part of 'smart_home_warehouse_page.dart';

class SmartHomeWarehousePageController extends BasePageController {
  // MARK: - Init

  SmartHomeWarehousePageController() {
    super.init(isCallApiWhenInit: false);
  }

  // MARK: - Methods

  @override
  Future<void> apiProcessing() async {}

  WarehouseMainPageRouterData getWarehouseMainPageRouterData() {
    final service = SmartHomeService.instance;
    final userData = service.getUserData;
    final houseData = service.getHouseholdData;
    return WarehouseMainPageRouterData(
      userId: userData?.id ?? '',
      userName: userData?.userName ?? '',
      language: LocaleUtil.instance.getCurrentLocaleCode,
      theme: ThemeUtil.instance.currentTheme.name,
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
