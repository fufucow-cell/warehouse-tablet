import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.child,
    this.highlightColor,
  });

  final double width;
  final double height;
  final Widget? child;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: EnumColor.backgroundLoadingBase.color,
      highlightColor: highlightColor ?? EnumColor.backgroundLoadingHighlight.color,
      child: child ??
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0.scale),
              ),
            ),
          ),
    );
  }
}

class ShimmerTextWidget extends StatelessWidget {
  final String text;
  final double? size;
  final TextAlign align;
  final EnumFontWeightType weightType;
  final Color? color;

  const ShimmerTextWidget(
    this.text, {
    super.key,
    this.size,
    this.align = TextAlign.start,
    this.weightType = EnumFontWeightType.regular,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: EnumColor.backgroundLoadingBase.color,
      highlightColor: EnumColor.backgroundLoadingHighlight.color,
      child: CustTextWidget(
        text,
        size: size,
        align: align,
        weightType: weightType,
        color: color ?? EnumColor.textSecondary.color,
      ),
    );
  }
}
