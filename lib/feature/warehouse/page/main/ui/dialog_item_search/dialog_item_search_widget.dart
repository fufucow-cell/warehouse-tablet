import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog_item_search/dialog_item_search_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog_item_search/dialog_item_search_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog_section_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class DialogItemSearchWidget extends StatelessWidget {
  final void Function(DialogItemSearchOutputModel) onConfirm;

  const DialogItemSearchWidget({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogItemSearchWidgetController>(
      init: DialogItemSearchWidgetController(),
      builder: (controller) => DialogFrame(
        width: 720.0.scale,
        minHeight: 530.0.scale,
        // maxHeight: 550.0.scale,
        header: DialogHeader(title: EnumLocale.commonSearch.tr),
        footer: DialogFooter(
          type: DialogFooterType.cancelAndConfirm,
          onCancel: () => controller.interactive(
            EnumDialogItemSearchWidgetInteractive.tapDialogFooterButton,
            data: context,
          ),
          onConfirm: () {
            onConfirm(controller.genOutputModel());
            controller.interactive(
              EnumDialogItemSearchWidgetInteractive.tapDialogFooterButton,
              data: context,
            );
          },
        ),
        child: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemSearchWidgetController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetUtil.textField(
          controller: controller.searchController,
          hintText: EnumLocale.searchItemNameOrDescriptionHint.tr,
          prefixIcon: EnumImage.cSearch2.image(
              size: Size.square(38.0.scale),
              color: EnumColor.iconSecondary.color),
          prefixIconSize: 38.0.scale,
          maxLength: 100,
        ),
        SizedBox(height: 24.0.scale),
        Obx(
          () {
            final selectedLevel1 = controller.selectedCategoryLevel1Rx.value;
            final selectedLevel2 = controller.selectedCategoryLevel2Rx.value;
            final selectedLevel3 = controller.selectedCategoryLevel3Rx.value;
            final visibleLevel1 = controller.visibleCategoryLevel1Rx.value;
            final visibleLevel2 = controller.visibleCategoryLevel2Rx.value;
            final visibleLevel3 = controller.visibleCategoryLevel3Rx.value;

            return Column(
              children: [
                _DropdownField(
                  title: selectedLevel1 == null
                      ? EnumLocale.category.tr
                      : EnumLocale.createLevel1Category.tr,
                  selectedValue: selectedLevel1?.name,
                  visibleValues:
                      visibleLevel1.map((cat) => cat.name ?? '').toList(),
                  onValueSelected: (str) => controller.interactive(
                    EnumDialogItemSearchWidgetInteractive.tapCategoryLevel1,
                    data: str,
                  ),
                ),
                if (selectedLevel1 != null) ...[
                  SizedBox(height: 24.0.scale),
                  _DropdownField(
                    title: EnumLocale.createLevel2Category.tr,
                    selectedValue: selectedLevel2?.name,
                    visibleValues:
                        visibleLevel2.map((cat) => cat.name ?? '').toList(),
                    onValueSelected: (str) => controller.interactive(
                      EnumDialogItemSearchWidgetInteractive.tapCategoryLevel2,
                      data: str,
                    ),
                  ),
                ],
                if (selectedLevel2 != null) ...[
                  SizedBox(height: 24.0.scale),
                  _DropdownField(
                    title: EnumLocale.createLevel3Category.tr,
                    selectedValue: selectedLevel3?.name,
                    visibleValues:
                        visibleLevel3.map((cat) => cat.name ?? '').toList(),
                    onValueSelected: (str) => controller.interactive(
                      EnumDialogItemSearchWidgetInteractive.tapCategoryLevel3,
                      data: str,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String title;
  final String? selectedValue;
  final List<String> visibleValues;
  final Function(String?) onValueSelected;

  const _DropdownField({
    required this.title,
    required this.selectedValue,
    required this.visibleValues,
    required this.onValueSelected,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemSearchWidgetController>();
    return DialogSectionWidget(
      title: title,
      child: WidgetUtil.textDropdownButton(
        selectedValue: selectedValue,
        values: visibleValues,
        buttonTextColor:
            selectedValue == null ? EnumColor.textSecondary.color : null,
        menuMaxHeight: 290.0.scale,
        onValueSelected: onValueSelected,
        onMenuOpened: () => controller.interactive(
          EnumDialogItemSearchWidgetInteractive.tapDropdownButton,
        ),
      ),
    );
  }
}
