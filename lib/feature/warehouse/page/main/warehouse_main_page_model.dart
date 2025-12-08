part of 'warehouse_main_page.dart';

class WarehouseMainPageModel {
  final selectedItem = EnumWarehouseTabItem.item.obs;
}

enum EnumWarehouseTabItem {
  item,
  cabinet,
  category,
  record,
  alarm;

  String get title => switch (this) {
        item => '物品',
        cabinet => '櫥櫃',
        category => '分類',
        record => '記錄',
        alarm => '告警',
      };

  Widget get page => switch (this) {
        item => const WarehouseItemPage(),
        cabinet => const WarehouseCabinetPage(),
        category => const WarehouseCategoryPage(),
        record => const WarehouseRecordPage(),
        alarm => const WarehouseAlarmPage(),
      };
}

class WarehouseMainPageRouterData {
  final String userId;
  final String userName;
  final String language;
  final int theme;
  final String accessToken;
  final String refreshToken;
  final WarehouseHomeRouterData household;
  final List<WarehouseHomeRouterData> rooms;
  final int userRoleType;

  const WarehouseMainPageRouterData({
    required this.userId,
    required this.userName,
    required this.language,
    required this.theme,
    required this.accessToken,
    required this.refreshToken,
    required this.household,
    this.rooms = const [],
    required this.userRoleType,
  });

  /// Factory method to create mock data from mock_data files
  /// Uses data from assets/mock_data/response/home_get.json
  factory WarehouseMainPageRouterData.mock() {
    // Mock data based on home_get.json
    return const WarehouseMainPageRouterData(
      userId: '770e8400-e29b-41d4-a716-446655440002',
      userName: 'John Doe',
      language: 'zh_TW',
      theme: 0,
      accessToken: 'mock_access_token_1234567890',
      refreshToken: 'mock_refresh_token_1234567890',
      household: WarehouseHomeRouterData(
        id: '550e8400-e29b-41d4-a716-446655440000',
        name: 'My Home',
      ),
      rooms: [
        WarehouseHomeRouterData(
          id: '990e8400-e29b-41d4-a716-446655440004',
          name: 'Living Room',
        ),
        WarehouseHomeRouterData(
          id: 'aa0e8400-e29b-41d4-a716-446655440005',
          name: 'Master Bedroom',
        ),
        WarehouseHomeRouterData(
          id: 'bb0e8400-e29b-41d4-a716-446655440006',
          name: 'Guest Bedroom',
        ),
        WarehouseHomeRouterData(
          id: 'cc0e8400-e29b-41d4-a716-446655440007',
          name: 'Kitchen',
        ),
        WarehouseHomeRouterData(
          id: 'dd0e8400-e29b-41d4-a716-446655440008',
          name: 'Bathroom',
        ),
      ],
      userRoleType: 1,
    );
  }
}

class WarehouseHomeRouterData {
  final String id;
  final String name;

  const WarehouseHomeRouterData({
    required this.id,
    required this.name,
  });
}
