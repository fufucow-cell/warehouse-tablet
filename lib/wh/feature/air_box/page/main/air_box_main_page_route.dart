part of 'air_box_main_page_controller.dart';

enum EnumAirBoxMainPageRoute {
  goToRecordPage,
}

extension AirBoxMainPageRouteExtension on AirBoxMainPageController {
  void _routerHandle(EnumAirBoxMainPageRoute type, {dynamic data}) {
    print('_routerHandle called: type=$type, data=$data');
    final context = _model.nestedNavigatorContext;

    if (context == null) {
      print('Error: nestedNavigatorContext is null');
      return;
    }

    switch (type) {
      case EnumAirBoxMainPageRoute.goToRecordPage:
        print('Navigating to record page');
        if (data is AirBoxRecordPageRouterData) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AirBoxRecordPage(routerData: data),
            ),
          );
        } else {
          print('Error: data is not AirBoxRecordPageRouterData, type: ${data.runtimeType}');
        }
    }
  }
}
