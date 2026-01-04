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
      domain: service.getDomain,
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

  WarehouseMainPageRouterData getMockData() {
    return const WarehouseMainPageRouterData(
      userId: 'cow_test_user_Id',
      userName: 'Cow',
      language: 'zh_TW',
      theme: 'light',
      userRoleType: 0,
      domain: 'http://127.0.0.1:8000/api/v1/warehouse/',
      accessToken:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYzEwZTliNmEtNGEwOC00ZjUyLWEwNzEtZjIwMDFjMTRmZDIyIiwiZXhwIjoxNzY1NTI1NjkyLCJ0eXBlIjoiYWNjZXNzIn0.ygWKs1dgE085D-v7AH8QlowrOn_dPu-VlDW0t1fD-Bg',
      refreshToken:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYzEwZTliNmEtNGEwOC00ZjUyLWEwNzEtZjIwMDFjMTRmZDIyIiwiZXhwIjoxNzY2MTI4NjkyLCJ0eXBlIjoicmVmcmVzaCJ9.8jvVyRQteWLqR6Lnz1mI0HHabXKnd_CBaIcf6gCvyg8',
      household: WarehouseHomeRouterData(
        id: '47e2a9b1-8c3d-4e5f-9a2b-1c0d5e6f7a8b',
        name: '牛窩',
      ),
      rooms: [
        WarehouseHomeRouterData(
          id: 'b92f3a4c-d5e6-4172-8394-a5b6c7d8e9f0',
          name: '客廳',
        ),
        WarehouseHomeRouterData(
          id: '1a2b3c4d-5e6f-4001-9123-456789abcdef',
          name: '廚房',
        ),
        WarehouseHomeRouterData(
          id: 'f8e7d6c5-b4a3-4210-9988-776655443322',
          name: '主臥',
        ),
        WarehouseHomeRouterData(
          id: 'c0a80101-3b2a-4c5d-8e9f-0123456789ab',
          name: '客房',
        ),
        WarehouseHomeRouterData(
          id: 'd9b8a7c6-e5f4-4321-b0a1-9c8d7e6f5a4b',
          name: '浴室',
        ),
      ],
    );
  }
}
