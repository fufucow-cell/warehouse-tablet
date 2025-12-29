import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/actions.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/dialog_category_edit/dialog_category_edit_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/dialog_category_edit/dialog_category_edit_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog_section_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class DialogCategoryEditWidget extends StatelessWidget {
  final Future<bool> Function(DialogCategoryEditOutputModel) onConfirm;
  final Category category;

  const DialogCategoryEditWidget({
    super.key,
    required this.onConfirm,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogCategoryEditWidgetController>(
      init: DialogCategoryEditWidgetController(category),
      builder: (controller) {
        return DialogFrame(
          width: 720.0.scale,
          minHeight: 625.0.scale,
          header: DialogHeader(title: EnumLocale.editCategoryTitle.tr),
          footer: Obx(
            () {
              final isLoading = controller.isLoadingRx.value;
              return DialogFooter(
                type: DialogFooterType.cancelAndConfirm,
                isLoading: isLoading,
                onCancel: () {
                  controller.interactive(
                    EnumDialogCategoryEditWidgetInteractive
                        .tapDialogCancelButton,
                    data: context,
                  );
                },
                onConfirm: () async {
                  final outputModel = await controller.checkOutputModel();

                  if (outputModel == null) {
                    return;
                  }

                  controller.interactive(
                    EnumDialogCategoryEditWidgetInteractive
                        .tapDialogConfirmButton,
                    data: true,
                  );
                  final isSuccess = await onConfirm(outputModel);

                  if (isSuccess) {
                    controller.interactive(
                      EnumDialogCategoryEditWidgetInteractive
                          .tapDialogConfirmButton,
                      data: context,
                    );
                  }

                  controller.interactive(
                    EnumDialogCategoryEditWidgetInteractive
                        .tapDialogConfirmButton,
                    data: false,
                  );
                },
              );
            },
          ),
          child: const _Body(),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogCategoryEditWidgetController>();
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _NameField(),
            SizedBox(height: 24.0.scale),
            WidgetUtil.textWidget(
              controller.hintTextRx.value,
              size: 28.0.scale,
              color: EnumColor.textPrimary.color,
            ),
            SizedBox(height: 24.0.scale),
            _DropdownField(
              title: EnumLocale.createLevel1Category.tr,
              selectedValue: controller.selectedLevel1Rx.value?.name,
              visibleValues: controller.getLevel1NameList(),
              isMax: controller.level1IsMaxRx.value,
              onValueSelected: (str) => controller.interactive(
                  EnumDialogCategoryEditWidgetInteractive.tapLevel1Button,
                  data: str),
              onDelete: () => controller.interactive(
                  EnumDialogCategoryEditWidgetInteractive.tapDeleteLevel1Button,
                  data: context),
            ),
            if (controller.selectedLevel1Rx.value != null) ...[
              SizedBox(height: 24.0.scale),
              _DropdownField(
                title: EnumLocale.createLevel2Category.tr,
                selectedValue: controller.selectedLevel2Rx.value?.name,
                visibleValues: controller.getLevel2NameList(),
                isMax: controller.level2IsMaxRx.value,
                onValueSelected: (str) => controller.interactive(
                    EnumDialogCategoryEditWidgetInteractive.tapLevel2Button,
                    data: str),
                onDelete: () => controller.interactive(
                    EnumDialogCategoryEditWidgetInteractive
                        .tapDeleteLevel2Button,
                    data: context),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogCategoryEditWidgetController>();
    return DialogSectionWidget(
      isRequired: true,
      title: EnumLocale.createCategoryName.tr,
      child: WidgetUtil.textField(
        controller: controller.nameController,
        maxLength: 100,
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String title;
  final String? selectedValue;
  final List<String> visibleValues;
  final bool isMax;
  final Function(String?) onValueSelected;
  final VoidCallback onDelete;

  const _DropdownField({
    required this.title,
    required this.selectedValue,
    required this.visibleValues,
    required this.isMax,
    required this.onValueSelected,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: DialogSectionWidget(
            title: title,
            child: WidgetUtil.textDropdownButton(
              selectedValue: isMax
                  ? EnumLocale.editCategoryMaxLevelReached.tr
                  : selectedValue,
              values: isMax ? [] : visibleValues,
              buttonTextColor:
                  selectedValue == null ? EnumColor.textSecondary.color : null,
              menuMaxHeight: 290.0.scale,
              onValueSelected: onValueSelected,
            ),
          ),
        ),
        if (selectedValue != null &&
            selectedValue != EnumLocale.optionPleaseSelect.tr) ...[
          SizedBox(width: 12.0.scale),
          ActionButton(
            eImage: EnumImage.cTrash3,
            onTap: onDelete,
          ),
        ],
      ],
    );
  }
}
