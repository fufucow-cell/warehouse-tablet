import 'package:engo_terminal_app3/wh/feature/air_quality/page/filter/air_quality_filter_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/service/air_quality_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'air_quality_filter_page_interactive.dart';
part 'air_quality_filter_page_route.dart';

class AirQualityFilterPageController extends GetxController {
  // MARK: - Properties

  final _model = AirQualityFilterPageModel();
  AirQualityService get _service => AirQualityService.instance;
  BuildContext? get getRootNavigatorContext => _service.getNestedNavigatorContext;
  TextEditingController get filterLifeDaysController => _model.filterLifeDaysController;
  bool get isEditing => _model.isEditing.value;
  int get filterLifeDays => _model.filterLifeDays;
  int get filterLifePercent => _model.routerData?.lifePercent ?? 0;

  // MARK: - Init

  AirQualityFilterPageController(AirQualityFilterPageRouterData routerData) {
    _model.routerData = routerData;
    _model.initFromRouterData();
  }

  @override
  void onClose() {
    _model.dispose();
    super.onClose();
  }

  // MARK: - Methods

  void interactive(EnumAirQualityFilterPageInteractive type, {dynamic data}) {
    _interactive(type, data: data);
  }
}
