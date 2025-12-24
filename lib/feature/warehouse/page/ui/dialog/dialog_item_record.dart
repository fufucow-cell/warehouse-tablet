import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

class DialogItemRecord extends StatelessWidget {
  final DialogItemRecordModel dataModel;

  const DialogItemRecord(this.dataModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return DialogFrame(
      header: DialogHeader(title: EnumLocale.warehouseItemRecord.tr),
      footer: DialogFooter(
        type: DialogFooterType.cancelAndConfirm,
        onCancel: () => Navigator.of(context).pop(),
        onConfirm: () {
          // TODO: 实现确认逻辑
          Navigator.of(context).pop();
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoCard(dataModel: dataModel),
          SizedBox(height: 24.0.scale),
          _RecordsList(records: dataModel.records ?? []),
        ],
      ),
    );
  }
}

class DialogItemRecordModel {
  final String? itemName;
  final int? currentQuantity;
  final List<DialogItemRecordItemModel>? records;

  DialogItemRecordModel({
    this.itemName,
    this.currentQuantity,
    this.records,
  });
}

class DialogItemRecordItemModel {
  final String tag;
  final String content;
  final String date;

  DialogItemRecordItemModel({
    required this.tag,
    required this.content,
    required this.date,
  });
}

class _InfoCard extends StatelessWidget {
  final DialogItemRecordModel dataModel;

  const _InfoCard({required this.dataModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 32.0.scale,
        vertical: 44.0.scale,
      ),
      decoration: BoxDecoration(
        color: EnumColor.backgroundSecondary.color,
        borderRadius: BorderRadius.circular(20.0.scale),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(
            label: EnumLocale.createItemName.tr,
            value: dataModel.itemName ?? '',
          ),
          SizedBox(height: 24.0.scale),
          _InfoRow(
            label: EnumLocale.warehouseCurrentQuantityLabel.tr,
            value: (dataModel.currentQuantity ?? 0).toString(),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 112.0.scale,
          child: WidgetUtil.textWidget(
            label,
            size: 26.0.scale,
            color: EnumColor.textSecondary.color,
          ),
        ),
        SizedBox(width: 24.0.scale),
        Expanded(
          child: WidgetUtil.textWidget(
            value,
            size: 26.0.scale,
          ),
        ),
      ],
    );
  }
}

class _RecordsList extends StatelessWidget {
  final List<DialogItemRecordItemModel> records;

  const _RecordsList({required this.records});

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < records.length; i++) ...[
          _RecordItem(record: records[i]),
          if (i < records.length - 1) ...[
            SizedBox(height: 16.0.scale),
            Divider(
              height: 1.0.scale,
              thickness: 1.0.scale,
              color: EnumColor.lineDividerLight.color,
            ),
            SizedBox(height: 16.0.scale),
          ],
        ],
      ],
    );
  }
}

class _RecordItem extends StatelessWidget {
  final DialogItemRecordItemModel record;

  const _RecordItem({required this.record});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.0.scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _RecordTag(tag: record.tag),
          SizedBox(width: 24.0.scale),
          Expanded(
            child: WidgetUtil.textWidget(
              record.content,
              size: 28.0.scale,
            ),
          ),
          SizedBox(width: 24.0.scale),
          WidgetUtil.textWidget(
            record.date,
            size: 28.0.scale,
          ),
        ],
      ),
    );
  }
}

class _RecordTag extends StatelessWidget {
  final String tag;

  const _RecordTag({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0.scale,
        vertical: 12.0.scale,
      ),
      decoration: BoxDecoration(
        color: EnumColor.backgroundAccentBlue.color,
        borderRadius: BorderRadius.circular(100.0.scale),
      ),
      child: WidgetUtil.textWidget(
        tag,
        size: 28.0.scale,
        color: EnumColor.accentBlue.color,
      ),
    );
  }
}
