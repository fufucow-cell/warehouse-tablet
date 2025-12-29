import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_record.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class RecordList extends StatelessWidget {
  const RecordList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseRecordPageController>(
      builder: (controller) {
        return Obx(
          () {
            final logs = controller.visibleLogsRx.value;
            final isLoading = controller.allLogsRx.value == null;
            final isEmpty = controller.allLogsRx.value?.isEmpty ?? true;

            if (isLoading) {
              return const _RecordHeaderShimmer();
            } else if (isEmpty) {
              return WidgetUtil.emptyWidget();
            }

            if (logs.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              children: [
                const _RecordHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      children: logs
                          .expand(
                            (log) => [
                              _RecordItem(log: log),
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
    return GetBuilder<WarehouseRecordPageController>(
      builder: (controller) {
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
      },
    );
  }
}

class _RecordItem extends StatelessWidget {
  final ItemRecord log;

  const _RecordItem({required this.log});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseRecordPageController>(
      builder: (controller) {
        final columnRatio = controller.columnRatioRx;
        final operateType = EnumOperateType.fromInt(log.operateType);
        final tagType = controller.genTagType(log);
        final content = controller.genContent(log);

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
                    color: operateType.tagBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0.scale),
                    ),
                  ),
                  child: WidgetUtil.textWidget(
                    tagType.title,
                    size: 28.0.scale,
                    color: operateType.tagTextColor,
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
                    content,
                    size: 28.0.scale,
                    color: EnumColor.textPrimary.color,
                  ),
                ),
              ),
              SizedBox(width: 44.0.scale),
              Expanded(
                flex: columnRatio[2],
                child: WidgetUtil.textWidget(
                  controller.formatDate(log.createdAt),
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
                    Container(
                      width: 64.0.scale,
                      height: 64.0.scale,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(controller.avatarUrl),
                          fit: BoxFit.cover,
                        ),
                        color: log.itemPhoto == null ||
                                (log.itemPhoto != null && log.itemPhoto!.isEmpty) ||
                                (log.itemPhoto != null && log.itemPhoto!.isNotEmpty && (log.itemPhoto![0].isEmpty))
                            ? EnumColor.backgroundSecondary.color
                            : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0.scale),
                        ),
                      ),
                    ),
                    SizedBox(width: 24.0.scale),
                    WidgetUtil.textWidget(
                      log.userName ?? '-',
                      size: 28.0.scale,
                      color: EnumColor.textPrimary.color,
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
