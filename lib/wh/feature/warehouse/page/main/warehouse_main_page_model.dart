// ignore_for_file: prefer_const_constructors

import 'package:engo_terminal_app3/wh/feature/warehouse/page/alarm/warehouse_alarm_page.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/cabinet/warehouse_cabinet_page.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/category/warehouse_category_page.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/warehouse_item_page.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/record/warehouse_record_page.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WarehouseMainPageModel {
  final isTabControllerReady = false.obs;
  final isLoading = false.obs;
  WarehouseMainPageRouterData? routerData;
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
        item => WarehouseItemPage(),
        cabinet => WarehouseCabinetPage(),
        category => WarehouseCategoryPage(),
        record => WarehouseRecordPage(),
        alarm => WarehouseAlarmPage(),
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
  final String environment;
  final WarehouseHomeRouterData household;
  final List<WarehouseHomeRouterData> rooms;
  final int userRoleType;
  final bool isModuleMode;
  final String? userAvatar;

  const WarehouseMainPageRouterData({
    required this.userId,
    required this.userName,
    required this.language,
    required this.theme,
    required this.domain,
    required this.environment,
    required this.accessToken,
    required this.refreshToken,
    required this.household,
    required this.isModuleMode,
    this.rooms = const [],
    this.userAvatar,
    required this.userRoleType,
  });

  /// Factory method to create mock data from mock_data files
  /// Uses data from assets/mock_data/response/home_get.json
  factory WarehouseMainPageRouterData.mock({required EnumEnvironment env, String? theme, String? locale, bool? isModuleMode}) {
    // Mock data based on home_get.json
    return WarehouseMainPageRouterData(
      userId: 'cow_test_user_Id',
      userName: 'Cow',
      language: locale ?? 'zh_TW',
      theme: theme ?? 'light',
      userAvatar: 'https://cdn-icons-png.flaticon.com/512/6858/6858485.png',
      userRoleType: 0,
      domain: env.domainUrl,
      environment: env.name,
      isModuleMode: isModuleMode ?? true,
      accessToken: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ2YWx1ZSI6MX0.Lbr3YauR2Fbm_IS4YqqVuLS853Dn8xKQP6lTH3PDx5k',
      refreshToken: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ2YWx1ZSI6MX0.FlG1RDLUyt8CBb0TKmuvzHAb8R7wL5U2Uyhhw0YTXTw',
      household: WarehouseHomeRouterData(
        id: '1',
        name: '牛窩',
      ),
      rooms: [
        WarehouseHomeRouterData(
          id: '1',
          name: '客廳',
        ),
        WarehouseHomeRouterData(
          id: '2',
          name: '廚房',
        ),
        WarehouseHomeRouterData(
          id: '3',
          name: '主臥',
        ),
        WarehouseHomeRouterData(
          id: '4',
          name: '客房',
        ),
        WarehouseHomeRouterData(
          id: '5',
          name: '浴室',
        ),
      ],
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
