import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
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

    return Obx(
      () => WidgetUtil.textDropdownButton(
        width: 280.0.scale,
        height: 70.0.scale,
        selectedValue: controller.filterTypeRx.value.title,
        values: controller.getFilterNames,
        onValueSelected: (str) {
          if (str?.isNotEmpty ?? false) {
            controller.interactive(
              EnumWarehouseRecordPageInteractive.tapFilterButton,
              data: EnumFilterType.fromString(str),
            );
          }
        },
        onMenuOpened: () {
          controller.interactive(EnumWarehouseRecordPageInteractive.tapFilterButton);
        },
      ),
    );
  }
}

class _RefreshButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseRecordPageController>();
    return Material(
      color: EnumColor.backgroundDropdown.color,
      borderRadius: BorderRadius.circular(16.0.scale),
      child: InkWell(
        onTap: () {
          controller.interactive(EnumWarehouseRecordPageInteractive.tapRefreshButton);
        },
        borderRadius: BorderRadius.circular(16.0.scale),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0.scale,
            vertical: 11.0.scale,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
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
                color: EnumColor.accentBlue.color,
              ),
              SizedBox(width: 10.0.scale),
              WidgetUtil.textWidget(
                EnumLocale.warehouseRefresh.tr,
                size: 32.0.scale,
                color: EnumColor.accentBlue.color,
                align: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
