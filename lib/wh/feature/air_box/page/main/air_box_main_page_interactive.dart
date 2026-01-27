part of 'air_box_main_page_controller.dart';

enum EnumAirBoxMainPageInteractive {
  tapBackButton,
  tapEditButton,
  tapSettingButton,
  tapDataRecordButton,
}

extension AirBoxMainPageInteractiveExtension on AirBoxMainPageController {
  void interactive(EnumAirBoxMainPageInteractive type, {dynamic data}) {
    final routerData = _model.routerData;
    if (routerData == null) {
      return;
    }

    switch (type) {
      case EnumAirBoxMainPageInteractive.tapBackButton:
        routerData.onBackButtonTap();
      case EnumAirBoxMainPageInteractive.tapEditButton:
        routerData.onEditButtonTap(_model.title.value).then((newName) {
          if (newName != null) {
            _model.title.value = newName;
            update();
          }
        });
      case EnumAirBoxMainPageInteractive.tapSettingButton:
        routerData.onSettingButtonTap();
      case EnumAirBoxMainPageInteractive.tapDataRecordButton:
        routerData.onDataRecordItemTap().then((recordRouterData) {
          _routerHandle(
            EnumAirBoxMainPageRoute.goToRecordPage,
            data: recordRouterData,
          );
        });
    }
  }
}
