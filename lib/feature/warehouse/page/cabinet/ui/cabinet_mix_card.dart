import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

class CabinetMixCard extends StatelessWidget {
  final List<Cabinet> cabinets;

  const CabinetMixCard({
    super.key,
    required this.cabinets,
  });

  @override
  Widget build(BuildContext context) {
    if (cabinets.isEmpty) {
      return const SizedBox.shrink();
    }

    final pairs = <List<Cabinet>>[];

    for (int i = 0; i < cabinets.length; i += 2) {
      if (i + 1 < cabinets.length) {
        pairs.add([cabinets[i], cabinets[i + 1]]);
      } else {
        pairs.add([cabinets[i]]);
      }
    }

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const ClampingScrollPhysics(),
      itemCount: pairs.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.0.scale),
      itemBuilder: (context, index) {
        final pair = pairs[index];
        return Row(
          children: [
            Expanded(
              child: _buildCabinetCard(pair[0]),
            ),
            if (pair.length > 1) ...[
              SizedBox(width: 16.0.scale),
              Expanded(
                child: _buildCabinetCard(pair[1]),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildCabinetCard(Cabinet cabinet) {
    return Container(
      decoration: BoxDecoration(
        color: EnumColor.backgroundSecondary.color,
        borderRadius: BorderRadius.circular(20.0.scale),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 22.0.scale,
        horizontal: 32.0.scale,
      ),
      child: Row(
        children: [
          Expanded(
            child: WidgetUtil.textWidget(
              cabinet.name ?? '',
              size: 26.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ),
          SizedBox(width: 8.0.scale),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 18.0.scale,
            ),
            decoration: BoxDecoration(
              color: EnumColor.backgroundAccentBlue.color,
              borderRadius: BorderRadius.circular(12.0.scale),
            ),
            child: WidgetUtil.textWidget(
              '${cabinet.quantity ?? 0}',
              size: 28.0.scale,
              color: EnumColor.accentBlue.color,
            ),
          ),
        ],
      ),
    );
  }
}
