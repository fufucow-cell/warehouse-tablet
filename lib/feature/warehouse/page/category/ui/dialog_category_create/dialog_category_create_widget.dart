import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/actions.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/dialog_category_create/dialog_category_create_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/dialog_category_create/dialog_category_create_widget_model.dart';
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
        return DialogFrame(
          width: 720.0.scale,
          minHeight: 625.0.scale,
          header: DialogHeader(title: EnumLocale.createCategoryTitle.tr),
          footer: Obx(
            () {
              final isLoading = controller.isLoadingRx.value;
              return DialogFooter(
                type: DialogFooterType.cancelAndConfirm,
                isLoading: isLoading,
                onCancel: () {
                  controller.interactive(
                    EnumDialogCategoryCreateWidgetInteractive
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
                    EnumDialogCategoryCreateWidgetInteractive
                        .tapDialogConfirmButton,
                    data: true,
                  );
                  final isSuccess = await onConfirm(outputModel);

                  if (isSuccess) {
                    controller.interactive(
                      EnumDialogCategoryCreateWidgetInteractive
                          .tapDialogConfirmButton,
                      data: context,
                    );
                  }

                  controller.interactive(
                    EnumDialogCategoryCreateWidgetInteractive
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
    final controller = Get.find<DialogCategoryCreateWidgetController>();
    return Obx(
      () {
        final hintText = controller.hintTextRx.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _NameField(),
            SizedBox(height: 24.0.scale),
            WidgetUtil.textWidget(
              hintText,
              size: 28.0.scale,
              color: EnumColor.textPrimary.color,
            ),
            SizedBox(height: 24.0.scale),
            _DropdownField(
              title: EnumLocale.createLevel1Category.tr,
              selectedValue: controller.selectedLevel1Rx.value?.name,
              visibleValues: controller.getLevel1NameList(),
              onValueSelected: (str) => controller.interactive(
                  EnumDialogCategoryCreateWidgetInteractive.tapLevel1Button,
                  data: str),
              onDelete: () => controller.interactive(
                  EnumDialogCategoryCreateWidgetInteractive
                      .tapClearLevel1Button),
            ),
            if (controller.selectedLevel1Rx.value != null) ...[
              SizedBox(height: 24.0.scale),
              _DropdownField(
                title: EnumLocale.createLevel2Category.tr,
                selectedValue: controller.selectedLevel2Rx.value?.name,
                visibleValues: controller.getLevel2NameList(),
                onValueSelected: (str) => controller.interactive(
                    EnumDialogCategoryCreateWidgetInteractive.tapLevel2Button,
                    data: str),
                onDelete: () => controller.interactive(
                    EnumDialogCategoryCreateWidgetInteractive
                        .tapClearLevel2Button),
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
  final VoidCallback onDelete;

  const _DropdownField({
    required this.title,
    required this.selectedValue,
    required this.visibleValues,
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
              selectedValue: selectedValue,
              values: visibleValues,
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
