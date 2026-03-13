import 'package:engo_terminal_app3/wh/feature/reservation/page/main/reservation_main_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';
import 'package:engo_terminal_app3/wh/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_network_image.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservableCell extends StatelessWidget {
  final ReservableItemModel item;

  const ReservableCell({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationMainPageController>();
    final imageUrl = item.imageUrls.firstOrNull ?? '';
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => controller.interactive(
          EnumReservationMainPageInteractive.tapReservableItem,
          data: item,
        ),
        borderRadius: BorderRadius.circular(20.0.scale),
        child: Container(
          padding: EdgeInsets.all(24.0.scale),
          decoration: BoxDecoration(
            color: EnumColor.backgroundPrimary.color,
            borderRadius: BorderRadius.circular(20.0.scale),
            border: Border.all(
              width: 1.0.scale,
              color: EnumColor.lineDividerLight.color,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: preview image
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: EnumColor.backgroundSecondary.color,
                    borderRadius: BorderRadius.circular(16.0.scale),
                  ),
                  child: CustNetworkImage(url: imageUrl, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 24.0.scale),
              // Right: info
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) {
                        final priceLabel = switch (item.paymentType) {
                          EnumReservationPaymentType.points => '${item.fee}點/小時',
                          _ => '${item.fee}\$/小時',
                        };
                        final paymentColor = switch (item.paymentType) {
                          EnumReservationPaymentType.free => EnumColor.textSecondary.color,
                          EnumReservationPaymentType.manual => EnumColor.accentYellow.color,
                          EnumReservationPaymentType.points => EnumColor.accentGreen.color,
                          EnumReservationPaymentType.bankTransfer => EnumColor.accentBlue.color,
                          EnumReservationPaymentType.card => EnumColor.accentRed.color,
                        };
                        final locationText = [
                          item.categoryLv1Text,
                          item.categoryLv2Text,
                          item.categoryLv3Text,
                        ].where((e) => e.trim().isNotEmpty).join(' / ');

                        return _InfoBlock(
                          title: item.name,
                          location: locationText,
                          description: item.description,
                          priceLabel: priceLabel,
                          paymentLabel: item.paymentType.localeTitle,
                          paymentColor: paymentColor,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final String title;
  final String location;
  final String description;
  final String priceLabel;
  final String paymentLabel;
  final Color paymentColor;

  const _InfoBlock({
    required this.title,
    required this.location,
    required this.description,
    required this.priceLabel,
    required this.paymentLabel,
    required this.paymentColor,
  });

  @override
  Widget build(BuildContext context) {
    final textSize = 36.0.scale;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustTextWidget(
          title,
          size: textSize,
          weightType: EnumFontWeightType.bold,
          color: EnumColor.textPrimary.color,
        ),
        SizedBox(height: 8.0.scale),
        CustTextWidget(
          location,
          size: textSize * 0.8,
          color: EnumColor.textSecondary.color,
        ),
        SizedBox(height: 4.0.scale),
        CustTextWidget(
          description,
          size: textSize * 0.8,
          color: EnumColor.textSecondary.color,
        ),
        SizedBox(height: 8.0.scale),
        CustTextWidget(
          priceLabel,
          size: textSize * 0.8,
          color: EnumColor.textSecondary.color,
        ),
        SizedBox(height: 4.0.scale),
        CustTextWidget(
          paymentLabel,
          size: textSize * 0.8,
          color: paymentColor,
        ),
      ],
    );
  }
}
