import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';

class CustomTabBar extends StatelessWidget {
  final itemSpacing = 40.0; // 每個 tab Item 之間的間距
  final itemPaddingHorizontal = 22.0; // 每個 tab Item 左右內縮的距離 (讓底線寬度能超出文字)
  double get combinedPadding => (itemPaddingHorizontal + (itemSpacing / 2)); // 將兩個 padding 結合
  final underlineSpacing = 12.0;
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
        horizontal: combinedPadding.scale,
        vertical: 0.0.scale, // 增加垂直 padding 来增加高度
      ),
      labelColor: EnumColor.accentBlue.color,
      unselectedLabelColor: EnumColor.textSecondary.color,
      labelStyle: CustTextStyle(),
      unselectedLabelStyle: CustTextStyle(),
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
        bottom: (20.0 - underlineSpacing).scale,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }
}
