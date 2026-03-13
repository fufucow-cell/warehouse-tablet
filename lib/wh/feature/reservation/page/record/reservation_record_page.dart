import 'package:engo_terminal_app3/wh/feature/reservation/page/record/reservation_record_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/record/reservation_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/record/ui/gallery_section.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/record/ui/info_section.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/record/ui/tab_content_section.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';
import 'package:engo_terminal_app3/wh/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_tab_bar.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/parent/ui/first_background_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationRecordPage extends StatelessWidget {
  final RecordItemModel routeData;

  const ReservationRecordPage({
    super.key,
    required this.routeData,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReservationRecordPageController>(
      init: ReservationRecordPageController(routeData),
      builder: (controller) {
        return Scaffold(
          body: FirstBackgroundCard(
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopBar(),
                  SizedBox(height: 40.0.scale),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.scale),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(
                                  child: InfoSection(),
                                ),
                                spaceW,
                                const Expanded(
                                  child: GallerySection(),
                                ),
                              ],
                            ),
                          ),
                          spaceH,
                          Obx(
                            () {
                              return CustTabBar(
                                titles: EnumRecordTabIndex.values.map((e) => e.title).toList(),
                                selectedIndex: controller.selectedTabIndexRx.value,
                                onChanged: (index) {
                                  controller.interactive(EnumReservationRecordPageInteractive.switchTabItem, data: index);
                                },
                              );
                            },
                          ),
                          const Expanded(child: TabContentSection()),
                          spaceH,
                          _BottomButtons(),
                          spaceH,
                        ],
                      ),
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

  Widget get spaceH => SizedBox(height: 12.0.scale);
  Widget get spaceW => SizedBox(width: 12.0.scale);
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationRecordPageController>();
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              controller.interactive(EnumReservationRecordPageInteractive.tapBack);
            },
            child: EnumImage.cArrowLeft.image(
              size: Size.square(58.0.scale),
              color: EnumColor.engoTextPrimary.color,
            ),
          ),
        ),
        Expanded(
          child: CustTextWidget(
            '預約紀錄',
            size: 40.0.scale,
            weightType: EnumFontWeightType.bold,
            align: TextAlign.center,
            color: EnumColor.engoTextPrimary.color,
          ),
        ),
      ],
    );
  }
}

class _BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationRecordPageController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 120.0.scale,
          height: 44.0.scale,
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: EnumColor.accentBlue.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0.scale),
              ),
            ),
            child: CustTextWidget(
              '取消',
              size: 18.0.scale,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 40.0.scale),
        SizedBox(
          width: 120.0.scale,
          height: 44.0.scale,
          child: ElevatedButton(
            onPressed: () {
              controller.interactive(EnumReservationRecordPageInteractive.tapConfirm);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: EnumColor.accentBlue.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0.scale),
              ),
            ),
            child: CustTextWidget(
              '確定',
              size: 18.0.scale,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
