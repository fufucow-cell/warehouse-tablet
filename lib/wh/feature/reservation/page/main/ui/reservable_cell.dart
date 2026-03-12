import 'package:engo_terminal_app3/wh/feature/reservation/page/main/reservation_main_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/main/reservation_main_page_model.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
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
              Container(
                width: 260.0.scale,
                height: 170.0.scale,
                decoration: BoxDecoration(
                  color: EnumColor.backgroundSecondary.color,
                  borderRadius: BorderRadius.circular(16.0.scale),
                ),
                child: Icon(
                  Icons.image_outlined,
                  size: 48.0.scale,
                  color: EnumColor.iconSecondary.color,
                ),
              ),
              SizedBox(width: 24.0.scale),
              // Right: info
              Expanded(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 30.0.scale,
            fontWeight: FontWeight.w700,
            color: EnumColor.textPrimary.color,
          ),
        ),
        SizedBox(height: 8.0.scale),
        Text(
          location,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 22.0.scale,
            color: EnumColor.textSecondary.color,
          ),
        ),
        SizedBox(height: 4.0.scale),
        Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 22.0.scale,
            color: EnumColor.textSecondary.color,
          ),
        ),
        SizedBox(height: 8.0.scale),
        Text(
          priceLabel,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 22.0.scale,
            color: EnumColor.textSecondary.color,
          ),
        ),
        SizedBox(height: 4.0.scale),
        Text(
          paymentLabel,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 22.0.scale,
            color: paymentColor,
          ),
        ),
      ],
    );
  }
}
