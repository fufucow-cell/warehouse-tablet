part of 'water_value_timer_list_page_controller.dart';

enum EnumWaterValueTimerListPageRoute {
  goBack,
  goToTimerSettingPage,
}

extension WaterValueTimerListPageRouteExtension on WaterValueTimerListPageController {
  Future<void> _routerHandle(
    EnumWaterValueTimerListPageRoute type, {
    dynamic data,
  }) async {
    final context = _service.getNestedNavigatorContext;

    if (context == null) {
      return;
    }

    switch (type) {
      case EnumWaterValueTimerListPageRoute.goBack:
        Navigator.of(context).pop();
      case EnumWaterValueTimerListPageRoute.goToTimerSettingPage:
        if (data is WaterValueTimerInfo) {
          final info = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WaterValueTimerSettingPage(info: data),
            ),
          );

          if (info is WaterValueTimerInfo) {
            final newInfo = await _model.routerData?.itemUpdate.call(info);

            if (newInfo != null) {
              final currentList = List<WaterValueTimerInfo>.from(_model.timerItems.value);
              currentList.add(newInfo);
              _model.timerItems.value = currentList;
            }
          }
        }
    }
  }
}
