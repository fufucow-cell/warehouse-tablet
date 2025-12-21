import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';

class CabinetRowCard extends StatelessWidget {
  final List<Cabinet> cabinets;

  const CabinetRowCard({
    super.key,
    required this.cabinets,
  });

  @override
  Widget build(BuildContext context) {
    if (cabinets.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cabinets.length,
      separatorBuilder: (context, index) => SizedBox(height: 8.0.scale),
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: _buildCabinetCard(cabinets[index]),
            ),
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
            child: Text(cabinet.name ?? ''),
          ),
          Text('${cabinet.quantity ?? 0}'),
        ],
      ),
    );
  }
}
