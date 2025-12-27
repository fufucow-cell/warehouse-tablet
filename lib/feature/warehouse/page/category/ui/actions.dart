import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/warehouse_category_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:get/get.dart';

class ActionsWidget extends StatelessWidget {
  final Category category;

  const ActionsWidget({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCategoryPageController>();
    final hasChildren = controller.getChildrenList(category).isNotEmpty;
    final isExpanded = controller.isCategoryExpanded(category);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ActionButton(
          eImage: EnumImage.cEditNormal,
          onTap: () {
            controller.interactive(
              EnumWarehouseCategoryPageInteractive.tapEditCategory,
              data: category,
            );
          },
        ),
        SizedBox(width: 16.0.scale),
        _ActionButton(
          eImage: EnumImage.cTrash3,
          onTap: () {
            controller.interactive(
              EnumWarehouseCategoryPageInteractive.tapDeleteCategory,
              data: category,
            );
          },
        ),
        SizedBox(width: 16.0.scale),
        Visibility(
          visible: hasChildren,
          child: _ActionButton(
            eImage: isExpanded ? EnumImage.cArrowUp : EnumImage.cArrowDown,
            onTap: () {
              controller.interactive(
                EnumWarehouseCategoryPageInteractive.tapExpandCategory,
                data: category,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final EnumImage eImage;
  final VoidCallback onTap;

  const _ActionButton({
    required this.eImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.0.scale),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 13.5.scale,
            vertical: 12.0.scale,
          ),
          decoration: BoxDecoration(
            color: (eImage == EnumImage.cArrowUp) ? EnumColor.backgroundProduct.color : EnumColor.backgroundSecondary.color,
            borderRadius: BorderRadius.circular(20.0.scale),
          ),
          child: eImage.image(size: Size.square(40.0.scale)),
        ),
      ),
    );
  }
}
