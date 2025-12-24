part of 'warehouse_main_page.dart';

class WarehouseMainPageModel {
  final selectedItem = EnumWarehouseTabItem.item.obs;
  final isTabControllerReady = false.obs;
  final isLoading = false.obs;
}

enum EnumWarehouseTabItem {
  item,
  cabinet,
  category,
  record,
  alarm;

  String get title => switch (this) {
        item => EnumLocale.warehouseTabItem.tr,
        cabinet => EnumLocale.warehouseTabCabinet.tr,
        category => EnumLocale.warehouseTabCategory.tr,
        record => EnumLocale.warehouseTabRecord.tr,
        alarm => EnumLocale.warehouseTabAlarm.tr,
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
  final String theme;
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
      theme: 'system',
      accessToken: 'mock_access_token_1234567890',
      refreshToken: 'mock_refresh_token_1234567890',
      household: WarehouseHomeRouterData(
        id: '550e8400-e29b-41d4-a716-446655440000',
        name: 'My Home',
      ),
      rooms: [
        WarehouseHomeRouterData(
          id: '00000001-e29b-41d4-a716-446655440001',
          name: '辦公室',
        ),
        WarehouseHomeRouterData(
          id: '00000002-e29b-41d4-a716-446655440002',
          name: '主臥',
        ),
        WarehouseHomeRouterData(
          id: '00000003-e29b-41d4-a716-446655440003',
          name: '會議室',
        ),
        WarehouseHomeRouterData(
          id: '00000004-e29b-41d4-a716-446655440004',
          name: '廚房',
        ),
        WarehouseHomeRouterData(
          id: '00000005-e29b-41d4-a716-446655440005',
          name: '兒童房',
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
