import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/notification_record/circuit_breaker_notification_record_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/notification_record/circuit_breaker_notification_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/children/ui/icon_button.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_empty_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_shimmer_widget.dart' show ShimmerWidget;
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/first_background_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircuitBreakerNotificationRecordPage extends GetView<CircuitBreakerNotificationRecordPageController> {
  final CircuitBreakerNotificationRecordPageRouterData routerData;
  const CircuitBreakerNotificationRecordPage({super.key, required this.routerData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CircuitBreakerNotificationRecordPageController>(
      init: CircuitBreakerNotificationRecordPageController(routerData),
      builder: (controller) {
        return Scaffold(
          body: FirstBackgroundCard(
            child: Column(
              children: [
                _TopBar(),
                SizedBox(height: 48.0.scale),
                _TabBar(),
                SizedBox(height: 48.0.scale),
                Expanded(
                  child: _TabBarView(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustIconButton(
          icon: EnumImage.cArrowLeft,
          size: 80.0.scale,
          color: EnumColor.engoBackgroundOrange400.color,
          onTap: () {
            final controller = Get.find<CircuitBreakerNotificationRecordPageController>();
            controller.routerHandle(EnumCircuitBreakerNotificationRecordPageRoute.goBack);
          },
        ),
        Expanded(
          child: Center(
            child: CustTextWidget(
              EnumLocale.engoNotificationRecord.tr,
              size: 40.0.scale,
              weightType: EnumFontWeightType.bold,
              color: EnumColor.textPrimary.color,
            ),
          ),
        ),
        SizedBox(width: 80.0.scale),
      ],
    );
  }
}

class _TabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CircuitBreakerNotificationRecordPageController>();
    return Obx(
      () {
        final selectedTab = controller.selectedTabRx.value;
        const tabTypes = EnumRecordType.values;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1.0.scale,
              color: EnumColor.engoButtonBorderReverse.color,
            ),
            borderRadius: BorderRadius.circular(8.0.scale),
          ),
          child: Row(
            children: [
              for (int i = 0; i < tabTypes.length; i++) ...[
                Expanded(
                  child: _TabItem(
                    type: tabTypes[i],
                    isSelected: selectedTab == tabTypes[i],
                    onTap: () {
                      controller.interactive(
                        EnumCircuitBreakerNotificationRecordPageInteractive.tapTab,
                        data: tabTypes[i],
                      );
                    },
                  ),
                ),
                if (i < tabTypes.length - 1) SizedBox(width: 48.0.scale),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _TabItem extends StatelessWidget {
  final EnumRecordType type;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.0.scale),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? EnumColor.engoBackgroundOrange400.color : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0.scale),
        ),
        child: CustTextWidget(
          type.title,
          size: 32.0.scale,
          weightType: EnumFontWeightType.regular,
          color: isSelected ? EnumColor.textWhite.color : EnumColor.engoTextSecondary.color,
        ),
      ),
    );
  }
}

class _TabBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CircuitBreakerNotificationRecordPageController>();
    return Obx(
      () {
        final groupedRecords = controller.currentRecordsRx.value;

        if (groupedRecords == null) {
          return ShimmerWidget(
            width: double.infinity,
            height: 400.0.scale,
          );
        }

        if (groupedRecords.isEmpty) {
          return const CustEmptyWidget();
        }

        final sortedDates = groupedRecords.keys.toList();

        return ListView.builder(
          itemCount: sortedDates.length,
          itemBuilder: (context, index) {
            final dateKey = sortedDates[index];
            final dayRecords = groupedRecords[dateKey]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index > 0)
                  Container(
                    margin: EdgeInsets.only(bottom: 32.0.scale),
                    height: 1.0.scale,
                    color: EnumColor.textSecondary.color,
                  ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 32.0.scale,
                    bottom: 16.0.scale,
                    top: index == 0 ? 0 : 0,
                  ),
                  child: CustTextWidget(
                    dateKey,
                    size: 32.0.scale,
                    weightType: EnumFontWeightType.bold,
                    color: EnumColor.engoTextPrimary.color,
                  ),
                ),
                ...dayRecords.map((record) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.0.scale,
                      vertical: 8.0.scale,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 170.0.scale,
                          child: CustTextWidget(
                            controller.convertTime(record.date),
                            size: 32.0.scale,
                            weightType: EnumFontWeightType.regular,
                            color: EnumColor.engoTextPrimary.color,
                          ),
                        ),
                        SizedBox(width: 64.0.scale),
                        Expanded(
                          child: CustTextWidget(
                            record.content,
                            size: 32.0.scale,
                            weightType: EnumFontWeightType.regular,
                            color: EnumColor.engoTextPrimary.color,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: 12.0.scale),
              ],
            );
          },
        );
      },
    );
  }
}
