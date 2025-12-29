import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/warehouse_cabinet_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class CabinetRowCard extends StatelessWidget {
  final List<Cabinet> cabinets;

  const CabinetRowCard({
    super.key,
    required this.cabinets,
  });

  @override
  Widget build(BuildContext context) {
    if (cabinets.isEmpty) {
      return _buildEmptyCard();
    }

    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        itemCount: cabinets.length,
        separatorBuilder: (context, index) => SizedBox(height: 16.0.scale),
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                child: _CabinetCard(cabinet: cabinets[index]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: EnumColor.backgroundSecondary.color,
        borderRadius: BorderRadius.circular(20.0.scale),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 32.0.scale,
        vertical: 22.0.scale,
      ),
      child: WidgetUtil.textWidget(
        EnumLocale.warehouseNoCabinetInRoom.tr,
        size: 26.0.scale,
        color: EnumColor.textSecondary.color,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _CabinetCard extends StatelessWidget {
  final Cabinet cabinet;

  const _CabinetCard({
    required this.cabinet,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCabinetPageController>();
    return Material(
      color: EnumColor.backgroundSecondary.color,
      borderRadius: BorderRadius.circular(20.0.scale),
      child: InkWell(
        onTap: () {
          controller.interactive(
            EnumWarehouseCabinetPageInteractive.tapCabinet,
            data: cabinet,
          );
        },
        borderRadius: BorderRadius.circular(20.0.scale),
        child: Ink(
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
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
        ),
      ),
    );
  }
}
