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
  final WarehouseMainRouterHousehold household;
  final List<WarehouseMainRouterRoom> rooms;
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
}

/// WarehouseMainPage Router 传递的房屋数据
class WarehouseMainRouterHousehold {
  final String id;
  final String name;

  const WarehouseMainRouterHousehold({
    required this.id,
    required this.name,
  });
}

/// WarehouseMainPage Router 传递的房间数据
class WarehouseMainRouterRoom {
  final String id;
  final String name;

  const WarehouseMainRouterRoom({
    required this.id,
    required this.name,
  });
}
