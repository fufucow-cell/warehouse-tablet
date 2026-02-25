import 'package:engo_terminal_app3/wh/feature/air_quality/page/reference/air_quality_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';

class SensorDataBar extends StatelessWidget {
  final List<Map<EnumAirQualityDataType, double?>> datas;

  const SensorDataBar({
    super.key,
    required this.datas,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    for (int i = 0; i < datas.length; i++) {
      final mapValue = datas[i];

      if (i > 0) {
        widgets.add(const _Divider());
      }

      widgets.add(
        _DataItem(
          type: mapValue.keys.first,
          value: mapValue.values.first,
        ),
      );
    }

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 16.0.scale),
      decoration: ShapeDecoration(
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 15.0.scale,
          colors: EnumColor.airBoxDataCardGradient.colors,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0.scale,
            color: EnumColor.engoButtonBorderReverse.color,
          ),
          borderRadius: BorderRadius.circular(12.0.scale),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        child: Row(
          children: [SizedBox(width: 32.0.scale), ...widgets, SizedBox(width: 32.0.scale)],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 65.0.scale),
      width: 1.0.scale,
      height: 75.0.scale,
      color: Colors.black,
    );
  }
}

class _DataItem extends StatelessWidget {
  final EnumAirQualityDataType type;
  final double? value;

  const _DataItem({
    required this.type,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    Color color = EnumColor.accentBlue.color;
    String displayValue = '-';

    if (value != null) {
      final level = type.getReferenceLevelByValue(value!, null);

      if (level != null) {
        color = level.color;
      }

      displayValue = value!.toStringAsFixed(type.displayDecimal);
    }

    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              type.enumImage.image(
                size: Size.square(36.0.scale),
                color: EnumColor.textPrimary.color,
              ),
              SizedBox(width: 8.0.scale),
              CustTextWidget(
                type.title,
                size: 26.0.scale,
                weightType: EnumFontWeightType.regular,
                color: EnumColor.textPrimary.color,
                align: TextAlign.center,
              ),
            ],
          ),
          SizedBox(height: 16.0.scale),
          CustTextWidget(
            '$displayValue ${type.unit}',
            size: 38.0.scale,
            weightType: EnumFontWeightType.bold,
            color: color,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
