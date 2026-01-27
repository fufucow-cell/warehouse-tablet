part of 'air_box_reference_page_controller.dart';

enum EnumAirBoxReferencePageRoute {
  goBack,
}

extension AirBoxReferencePageRouteExtension on AirBoxReferencePageController {
  void routerHandle(EnumAirBoxReferencePageRoute type, {dynamic data}) {
    switch (type) {
      case EnumAirBoxReferencePageRoute.goBack:
        final context = _model.nestedNavigatorContext;
        if (context != null && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        } else {
          _model.routerData?.onBackButtonTap?.call();
        }
    }
  }
}
