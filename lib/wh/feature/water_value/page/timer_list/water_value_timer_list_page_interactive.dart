part of 'water_value_timer_list_page_controller.dart';

enum EnumWaterValueTimerListPageInteractive {
  tapBackButton,
  tapSettingButton,
  tapAddTimerButton,
  tapDeleteButton,
  tapToggleSwitch,
  tapCell,
}

extension WaterValueTimerListPageInteractiveExtension on WaterValueTimerListPageController {
  Future<void> interactive(
    EnumWaterValueTimerListPageInteractive type, {
    dynamic data,
  }) async {
    switch (type) {
      case EnumWaterValueTimerListPageInteractive.tapBackButton:
        unawaited(_routerHandle(EnumWaterValueTimerListPageRoute.goBack));
      case EnumWaterValueTimerListPageInteractive.tapSettingButton:
        _model.isEditMode.value = !_model.isEditMode.value;
      case EnumWaterValueTimerListPageInteractive.tapAddTimerButton:
        unawaited(
          _routerHandle(
            EnumWaterValueTimerListPageRoute.goToTimerSettingPage,
            data: WaterValueTimerInfo(),
          ),
        );
      case EnumWaterValueTimerListPageInteractive.tapDeleteButton:
        if (data is WaterValueTimerInfo) {
          final isSuccess = await _model.routerData?.itemDelete.call(data) ?? false;

          if (isSuccess) {
            final currentList = List<WaterValueTimerInfo>.from(_model.timerItems.value);
            currentList.removeWhere((e) => e.id == data.id);
            _model.timerItems.value = currentList;
          }
        }
      case EnumWaterValueTimerListPageInteractive.tapToggleSwitch:
        if (data is WaterValueTimerInfo) {
          final currentList = _model.timerItems.value;
          final index = currentList.indexWhere((e) => e.id == data.id);
          if (index != -1) {
            data.isEnable = !(data.isEnable ?? false);
            final updatedList = List<WaterValueTimerInfo>.from(currentList);
            updatedList[index] = data;
            _model.timerItems.value = updatedList;
            unawaited(_model.routerData?.itemUpdate.call(data));
          }
        }
      case EnumWaterValueTimerListPageInteractive.tapCell:
        unawaited(_routerHandle(EnumWaterValueTimerListPageRoute.goToTimerSettingPage, data: data));
    }
  }
}
