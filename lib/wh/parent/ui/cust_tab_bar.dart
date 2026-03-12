import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';

class CustTabBar extends StatelessWidget {
  final List<String> titles;
  final int selectedIndex;
  final Function(int) onChanged;

  const CustTabBar({
    super.key,
    required this.titles,
    this.selectedIndex = 0,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: EnumColor.backgroundPrimary.color,
        border: Border.all(
          width: 1.0.scale,
          color: EnumColor.lineProduct.color,
        ),
        borderRadius: BorderRadius.circular(8.0.scale),
      ),
      child: Row(
        children: [
          for (var i = 0; i < titles.length; i++) ...[
            if (i > 0) SizedBox(width: 48.0.scale),
            Expanded(
              child: _FilterTab(
                title: titles[i],
                isSelected: selectedIndex == i,
                onTap: () => onChanged(i),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterTab({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.0.scale),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? EnumColor.backgroundButton.color
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0.scale),
        ),
        child: CustTextWidget(
          title,
          color: isSelected
              ? EnumColor.textWhite.color
              : EnumColor.textSecondary.color,
        ),
      ),
    );
  }
}
