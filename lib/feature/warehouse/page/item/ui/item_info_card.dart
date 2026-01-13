import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/cust_text_widget.dart';

class ItemInfoCard extends StatelessWidget {
  final String itemName;
  final int count;
  final bool isHistory;

  const ItemInfoCard({
    super.key,
    required this.itemName,
    required this.count,
    required this.isHistory,
  });

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
            value: itemName,
            fontSize: 28.0.scale,
          ),
          SizedBox(height: 24.0.scale),
          _InfoRow(
            label: isHistory ? EnumLocale.warehouseRecordCount.tr : EnumLocale.warehouseCurrentQuantityLabel.tr,
            value: count.toString(),
            fontSize: 28.0.scale,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;
  final double fontSize;

  const _InfoRow({
    required this.label,
    this.value,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 104.0.scale),
            child: CustTextWidget(
              label,
              size: fontSize,
              color: EnumColor.textSecondary.color,
            ),
          ),
        ),
        SizedBox(width: 24.0.scale),
        Expanded(
          flex: 3,
          child: CustTextWidget(
            value ?? '',
            size: fontSize,
          ),
        ),
      ],
    );
  }
}
