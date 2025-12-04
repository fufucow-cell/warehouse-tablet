import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/smart_home/page/household/smart_home_household_page.dart';
import 'package:flutter_smart_home_tablet/feature/smart_home/page/message/smart_home_message_page.dart';
import 'package:flutter_smart_home_tablet/feature/smart_home/page/repair/smart_home_repair_page.dart';
import 'package:flutter_smart_home_tablet/feature/smart_home/page/scene/smart_home_scene_page.dart';
import 'package:flutter_smart_home_tablet/feature/smart_home/page/setting/smart_home_setting_page.dart';
import 'package:flutter_smart_home_tablet/feature/smart_home/page/warehouse/smart_home_warehouse_page.dart';

enum EnumAppMainRouter {
  household,
  scene,
  message,
  repair,
  warehouse,
  setting;

  static EnumAppMainRouter get defaultRouter => EnumAppMainRouter.household;
  String get path => this == defaultRouter ? '/' : '/home_$name';

  Widget Function() get page => () => switch (this) {
        household => const SmartHomeHouseholdPage(),
        scene => const SmartHomeScenePage(),
        message => const SmartHomeMessagePage(),
        repair => const SmartHomeRepairPage(),
        warehouse => const SmartHomeWarehousePage(),
        setting => const SmartHomeSettingPage(),
      };
}
