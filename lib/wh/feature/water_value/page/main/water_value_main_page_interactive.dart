part of 'water_value_main_page_controller.dart';

enum EnumWaterValueMainPageInteractive {
  tapBackButton,
  tapEditButton,
  tapSettingButton,
  tapSwitchToggle,
  tapTimerButton,
}

extension WaterValueMainPageUserEventExtension on WaterValueMainPageController {
  Future<void> interactive(
    EnumWaterValueMainPageInteractive type, {
    dynamic data,
  }) async {
    switch (type) {
      case EnumWaterValueMainPageInteractive.tapBackButton:
        _model.routerData?.onBackButtonTap?.call();
      case EnumWaterValueMainPageInteractive.tapEditButton:
        final newName = await _model.routerData?.onEditButtonTap?.call(_model.title.value);

        if (newName?.isNotEmpty ?? false) {
          _model.title.value = newName!;
        }
      case EnumWaterValueMainPageInteractive.tapSettingButton:
        _model.routerData?.onSettingButtonTap?.call();
      case EnumWaterValueMainPageInteractive.tapSwitchToggle:
        if (data is bool && data != _model.isSwitchOn.value) {
          _model.isSwitchOn.value = data;
          _model.routerData?.onSwitchToggle?.call(data);
        }
      case EnumWaterValueMainPageInteractive.tapTimerButton:
        await _routerHandle(EnumWaterValueMainPageRoute.goToTimerListPage);
    }
  }
}
