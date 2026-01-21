import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/alert_setting/circuit_breaker_alert_setting_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/service/circuit_breaker_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'circuit_breaker_alert_setting_page_interactive.dart';
part 'circuit_breaker_alert_setting_page_route.dart';

class CircuitBreakerAlertSettingPageController extends GetxController {
  // MARK: - Properties

  final _model = CircuitBreakerAlertSettingPageModel();
  final _service = CircuitBreakerService.instance;

  // MARK: - Init

  CircuitBreakerAlertSettingPageController(CircuitBreakerAlertSettingPageRouterData routerData) {
    _model.routerData = routerData;
    _setupValueControllers();
  }

  void _setupValueControllers() {
    // 监听器逻辑已移到 unfocus 事件处理
  }

  void onValueFieldUnfocus(AlertSettingModel setting) {
    final textValue = setting.valueController.text;
    final numValue = double.tryParse(textValue);

    if (numValue != null && numValue != setting.value) {
      setting.value = numValue;
      setting.onValueChanged(numValue);
    } else if (textValue.isEmpty || numValue == null) {
      // 如果输入无效，恢复原来的值
      setting.valueController.text = setting.value.toString();
    }
  }

  @override
  void onClose() {
    for (final setting in getAllSettings) {
      setting.setting.valueController.dispose();
    }

    super.onClose();
  }

  // MARK: - Public Method

  List<DataModel> get getAllSettings {
    final routerData = _model.routerData;

    if (routerData == null) {
      return [];
    }

    return [
      DataModel(type: EnumAlertSetting.highTemperature, setting: routerData.highTemperature),
      DataModel(type: EnumAlertSetting.highPower, setting: routerData.highPower),
      DataModel(type: EnumAlertSetting.overCurrent, setting: routerData.overCurrent),
      DataModel(type: EnumAlertSetting.voltage110Over, setting: routerData.voltage110Over),
      DataModel(type: EnumAlertSetting.voltage110Under, setting: routerData.voltage110Under),
      DataModel(type: EnumAlertSetting.voltage220Over, setting: routerData.voltage220Over),
      DataModel(type: EnumAlertSetting.voltage220Under, setting: routerData.voltage220Under),
    ];
  }
}
