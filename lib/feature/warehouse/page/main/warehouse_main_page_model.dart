import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/alarm/warehouse_alarm_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/warehouse_cabinet_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/warehouse_category_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/warehouse_item_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:get/get.dart';

class WarehouseMainPageModel {
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
        item => EnumLocale.item.tr,
        cabinet => EnumLocale.cabinet.tr,
        category => EnumLocale.category.tr,
        record => EnumLocale.record.tr,
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
  final String domain;
  final WarehouseHomeRouterData household;
  final List<WarehouseHomeRouterData> rooms;
  final int userRoleType;

  const WarehouseMainPageRouterData({
    required this.userId,
    required this.userName,
    required this.language,
    required this.theme,
    required this.domain,
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
    return WarehouseMainPageRouterData(
      userId: '770e8400-e29b-41d4-a716-446655440002',
      userName: 'John Doe',
      language: 'zh_TW',
      theme: 'system',
      accessToken: 'mock_access_token_1234567890',
      refreshToken: 'mock_refresh_token_1234567890',
      domain: 'http://127.0.0.1:8003',
      household: const WarehouseHomeRouterData(
        id: '550e8400-e29b-41d4-a716-446655440000',
        name: 'My Home',
      ),
      rooms: [
        WarehouseHomeRouterData(
          id: '00000001-e29b-41d4-a716-446655440001',
          name: EnumLocale.roomOffice.tr,
        ),
        WarehouseHomeRouterData(
          id: '00000002-e29b-41d4-a716-446655440002',
          name: EnumLocale.roomMasterBedroom.tr,
        ),
        WarehouseHomeRouterData(
          id: '00000003-e29b-41d4-a716-446655440003',
          name: EnumLocale.roomMeetingRoom.tr,
        ),
        WarehouseHomeRouterData(
          id: '00000004-e29b-41d4-a716-446655440004',
          name: EnumLocale.roomKitchen.tr,
        ),
        WarehouseHomeRouterData(
          id: '00000005-e29b-41d4-a716-446655440005',
          name: EnumLocale.roomChildrenRoom.tr,
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
