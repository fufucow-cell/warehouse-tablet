import 'package:engo_terminal_app3/wh/feature/air_box/page/main/air_box_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/page/record/air_box_record_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/page/record/air_box_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'air_box_main_page_interactive.dart';
part 'air_box_main_page_route.dart';

class AirBoxMainPageController extends GetxController {
  // MARK: - Properties

  final _model = AirBoxMainPageModel();
  RxReadonly<String> get titleRx => _model.title.readonly;
  RxReadonly<String> get pm25Rx => _model.pm25.readonly;
  RxReadonly<String> get pm25StatusRx => _model.pm25Status.readonly;
  RxReadonly<String> get temperatureRx => _model.temperature.readonly;
  RxReadonly<String> get humidityRx => _model.humidity.readonly;
  RxReadonly<String> get formaldehydeRx => _model.formaldehyde.readonly;
  RxReadonly<String> get vocRx => _model.voc.readonly;
  RxReadonly<String> get co2Rx => _model.co2.readonly;

  // MARK: - Init

  AirBoxMainPageController(AirBoxMainPageRouterData routerData) {
    _model.routerData = routerData;
    _initData();
  }

  void _initData() {
    final routerData = _model.routerData;
    if (routerData == null) return;

    _model.title.value = routerData.deviceName;
    _model.pm25.value = routerData.pm25 ?? '';
    _model.pm25Status.value = routerData.pm25Status ?? '';
    _model.temperature.value = routerData.temperature ?? '';
    _model.humidity.value = routerData.humidity ?? '';
    _model.formaldehyde.value = routerData.formaldehyde ?? '';
    _model.voc.value = routerData.voc ?? '';
    _model.co2.value = routerData.co2 ?? '';
  }

  // MARK: - Public Method

  void setContext(BuildContext context) {
    _model.nestedNavigatorContext = context;
  }

  void updateData(AirBoxDataModel data) {
    if (data.pm25 != null) {
      _model.pm25.value = data.pm25!;
    }
    if (data.pm25Status != null) {
      _model.pm25Status.value = data.pm25Status!;
    }
    if (data.temperature != null) {
      _model.temperature.value = data.temperature!;
    }
    if (data.humidity != null) {
      _model.humidity.value = data.humidity!;
    }
    if (data.formaldehyde != null) {
      _model.formaldehyde.value = data.formaldehyde!;
    }
    if (data.voc != null) {
      _model.voc.value = data.voc!;
    }
    if (data.co2 != null) {
      _model.co2.value = data.co2!;
    }
    update();
  }
}
