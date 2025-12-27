import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/dialog_category_create/dialog_category_create_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/dialog_category_create/dialog_category_create_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog_section_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class DialogCategoryCreateWidget extends StatelessWidget {
  final Future<bool> Function(DialogCategoryCreateOutputModel) onConfirm;

  const DialogCategoryCreateWidget({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogCategoryCreateWidgetController>(
      init: DialogCategoryCreateWidgetController(),
      builder: (controller) {
        return Obx(
          () {
            final isLoading = controller.isLoadingRx.value;

            return DialogFrame(
              width: 720.0.scale,
              minHeight: 430.0.scale,
              header: DialogHeader(title: EnumLocale.createCategoryTitle.tr),
              footer: DialogFooter(
                type: DialogFooterType.cancelAndConfirm,
                isLoading: isLoading,
                onCancel: () {
                  controller.interactive(
                    EnumDialogCategoryCreateWidgetInteractive.tapDialogCancelButton,
                    data: context,
                  );
                },
                onConfirm: () async {
                  controller.interactive(EnumDialogCategoryCreateWidgetInteractive.tapDialogConfirmButton, data: true);
                  final outputModel = await controller.checkOutputModel();

                  if (outputModel == null) {
                    controller.interactive(EnumDialogCategoryCreateWidgetInteractive.tapDialogConfirmButton, data: false);
                    return;
                  }

                  final isSuccess = await onConfirm(outputModel);

                  if (isSuccess) {
                    Navigator.of(context).pop();
                  }

                  controller.interactive(EnumDialogCategoryCreateWidgetInteractive.tapDialogConfirmButton, data: context);
                },
              ),
              child: const _Body(),
            );
          },
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogCategoryCreateWidgetController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _NameField(),
        SizedBox(height: 24.0.scale),
        WidgetUtil.textWidget(
          EnumLocale.createCategoryParentQuestion.tr,
          size: 28.0.scale,
          color: EnumColor.textPrimary.color,
        ),
        SizedBox(height: 24.0.scale),
        Obx(
          () => _DropdownField(
            title: EnumLocale.createCategoryParentLabel.tr,
            selectedValue: controller.selectedParentCategoryRx.value?.name,
            visibleValues: controller.getParentCategoryNameList(),
            onValueSelected: (str) => controller.interactive(EnumDialogCategoryCreateWidgetInteractive.tapParentCategory, data: str),
          ),
        ),
      ],
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogCategoryCreateWidgetController>();
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
  final Function(String?) onValueSelected;

  const _DropdownField({
    required this.title,
    required this.selectedValue,
    required this.visibleValues,
    required this.onValueSelected,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogCategoryCreateWidgetController>();
    return DialogSectionWidget(
      title: title,
      child: WidgetUtil.textDropdownButton(
        selectedValue: selectedValue,
        values: visibleValues,
        buttonTextColor: selectedValue == null ? EnumColor.textSecondary.color : null,
        menuMaxHeight: 290.0.scale,
        onValueSelected: onValueSelected,
        onMenuOpened: () => controller.interactive(EnumDialogCategoryCreateWidgetInteractive.tapDropdownButton),
      ),
    );
  }
}
