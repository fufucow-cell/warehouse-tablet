import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/ui/filter_info.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/second_background_card.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/util/record_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class WarehouseRecordPage extends StatelessWidget {
  const WarehouseRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseRecordPageController>(
      init: Get.isRegistered<WarehouseRecordPageController>() ? null : WarehouseRecordPageController(),
      builder: (controller) {
        return SecondBackgroundCard(
          child: Column(
            children: [
              const FilterInfo(),
              SizedBox(height: 32.0.scale),
              const Expanded(child: RecordList()),
            ],
          ),
        );
      },
    );
  }
}

class RecordList extends StatelessWidget {
  const RecordList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseRecordPageController>(
      builder: (controller) {
        return Obx(
          () {
            final records = controller.visibleLogsRx.value;

            if (controller.allLogsRx.value == null) {
              return const _RecordHeaderShimmer();
            } else if (records.isEmpty) {
              return WidgetUtil.emptyWidget();
            }

            final columnRatio = controller.columnRatioRx;
            final avatarUrl = controller.avatarUrl;

            return Column(
              children: [
                const _RecordHeader(),
                Expanded(
                  child: ListView.separated(
                    controller: controller.scrollController,
                    itemCount: records.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                        thickness: 1,
                        color: EnumColor.lineDividerLight.color,
                      );
                    },
                    itemBuilder: (context, index) {
                      return _RecordItem(
                        record: records[index],
                        columnRatio: columnRatio,
                        avatarUrl: avatarUrl,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _RecordHeader extends StatelessWidget {
  const _RecordHeader();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseRecordPageController>();
    final columnRatio = controller.columnRatioRx;

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
            flex: columnRatio[0],
            child: SizedBox(
              height: 42.0.scale,
              child: WidgetUtil.textWidget(
                EnumLocale.warehouseRecordColumnType.tr,
                size: 28.0.scale,
                color: EnumColor.textSecondary.color,
              ),
            ),
          ),
          SizedBox(width: 44.0.scale),
          Expanded(
            flex: columnRatio[1],
            child: SizedBox(
              height: 42.0.scale,
              child: WidgetUtil.textWidget(
                EnumLocale.warehouseRecordColumnContent.tr,
                size: 28.0.scale,
                color: EnumColor.textSecondary.color,
              ),
            ),
          ),
          SizedBox(width: 44.0.scale),
          Expanded(
            flex: columnRatio[2],
            child: SizedBox(
              height: 42.0.scale,
              child: WidgetUtil.textWidget(
                EnumLocale.warehouseRecordColumnTime.tr,
                size: 28.0.scale,
                color: EnumColor.textSecondary.color,
              ),
            ),
          ),
          SizedBox(width: 44.0.scale),
          Expanded(
            flex: columnRatio[3],
            child: SizedBox(
              height: 42.0.scale,
              child: WidgetUtil.textWidget(
                EnumLocale.warehouseRecordColumnPerson.tr,
                size: 28.0.scale,
                color: EnumColor.textSecondary.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecordItem extends StatelessWidget {
  final CombineRecord record;
  final List<int> columnRatio;
  final String avatarUrl;

  const _RecordItem({
    required this.record,
    required this.columnRatio,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.0.scale),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: columnRatio[0],
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 24.0.scale,
                vertical: 12.0.scale,
              ),
              decoration: ShapeDecoration(
                color: record.tagType.operateType.tagBgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0.scale),
                ),
              ),
              child: WidgetUtil.textWidget(
                record.tagType.title,
                size: 28.0.scale,
                color: record.tagType.operateType.tagTextColor,
                align: TextAlign.center,
              ),
            ),
          ),
          SizedBox(width: 44.0.scale),
          Expanded(
            flex: columnRatio[1],
            child: Padding(
              padding: EdgeInsets.only(top: 12.0.scale),
              child: WidgetUtil.textWidget(
                record.content,
                size: 28.0.scale,
                color: EnumColor.textPrimary.color,
              ),
            ),
          ),
          SizedBox(width: 44.0.scale),
          Expanded(
            flex: columnRatio[2],
            child: WidgetUtil.textWidget(
              record.date,
              size: 28.0.scale,
              color: EnumColor.textPrimary.color,
            ),
          ),
          SizedBox(width: 44.0.scale),
          Expanded(
            flex: columnRatio[3],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(32.0.scale),
                  child: WidgetUtil.networkImage(
                    url: avatarUrl,
                    width: 64.0.scale,
                    height: 64.0.scale,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 24.0.scale),
                WidgetUtil.textWidget(
                  record.userName,
                  size: 28.0.scale,
                  color: EnumColor.textPrimary.color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecordHeaderShimmer extends StatelessWidget {
  const _RecordHeaderShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 3,
      separatorBuilder: (context, index) {
        return SizedBox(height: 16.0.scale);
      },
      itemBuilder: (context, index) {
        return WidgetUtil.shimmerWidget(height: 112.0.scale);
      },
    );
  }
}
