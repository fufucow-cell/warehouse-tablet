import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_info/dialog_item_info_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/second_background_card.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'warehouse_alarm_page_controller.dart';
part 'warehouse_alarm_page_interactive.dart';
part 'warehouse_alarm_page_model.dart';
part 'warehouse_alarm_page_route.dart';

class WarehouseAlarmPage extends GetView<WarehouseAlarmPageController> {
  const WarehouseAlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<WarehouseAlarmPageController>()) {
      Get.put(WarehouseAlarmPageController(), permanent: false);
    }

    return const SecondBackgroundCard(
      child: Column(
        children: [
          _HeaderWidget(),
          Expanded(
            child: _AlarmList(),
          ),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseAlarmPageController>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0.scale,
            vertical: 23.0.scale,
          ),
          decoration: ShapeDecoration(
            color: EnumColor.backgroundSecondary.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0.scale),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: controller.columnRatio[0],
                child: SizedBox(
                  child: WidgetUtil.textWidget(
                    EnumLocale.warehouseAlarmProductPhoto.tr,
                    size: 28.0.scale,
                    color: EnumColor.textSecondary.color,
                  ),
                ),
              ),
              SizedBox(width: 44.0.scale),
              Expanded(
                flex: controller.columnRatio[1],
                child: SizedBox(
                  child: WidgetUtil.textWidget(
                    EnumLocale.warehouseAlarmProductName.tr,
                    size: 28.0.scale,
                    color: EnumColor.textSecondary.color,
                  ),
                ),
              ),
              SizedBox(width: 44.0.scale),
              Expanded(
                flex: controller.columnRatio[2],
                child: SizedBox(
                  child: WidgetUtil.textWidget(
                    EnumLocale.warehouseAlarmBelowStockLevel.tr,
                    size: 28.0.scale,
                    color: EnumColor.textSecondary.color,
                  ),
                ),
              ),
              SizedBox(width: 44.0.scale),
              Expanded(
                flex: controller.columnRatio[3],
                child: SizedBox(
                  child: WidgetUtil.textWidget(
                    EnumLocale.warehouseAlarmOperation.tr,
                    size: 28.0.scale,
                    color: EnumColor.textSecondary.color,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AlarmList extends StatelessWidget {
  const _AlarmList();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseAlarmPageController>();
    final items = controller.allAlarmItemsRx;
    return SingleChildScrollView(
      child: Column(
        children: items
            .expand(
              (item) => [
                _CellWidget(item: item),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: EnumColor.lineDividerLight.color,
                ),
              ],
            )
            .toList()
          ..removeLast(), // 移除最后一个 divider
      ),
    );
  }
}

class _CellWidget extends StatelessWidget {
  final Item item;

  const _CellWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseAlarmPageController>(
      builder: (controller) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0.scale),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: controller.columnRatio[0],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.0.scale),
                  child: Container(
                    width: 114.0.scale,
                    height: 80.0.scale,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0.scale),
                      color: Colors.grey[300],
                    ),
                    child: Image.network(
                      item.photo.toString(),
                      width: 114.0.scale,
                      height: 80.0.scale,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => WidgetUtil.emptyImage(
                        width: 114.0.scale,
                        height: 80.0.scale,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 44.0.scale),
              Expanded(
                flex: controller.columnRatio[1],
                child: WidgetUtil.textWidget(
                  item.name ?? '-',
                  size: 28.0.scale,
                  color: EnumColor.textPrimary.color,
                ),
              ),
              SizedBox(width: 44.0.scale),
              Flexible(
                flex: controller.columnRatio[2],
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 42.0.scale,
                      vertical: 12.0.scale,
                    ),
                    decoration: ShapeDecoration(
                      color: EnumColor.backgroundAccentRed.color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0.scale),
                      ),
                    ),
                    child: WidgetUtil.textWidget(
                      '${controller.getStockDifference(item)}',
                      size: 28.0.scale,
                      color: EnumColor.accentRed.color,
                      weightType: EnumFontWeightType.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 44.0.scale),
              Flexible(
                flex: controller.columnRatio[3],
                fit: FlexFit.tight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _operateIcon(
                      EnumImage.cEditNormal,
                      () => controller.interactive(
                        EnumWarehouseAlarmPageInteractive.tapEdit,
                        data: item,
                      ),
                    ),
                    SizedBox(width: 16.0.scale),
                    _operateIcon(
                      EnumImage.cInfo,
                      () => controller.interactive(
                        EnumWarehouseAlarmPageInteractive.tapInfo,
                        data: item,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _operateIcon(EnumImage eImg, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.0.scale),
      child: Container(
        width: 64.0.scale,
        height: 64.0.scale,
        padding: EdgeInsets.all(12.0.scale),
        decoration: ShapeDecoration(
          color: EnumColor.backgroundSecondary.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0.scale),
          ),
        ),
        child: eImg.image(),
      ),
    );
  }
}
