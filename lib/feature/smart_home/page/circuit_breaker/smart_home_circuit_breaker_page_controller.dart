import 'dart:math';

import 'package:engo_terminal_app3/feature/smart_home/page/circuit_breaker/smart_home_circuit_breaker_page_model.dart';
import 'package:engo_terminal_app3/feature/smart_home/service/smart_home_service.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/alert_setting/circuit_breaker_alert_setting_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/data_record/circuit_breaker_data_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/main/circuit_breaker_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/notification_record/circuit_breaker_notification_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/data_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'smart_home_circuit_breaker_page_interactive.dart';
part 'smart_home_circuit_breaker_page_route.dart';

class SmartHomeCircuitBreakerPageController extends GetxController {
  final _model = SmartHomeCircuitBreakerPageModel();
  final _service = SmartHomeService.instance;

  SmartHomeCircuitBreakerPageController();

  void setContext(BuildContext context) {
    _model.context = context;
  }

  CircuitBreakerMainPageRouterData get getCircuitBreakerMainPageRouterData {
    return CircuitBreakerMainPageRouterData(
      language: _service.getCurrentLocaleCode,
      theme: _service.getCurrentThemeName,
      isModuleMode: false,
      circuitBreakerName: '斷電器',
      initialSwitchState: false,
      currentTemperature: '34°C',
      cumulativePowerConsumption: '1,234.5',
      todayPowerConsumption: '56.7',
      power: '2.5',
      voltage: '110',
      current: '22.7',
      onSwitchToggle: (bool newValue) async {
        routerHandle(
          EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
          data: SnackBarData('開關狀態變更', newValue ? '開啟' : '關閉'),
        );
      },
      onBackButtonTap: () {
        routerHandle(
          EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
          data: SnackBarData('點擊返回'),
        );
      },
      onEditButtonTap: (String oldName) async {
        routerHandle(
          EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
          data: SnackBarData('編輯斷電器名稱'),
        );
        return Future.value('新斷電器名稱');
      },
      onSettingButtonTap: () {
        routerHandle(
          EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
          data: SnackBarData('點擊設定'),
        );
      },
      onDataRecordItemTap: () async {
        return Future.value(getCircuitBreakerDataRecordPageRouterData);
      },
      onNotificationRecordItemTap: () async {
        return Future.value(getCircuitBreakerNotificationRecordPageRouterData);
      },
      onAlertSettingItemTap: () async {
        return Future.value(getCircuitBreakerAlertSettingPageRouterData);
      },
    );
  }

  CircuitBreakerDataRecordPageRouterData get getCircuitBreakerDataRecordPageRouterData {
    return CircuitBreakerDataRecordPageRouterData(
      onDataFilterChanged: (EnumTimeFilter timeFilter, DateTime selectedDate) async {
        return switch (timeFilter) {
          EnumTimeFilter.day => (chartData: _getDayChartData),
          EnumTimeFilter.month => (chartData: _getMonthChartData),
          EnumTimeFilter.year => (chartData: _getYearChartData),
          _ => (chartData: _getDayChartData),
        };
      },
      onSettingButtonTap: () {
        routerHandle(
          EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
          data: SnackBarData('點擊數據記錄設定'),
        );
      },
    );
  }

  CircuitBreakerNotificationRecordPageRouterData get getCircuitBreakerNotificationRecordPageRouterData {
    return CircuitBreakerNotificationRecordPageRouterData(
      onTabChanged: (EnumRecordType type) async {
        routerHandle(
          EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
          data: '切換到: ${type.title}',
        );

        switch (type) {
          case EnumRecordType.power:
            return _getSwitchRecordData;
          case EnumRecordType.alert:
            return _getAlertRecordData;
          case EnumRecordType.notification:
            return _getNotificationRecordData;
        }
      },
    );
  }

  CircuitBreakerAlertSettingPageRouterData get getCircuitBreakerAlertSettingPageRouterData {
    return CircuitBreakerAlertSettingPageRouterData(
      highTemperature: AlertSettingModel(
        value: 80.0,
        alertStatus: true,
        circuitStatus: false,
        onValueChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('更新設定數值: ${EnumAlertSetting.highTemperature.title} = $newValue'),
          );
        },
        onAlertSwitchChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('切換開關: ${EnumAlertSetting.highTemperature.title} - ${EnumLocale.engoSendAlert.tr} = $newValue'),
          );
        },
        onCircuitSwitchChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('切換開關: ${EnumAlertSetting.highTemperature.title} - ${EnumLocale.engoCircuitBreakerTrip.tr} = $newValue'),
          );
        },
      ),
      highPower: AlertSettingModel(
        value: 2000.0,
        alertStatus: true,
        circuitStatus: true,
        onValueChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('更新設定數值: ${EnumAlertSetting.highPower.title} = $newValue'),
          );
        },
        onAlertSwitchChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('切換開關: ${EnumAlertSetting.highPower.title} - ${EnumLocale.engoSendAlert.tr} = $newValue'),
          );
        },
        onCircuitSwitchChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('切換開關: ${EnumAlertSetting.highPower.title} - ${EnumLocale.engoCircuitBreakerTrip.tr} = $newValue'),
          );
        },
      ),
      overCurrent: AlertSettingModel(
        value: 30.0,
        alertStatus: false,
        circuitStatus: false,
        onValueChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('更新設定數值: ${EnumAlertSetting.overCurrent.title} = $newValue'),
          );
        },
        onAlertSwitchChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('切換開關: ${EnumAlertSetting.overCurrent.title} - ${EnumLocale.engoSendAlert.tr} = $newValue'),
          );
        },
        onCircuitSwitchChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('切換開關: ${EnumAlertSetting.overCurrent.title} - ${EnumLocale.engoCircuitBreakerTrip.tr} = $newValue'),
          );
        },
      ),
      voltage110Over: AlertSettingModel(
        value: 121.0,
        alertStatus: true,
        circuitStatus: true,
        onValueChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('更新設定數值: ${EnumAlertSetting.voltage110Over.title} = $newValue'),
          );
        },
        onAlertSwitchChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('切換開關: ${EnumAlertSetting.voltage110Over.title} - ${EnumLocale.engoSendAlert.tr} = $newValue'),
          );
        },
        onCircuitSwitchChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('切換開關: ${EnumAlertSetting.voltage110Over.title} - ${EnumLocale.engoCircuitBreakerTrip.tr} = $newValue'),
          );
        },
      ),
      voltage110Under: AlertSettingModel(
        value: 99.0,
        alertStatus: true,
        circuitStatus: false,
        onValueChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('更新設定數值: ${EnumAlertSetting.voltage110Under.title} = $newValue'),
          );
        },
        onAlertSwitchChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('切換開關: ${EnumAlertSetting.voltage110Under.title} - ${EnumLocale.engoSendAlert.tr} = $newValue'),
          );
        },
        onCircuitSwitchChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('切換開關: ${EnumAlertSetting.voltage110Under.title} - ${EnumLocale.engoCircuitBreakerTrip.tr} = $newValue'),
          );
        },
      ),
      voltage220Over: AlertSettingModel(
        value: 242.0,
        alertStatus: true,
        circuitStatus: true,
        onValueChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('更新設定數值: ${EnumAlertSetting.voltage220Over.title} = $newValue'),
          );
        },
        onAlertSwitchChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('切換開關: ${EnumAlertSetting.voltage220Over.title} - ${EnumLocale.engoSendAlert.tr} = $newValue'),
          );
        },
        onCircuitSwitchChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('切換開關: ${EnumAlertSetting.voltage220Over.title} - ${EnumLocale.engoCircuitBreakerTrip.tr} = $newValue'),
          );
        },
      ),
      voltage220Under: AlertSettingModel(
        value: 198.0,
        alertStatus: true,
        circuitStatus: false,
        onValueChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('更新設定數值: ${EnumAlertSetting.voltage220Under.title} = $newValue'),
          );
        },
        onAlertSwitchChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('切換開關: ${EnumAlertSetting.voltage220Under.title} - ${EnumLocale.engoSendAlert.tr} = $newValue'),
          );
        },
        onCircuitSwitchChanged: (newValue) async {
          routerHandle(
            EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
            data: SnackBarData('切換開關: ${EnumAlertSetting.voltage220Under.title} - ${EnumLocale.engoCircuitBreakerTrip.tr} = $newValue'),
          );
        },
      ),
      onRemoveDevice: () {
        routerHandle(
          EnumSmartHomeCircuitBreakerPageRoute.showSnackBar,
          data: SnackBarData('移除裝置'),
        );
      },
    );
  }

  List<ChartDataModel> get _getDayChartData {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final random = Random();

    return List.generate(24, (index) {
      final hour = index;
      final date = today.add(Duration(hours: hour));

      double basePower;
      if (hour >= 0 && hour < 6) {
        basePower = 50 + (hour * 5) + random.nextDouble() * 30;
      } else if (hour >= 6 && hour < 9) {
        basePower = 80 + ((hour - 6) * 25) + random.nextDouble() * 40;
      } else if (hour >= 9 && hour < 12) {
        basePower = 150 + ((hour - 9) * 30) + random.nextDouble() * 60;
      } else if (hour >= 12 && hour < 14) {
        basePower = 200 - ((hour - 12) * 10) + random.nextDouble() * 45;
      } else if (hour >= 14 && hour < 18) {
        basePower = 180 + ((hour - 14) * 25) + random.nextDouble() * 50;
      } else if (hour >= 18 && hour < 22) {
        basePower = 250 + ((hour - 18) * 15) + random.nextDouble() * 40;
      } else {
        basePower = 280 - ((hour - 22) * 90) + random.nextDouble() * 30;
      }

      return ChartDataModel(
        date: date,
        number: basePower,
      );
    });
  }

  List<ChartDataModel> get _getMonthChartData {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final random = Random();

    return List.generate(daysInMonth, (index) {
      final day = index + 1;
      final date = DateTime(now.year, now.month, day);

      final isWeekend = date.weekday == 6 || date.weekday == 7;
      final basePower = isWeekend ? 280.0 : 250.0;

      final dayVariation = (index % 7) * 15.0;
      final randomVariation = (random.nextDouble() * 100) - 50.0;

      final power = basePower + dayVariation + randomVariation;

      return ChartDataModel(
        date: date,
        number: power.clamp(180.0, 380.0),
      );
    });
  }

  List<ChartDataModel> get _getYearChartData {
    final now = DateTime.now();
    final random = Random();

    return List.generate(12, (index) {
      final month = index + 1;
      final date = DateTime(now.year - 1, month, 15);

      double basePower;
      if (month >= 6 && month <= 8) {
        basePower = 320 + (month == 7 ? 40 : 20);
      } else if (month >= 12 || month <= 2) {
        basePower = 300 + (month == 1 ? 50 : 30);
      } else if (month >= 3 && month <= 5) {
        basePower = 220 + (month - 3) * 15;
      } else {
        basePower = 240 + (month - 9) * 10;
      }

      final variation = (random.nextDouble() * 80) - 40.0;
      final power = basePower + variation;

      return ChartDataModel(
        date: date,
        number: power.clamp(200.0, 370.0),
      );
    });
  }

  List<RecordModel> get _getSwitchRecordData {
    final random = Random();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final daysOffset = [random.nextInt(3), random.nextInt(3) + 3, random.nextInt(3) + 6];
    final results = <RecordModel>[];

    for (final offset in daysOffset) {
      final date = today.subtract(Duration(days: offset));
      final timeCount = random.nextInt(3) + 2;

      for (int i = 0; i < timeCount; i++) {
        final hours = random.nextInt(24);
        final minutes = random.nextInt(60);
        final isOn = random.nextBool();

        results.add(
          RecordModel(
            date: DateTime(date.year, date.month, date.day, hours, minutes),
            content: isOn ? '已打開' : '已關閉',
          ),
        );
      }
    }

    return results;
  }

  List<RecordModel> get _getAlertRecordData {
    final random = Random();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final daysOffset = [random.nextInt(3), random.nextInt(3) + 3];
    final results = <RecordModel>[];

    for (final offset in daysOffset) {
      final date = today.subtract(Duration(days: offset));
      final hours1 = random.nextInt(12) + 8;
      final minutes1 = random.nextInt(60);
      final hours2 = random.nextInt(8) + 13;
      final minutes2 = random.nextInt(60);
      final hours3 = random.nextInt(6) + 18;
      final minutes3 = random.nextInt(60);

      final alertContents = [
        '110V過壓警報',
        '110V欠壓警報',
        '220V過壓警報',
        '220V欠壓警報',
      ];

      results.addAll([
        RecordModel(
          date: DateTime(date.year, date.month, date.day, hours1, minutes1),
          content: alertContents[random.nextInt(alertContents.length)],
        ),
        RecordModel(
          date: DateTime(date.year, date.month, date.day, hours2, minutes2),
          content: alertContents[random.nextInt(alertContents.length)],
        ),
        RecordModel(
          date: DateTime(date.year, date.month, date.day, hours3, minutes3),
          content: alertContents[random.nextInt(alertContents.length)],
        ),
      ]);
    }

    return results;
  }

  List<RecordModel> get _getNotificationRecordData {
    final random = Random();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final daysOffset = [random.nextInt(3), random.nextInt(3) + 3, random.nextInt(3) + 6];
    final results = <RecordModel>[];

    for (final offset in daysOffset) {
      final date = today.subtract(Duration(days: offset));
      final timeCount = random.nextInt(3) + 2;

      for (int i = 0; i < timeCount; i++) {
        final hours = random.nextInt(24);
        final minutes = random.nextInt(60);

        final notificationContents = [
          '${EnumAlertSetting.highTemperature.title}設定值變更',
          '${EnumAlertSetting.highPower.title}設定值變更',
          '${EnumAlertSetting.overCurrent.title}設定值變更',
          '${EnumAlertSetting.voltage110Over.title}設定值變更',
          '${EnumAlertSetting.voltage110Under.title}設定值變更',
          '${EnumAlertSetting.voltage220Over.title}設定值變更',
          '${EnumAlertSetting.voltage220Under.title}設定值變更',
        ];

        results.add(
          RecordModel(
            date: DateTime(date.year, date.month, date.day, hours, minutes),
            content: notificationContents[random.nextInt(notificationContents.length)],
          ),
        );
      }
    }

    return results;
  }
}
