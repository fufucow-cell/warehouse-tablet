import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/warehouse_category_page_controller.dart';
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
        ActionButton(
          eImage: EnumImage.cEditNormal,
          onTap: () {
            controller.interactive(
              EnumWarehouseCategoryPageInteractive.tapEditCategory,
              data: category,
            );
          },
        ),
        SizedBox(width: 16.0.scale),
        ActionButton(
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
          child: ActionButton(
            eImage: isExpanded ? EnumImage.cArrowUp2 : EnumImage.cArrowDown2,
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

class ActionButton extends StatelessWidget {
  final EnumImage eImage;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.eImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = (eImage == EnumImage.cArrowUp2) ? EnumColor.backgroundProduct.color : EnumColor.backgroundSecondary.color;

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20.0.scale),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.0.scale),
        splashColor: EnumColor.accentBlue.color.withOpacity(0.2),
        highlightColor: EnumColor.accentBlue.color.withOpacity(0.1),
        child: Ink(
          padding: EdgeInsets.symmetric(
            horizontal: 13.5.scale,
            vertical: 12.0.scale,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0.scale),
          ),
          child: eImage.image(size: Size.square(40.0.scale), color: EnumColor.iconSecondary.color),
        ),
      ),
    );
  }
}
