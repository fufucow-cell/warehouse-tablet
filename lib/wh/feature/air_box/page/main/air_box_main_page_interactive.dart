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
        routerData.onBackButtonTap?.call();
      case EnumAirBoxMainPageInteractive.tapEditButton:
        routerData.onEditButtonTap?.call(_model.title.value).then((newName) {
          if (newName != null) {
            _model.title.value = newName;
            update();
          }
        });
      case EnumAirBoxMainPageInteractive.tapSettingButton:
        routerData.onSettingButtonTap?.call();
      case EnumAirBoxMainPageInteractive.tapDataRecordButton:
        routerData.onDataRecordItemTap?.call().then((recordRouterData) {
          _routerHandle(
            EnumAirBoxMainPageRoute.goToRecordPage,
            data: recordRouterData,
          );
        });
    }
  }
}
