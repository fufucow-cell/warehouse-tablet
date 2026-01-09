// ignore_for_file: prefer_const_constructors

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
    this.rooms = const [],
    this.userAvatar,
    required this.userRoleType,
  });

  /// Factory method to create mock data from mock_data files
  /// Uses data from assets/mock_data/response/home_get.json
  factory WarehouseMainPageRouterData.mock() {
    // Mock data based on home_get.json
    return WarehouseMainPageRouterData(
      userId: 'cow_test_user_Id',
      userName: 'Cow',
      language: 'zh_TW',
      theme: 'light',
      userAvatar: 'https://cdn-icons-png.flaticon.com/512/6858/6858485.png',
      userRoleType: 0,
      domain: 'http://192.168.31.159:8000/api/v1/warehouse/',
      environment: 'dev',
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

class WarehouseHomeRouterData {
  final String id;
  final String name;

  const WarehouseHomeRouterData({
    required this.id,
    required this.name,
  });
}
