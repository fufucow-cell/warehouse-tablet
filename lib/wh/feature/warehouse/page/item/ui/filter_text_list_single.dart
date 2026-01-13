import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter/material.dart';

class FilterTextListSingle extends StatelessWidget {
  final List<String> items;
  final int? selectedIndex;
  final bool isFillColor;
  final ValueChanged<int>? onTap;

  const FilterTextListSingle({
    super.key,
    required this.items,
    this.selectedIndex,
    this.isFillColor = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int index = 0; index < items.length; index++) ...[
            FilterTextListSingleItem(
              title: items[index],
              isSelected: selectedIndex == index,
              isFillColor: isFillColor,
              onPressed: onTap == null ? null : () => onTap!(index),
            ),
            if (index < items.length - 1) SizedBox(width: 32.0.scale),
          ],
        ],
      ),
    );
  }
}

class FilterTextListSingleItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final bool isFillColor;
  final VoidCallback? onPressed;

  const FilterTextListSingleItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.isFillColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(
          horizontal: 24.0.scale,
          vertical: 16.0.scale,
        ),
        backgroundColor: isSelected ? (isFillColor ? EnumColor.backgroundButtonFill.color : EnumColor.menuBgFocused.color) : Colors.transparent,
        foregroundColor: isSelected ? (isFillColor ? EnumColor.textWhite.color : EnumColor.textProduct.color) : EnumColor.textSecondary.color,
        side: BorderSide(
          color: isSelected ? EnumColor.menuIconFocused.color : Colors.transparent,
          width: 1.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0.scale),
        ),
      ),
      child: Text(title),
    );
  }
}
