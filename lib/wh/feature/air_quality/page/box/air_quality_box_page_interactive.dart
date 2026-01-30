part of 'air_quality_box_page_controller.dart';

enum EnumAirQualityBoxPageInteractive {
  tapBackButton,
  tapEditButton,
  tapSettingButton,
  tapDataRecordButton,
}

extension AirQualityBoxPageInteractiveExtension on AirQualityBoxPageController {
  void interactive(EnumAirQualityBoxPageInteractive type, {dynamic data}) {
    final routerData = _model.routerData;
    if (routerData == null) {
      return;
    }

    switch (type) {
      case EnumAirQualityBoxPageInteractive.tapBackButton:
        routerData.onBackButtonTap();
      case EnumAirQualityBoxPageInteractive.tapEditButton:
        routerData.onEditButtonTap(_model.title.value).then((newName) {
          if (newName != null) {
            _model.title.value = newName;
            update();
          }
        });
      case EnumAirQualityBoxPageInteractive.tapSettingButton:
        routerData.onSettingButtonTap();
      case EnumAirQualityBoxPageInteractive.tapDataRecordButton:
        routerData.onDataRecordItemTap().then((recordRouterData) {
          _routerHandle(
            EnumAirQualityBoxPageRoute.goToRecordPage,
            data: recordRouterData,
          );
        });
    }
  }
}
