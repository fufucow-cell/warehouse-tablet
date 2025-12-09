part of 'smart_home_warehouse_page.dart';

class SmartHomeWarehousePageController
    extends BasePageController {
  // Properties

  final _service = LocaleUtil.instance;

  // MARK: - Init

  SmartHomeWarehousePageController() {
    super.init(isCallApiWhenInit: false);
  }

  // MARK: - Methods

  @override
  Future<void> apiProcessing() async {}

  WarehouseMainPageRouterData
      getWarehouseMainPageRouterData() {
    final service = SmartHomeService.instance;
    final userData = service.getUserData;
    final houseData = service.getHouseholdData;
    return WarehouseMainPageRouterData(
      userId: userData?.id ?? '',
      userName: userData?.userName ?? '',
      language: _service.getCurrentLocaleCode,
      theme: userData?.preferences?.theme ?? 0,
      accessToken: userData?.accessToken ?? '',
      refreshToken: userData?.refreshToken ?? '',
      household: WarehouseHomeRouterData(
        id: houseData?.homeId?.toString() ?? '',
        name: houseData?.homeName ?? '',
      ),
      rooms: houseData?.rooms
              ?.map(
                (room) => WarehouseHomeRouterData(
                  id: room.roomId?.toString() ?? '',
                  name: room.roomName ?? '',
                ),
              )
              .toList() ??
          [],
      userRoleType:
          userData?.household?.first.roleType ?? 0,
    );
  }
}
