import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class TopTool extends StatelessWidget {
  const TopTool({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseMainPageController>();

    return Obx(
      () {
        if (controller.isLoadingRx.value) {
          return const _ShimmerWidget();
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _button(EnumImage.cAdd, () {
              controller.interactive(EnumWarehouseMainPageInteractive.tapCreate);
            }),
            SizedBox(width: 32.0.scale),
            _button(EnumImage.cSearch, () {
              controller.interactive(EnumWarehouseMainPageInteractive.tapSearch);
            }),
          ],
        );
      },
    );
  }

  Widget _button(EnumImage eImg, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0.scale),
        child: eImg.image(
          size: Size.square(48.0.scale),
          color: EnumColor.iconSecondary.color,
        ),
      ),
    );
  }
}

class _ShimmerWidget extends StatelessWidget {
  const _ShimmerWidget();

  @override
  Widget build(BuildContext context) {
    return WidgetUtil.shimmerWidget(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buttonWidget,
          SizedBox(width: 32.0.scale),
          _buttonWidget,
        ],
      ),
    );
  }

  Widget get _buttonWidget {
    return Container(
      width: 48.0.scale,
      height: 48.0.scale,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0.scale),
        color: Colors.white,
      ),
    );
  }
}
