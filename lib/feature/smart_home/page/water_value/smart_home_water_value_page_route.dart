part of 'smart_home_water_value_page_controller.dart';

enum EnumSmartHomeWaterValuePageRoute {
  showSnackBar,
  goToTimerSettingPage,
  goToTimerListPage,
}

extension SmartHomeWaterValuePageRouteExtension on SmartHomeWaterValuePageController {
  void routerHandle(
    EnumSmartHomeWaterValuePageRoute type, {
    dynamic data,
  }) {
    final context = _model.context ?? Get.context!;

    switch (type) {
      case EnumSmartHomeWaterValuePageRoute.showSnackBar:
        final snackBarData = data as SnackBarData;
        CustSnackBar.show(
          title: snackBarData.title ?? '',
          message: snackBarData.message,
        );
      case EnumSmartHomeWaterValuePageRoute.goToTimerSettingPage:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WaterValueTimerSettingPage(
              routerData: WaterValueTimerSettingPageRouterData(
                language: _service.getCurrentLocaleCode,
                theme: _service.getCurrentThemeName,
                isModuleMode: false,
                initialOpenTime: null,
                initialCloseTime: null,
                initialRepeatEnabled: false,
                initialNotificationEnabled: false,
                initialSelectedWeekday: 0,
                initialSelectedTab: 0,
                initialSelectedDays: null,
                onSave: (openTime, closeTime, repeatEnabled, weekday, tab, selectedDays) async {
                  routerHandle(
                    EnumSmartHomeWaterValuePageRoute.showSnackBar,
                    data: SnackBarData('儲存定時設定'),
                  );
                },
                onBackButtonTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        );
      case EnumSmartHomeWaterValuePageRoute.goToTimerListPage:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WaterValueTimerListPage(
              routerData: WaterValueTimerListPageRouterData(
                language: _service.getCurrentLocaleCode,
                theme: _service.getCurrentThemeName,
                isModuleMode: false,
                initialTimerItems: const [],
                onBackButtonTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        );
    }
  }
}
