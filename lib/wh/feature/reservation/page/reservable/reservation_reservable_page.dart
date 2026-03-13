import 'package:engo_terminal_app3/wh/feature/reservation/page/main/reservation_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/reservable/reservation_reservable_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/reservable/ui/gallery_section.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/reservable/ui/info_section.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/reservable/ui/select_section.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/first_background_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationReservablePage extends StatelessWidget {
  final ReservableItemModel routeData;

  const ReservationReservablePage({
    super.key,
    required this.routeData,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReservationReservablePageController>(
      init: ReservationReservablePageController(routeData),
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
                              child: SelectSection(),
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
    final controller = Get.find<ReservationReservablePageController>();
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              controller.interactive(EnumReservationReservablePageInteractive.tapBack);
            },
            child: EnumImage.cArrowLeft.image(
              size: Size.square(58.0.scale),
              color: EnumColor.engoTextPrimary.color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            controller.getReservableItem?.name ?? '',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 40.0.scale,
              fontWeight: FontWeight.w700,
              color: EnumColor.engoTextPrimary.color,
            ),
          ),
        ),
      ],
    );
  }
}
