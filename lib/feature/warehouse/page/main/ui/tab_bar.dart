import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

class CustomTabBar extends StatelessWidget {
  static const itemSpacing = 40.0;
  final _itemPaddingHorizontal = 22.0;
  double get _combinedItemPadding =>
      (_itemPaddingHorizontal + (itemSpacing / 2)).scale;
  final TabController controller;
  final List<Widget> tabs;

  const CustomTabBar({
    super.key,
    required this.controller,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: tabs,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      labelPadding: EdgeInsets.symmetric(
        horizontal: _combinedItemPadding,
      ),
      labelColor: EnumColor.accentBlue.color,
      unselectedLabelColor: EnumColor.textSecondary.color,
      labelStyle: WidgetUtil.textStyle(),
      unselectedLabelStyle: WidgetUtil.textStyle(),
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: EnumColor.accentBlue.color,
            width: 4.0.scale,
          ),
        ),
      ),
      indicatorPadding: EdgeInsets.only(
        left: (itemSpacing / 2).scale,
        right: (itemSpacing / 2).scale,
        bottom: 8.0.scale,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }
}
