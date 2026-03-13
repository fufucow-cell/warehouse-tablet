import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/reservation_detail_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/reservation_detail_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/ui/form_fill_section.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/ui/gallery_section.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/ui/info_section.dart';
import 'package:engo_terminal_app3/wh/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/parent/ui/first_background_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationDetailPage extends GetView<ReservationDetailPageController> {
  final ReservationDetailRouteData routeData;

  const ReservationDetailPage({super.key, required this.routeData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReservationDetailPageController>(
      init: ReservationDetailPageController(routeData),
      builder: (controller) {
        return Scaffold(
          body: FirstBackgroundCard(
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  _TopBar(),
                  _spaceH,
                  Expanded(
                    child: Column(
                      children: [
                        const Expanded(
                          child: GallerySection(),
                        ),
                        _spaceH,
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                flex: 2,
                                child: InfoSection(),
                              ),
                              SizedBox(width: 18.0.scale),
                              const Expanded(
                                flex: 1,
                                child: FormFillSection(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget get _spaceH => SizedBox(height: 12.0.scale);
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationDetailPageController>();
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              controller.interactive(EnumReservationDetailPageInteractive.tapBack);
            },
            child: EnumImage.cArrowLeft.image(
              size: Size.square(58.0.scale),
              color: EnumColor.engoTextPrimary.color,
            ),
          ),
        ),
        Expanded(
          child: CustTextWidget(
            controller.getAppBarTitle,
            size: 40.0.scale,
            weightType: EnumFontWeightType.bold,
            align: TextAlign.center,
            color: EnumColor.textPrimary.color,
          ),
        ),
        SizedBox(width: 58.0.scale),
      ],
    );
  }
}
