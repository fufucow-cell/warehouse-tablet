import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/reservation_detail_page_controller.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_empty_image.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationDetailPageController>();
    final urls = controller.getReservableItem?.imageUrls ?? [];

    if (urls.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16.0.scale),
        child: CustEmptyImage(
          width: 1020.0.scale,
          color: Colors.grey[300],
        ),
      );
    }

    final safe = urls.take(4).toList();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          controller.interactive(EnumReservationDetailPageInteractive.tapImage,
              data: urls);
        },
        borderRadius: BorderRadius.circular(12.0.scale),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0.scale),
          child: Container(
            padding: EdgeInsets.all(12.0.scale),
            color: EnumColor.backgroundSecondary.color,
            child: switch (safe.length) {
              1 => Center(
                  child: _Thumb(
                    url: safe[0],
                  ),
                ),
              2 => Row(
                  children: [
                    Expanded(
                      child: _Thumb(
                        url: safe[0],
                        // width: double.infinity,
                        // height: 220.0.scale,
                      ),
                    ),
                    _spaceW,
                    Expanded(
                      child: _Thumb(
                        url: safe[1],
                      ),
                    ),
                  ],
                ),
              _ => Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _Thumb(
                        url: safe[0],
                      ),
                    ),
                    _spaceW,
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Expanded(
                            child: _Thumb(
                              url: safe[1],
                            ),
                          ),
                          _spaceH,
                          Expanded(
                            child: _Thumb(
                              url: safe[2],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            },
          ),
        ),
      ),
    );
  }

  Widget get _spaceH => SizedBox(height: 12.0.scale);
  Widget get _spaceW => SizedBox(width: 12.0.scale);
}

class _Thumb extends StatelessWidget {
  final String url;

  const _Thumb({
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0.scale),
      child: CustNetworkImage(
        url: url,
        // fit: BoxFit.cover,
      ),
    );
  }
}
