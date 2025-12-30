import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_history/dialog_item_history_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/item_info_card.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_record.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class DialogItemHistoryWidget extends StatelessWidget {
  final Item item;

  const DialogItemHistoryWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogItemHistoryWidgetController>(
      init: DialogItemHistoryWidgetController(item),
      builder: (controller) {
        return DialogFrame(
          width: 962.0.scale,
          header: DialogHeader(title: EnumLocale.record.tr),
          footer: DialogFooter(
            type: DialogFooterType.onlyConfirm,
            onConfirm: () {
              controller.interactive(
                EnumDialogItemHistoryWidgetInteractive.tapDialogConfirmButton,
                data: context,
              );
            },
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemInfoCard(
                itemName: controller.getItemName,
                count: controller.getRecordCount,
                isHistory: true,
              ),
              SizedBox(height: 24.0.scale),
              _RecordsList(),
            ],
          ),
        );
      },
    );
  }
}

class _RecordsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemHistoryWidgetController>();
    return Obx(
      () {
        final records = controller.recordsRx.value;
        final isLoading = records == null;

        if (isLoading) {
          return WidgetUtil.shimmerWidget(
            height: 100.0.scale,
          );
        } else if (records.isEmpty) {
          return WidgetUtil.emptyWidget();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: records
              .expand(
                (record) => [
                  _RecordItem(record: record),
                  Divider(
                    height: 1.0.scale,
                    thickness: 1.0.scale,
                    color: EnumColor.lineDividerLight.color,
                  ),
                ],
              )
              .toList()
            ..removeLast(), // 移除最后一个 divider
        );
      },
    );
  }
}

class _RecordItem extends StatelessWidget {
  final ItemRecord record;

  const _RecordItem({
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemHistoryWidgetController>();
    final operateType = EnumOperateType.fromInt(record.operateType);
    final tag = controller.genTag(record);
    final content = controller.genContent(record);
    final date = controller.formatDate(record.createdAt);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.0.scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RecordTag(
            tag: tag,
            operateType: operateType,
          ),
          SizedBox(width: 24.0.scale),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 12.0.scale),
              child: WidgetUtil.textWidget(
                content,
                size: 28.0.scale,
              ),
            ),
          ),
          SizedBox(width: 24.0.scale),
          Padding(
            padding: EdgeInsets.only(top: 12.0.scale),
            child: WidgetUtil.textWidget(
              date,
              size: 28.0.scale,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecordTag extends StatelessWidget {
  final String tag;
  final EnumOperateType operateType;

  const _RecordTag({
    required this.tag,
    required this.operateType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0.scale,
        vertical: 12.0.scale,
      ),
      decoration: BoxDecoration(
        color: operateType.tagBgColor,
        borderRadius: BorderRadius.circular(100.0.scale),
      ),
      child: WidgetUtil.textWidget(
        tag,
        size: 28.0.scale,
        color: operateType.tagTextColor,
      ),
    );
  }
}
