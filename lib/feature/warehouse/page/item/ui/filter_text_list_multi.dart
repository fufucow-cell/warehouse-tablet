import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';

/// 複選版的 Filter Text List
class FilterTextListMulti extends StatelessWidget {
  final List<String> items;
  final Set<int> selectedIndices;
  final ValueChanged<int>? onTap;

  const FilterTextListMulti({
    super.key,
    required this.items,
    this.selectedIndices = const {},
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int index = 0; index < items.length; index++) ...[
            _FilterItem(
              title: items[index],
              isSelected: selectedIndices.contains(index),
              onPressed: onTap == null
                  ? null
                  : () {
                      onTap!(index);
                    },
            ),
            if (index < items.length - 1) SizedBox(width: 32.0.scale),
          ],
        ],
      ),
    );
  }
}

class _FilterItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onPressed;

  const _FilterItem({
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
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          (isSelected ? EnumImage.cCheckboxOn : EnumImage.cCheckboxOff).image(
            size: Size(29.0.scale, 29.0.scale),
          ),
          SizedBox(width: 16.0.scale),
          Text(
            title,
            style: TextStyle(
              color: EnumColor.textSecondary.color,
            ),
          ),
        ],
      ),
    );
  }
}
