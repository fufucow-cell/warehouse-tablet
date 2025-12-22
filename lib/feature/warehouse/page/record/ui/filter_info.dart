import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class FilterInfo extends StatelessWidget {
  const FilterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _FilterDropdown(),
        SizedBox(width: 24.0.scale),
        _RefreshButton(),
      ],
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseRecordPageController>();
    final btnWidth = 280.0.scale;
    final btnHeight = 78.0.scale;

    return Obx(
      () => PopupMenuButton<EnumFilterType?>(
        offset: Offset(0, btnHeight + 10.0.scale),
        constraints: BoxConstraints(
          minWidth: btnWidth,
          maxWidth: btnWidth,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0.scale,
            color: EnumColor.lineProduct.color,
          ),
          borderRadius: BorderRadius.circular(16.0.scale),
        ),
        color: EnumColor.backgroundPrimary.color,
        padding: EdgeInsets.all(16.0.scale),
        onOpened: () {
          controller.interactive(EnumWarehouseRecordPageInteractive.tapFilterButton);
        },
        onSelected: (value) {
          if (value != null) {
            controller.interactive(EnumWarehouseRecordPageInteractive.tapFilterButton, data: value);
          }
        },
        itemBuilder: (context) => EnumFilterType.values.map((type) {
          final isSelected = controller.filterTypeRx.value == type;
          return PopupMenuItem<EnumFilterType?>(
            value: type,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isSelected ? EnumColor.menuBgFocused.color : Colors.transparent,
                borderRadius: BorderRadius.circular(12.0.scale),
              ),
              padding: EdgeInsets.all(16.0.scale),
              child: WidgetUtil.textWidget(
                type.title,
                size: 32.0.scale,
                color: isSelected ? EnumColor.textPrimary.color : EnumColor.textSecondary.color,
              ),
            ),
          );
        }).toList(),
        child: Container(
          width: btnWidth,
          height: btnHeight,
          padding: EdgeInsets.symmetric(horizontal: 32.0.scale, vertical: 16.0.scale),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: EnumColor.backgroundPrimary.color,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.0.scale,
                color: controller.isShowFilterMenuRx.value ? EnumColor.lineProduct.color : EnumColor.lineBorder.color,
              ),
              borderRadius: BorderRadius.circular(16.0.scale),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: WidgetUtil.textWidget(
                  controller.filterTypeRx.value.title,
                  size: 32.0.scale,
                  color: EnumColor.textPrimary.color,
                ),
              ),
              SizedBox(width: 16.0.scale),
              EnumImage.cArrowDown.image(
                size: Size.square(38.0.scale),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RefreshButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0.scale,
        vertical: 11.0.scale,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: EnumColor.backgroundPrimary.color,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0.scale,
            color: EnumColor.accentBlue.color,
          ),
          borderRadius: BorderRadius.circular(16.0.scale),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EnumImage.cRefresh.image(
            size: Size.square(48.0.scale),
          ),
          SizedBox(width: 10.0.scale),
          WidgetUtil.textWidget(
            '刷新',
            size: 32.0.scale,
            color: EnumColor.accentBlue.color,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
