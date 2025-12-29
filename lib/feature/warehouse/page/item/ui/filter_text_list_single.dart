import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';

class FilterTextListSingle extends StatelessWidget {
  final List<String> items;
  final int? selectedIndex;
  final ValueChanged<int>? onTap;

  const FilterTextListSingle({
    super.key,
    required this.items,
    this.selectedIndex,
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
  final VoidCallback? onPressed;

  const FilterTextListSingleItem({
    super.key,
    required this.title,
    required this.isSelected,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0.scale,
          vertical: 16.0.scale,
        ),
        backgroundColor: isSelected ? EnumColor.menuBgFocused.color : Colors.transparent,
        foregroundColor: isSelected ? EnumColor.textProduct.color : EnumColor.textSecondary.color,
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
