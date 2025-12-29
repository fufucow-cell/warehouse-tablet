import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_normal_edit/dialog_item_normal_edit_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_normal_edit/dialog_item_normal_edit_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog_section_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog_with_photo_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog_without_photo_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class DialogItemNormalEditWidget extends StatelessWidget {
  final String itemId;
  final Future<bool> Function(DialogItemNormalEditOutputModel) onConfirm;

  const DialogItemNormalEditWidget({
    super.key,
    required this.itemId,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogItemNormalEditWidgetController>(
      init: DialogItemNormalEditWidgetController(itemId),
      builder: (controller) {
        return Obx(
          () {
            final isLoading = controller.isLoadingRx.value;

            return DialogFrame(
              width: 962.0.scale,
              minHeight: 1024.0.scale,
              header: DialogHeader(title: EnumLocale.createItemTitle.tr),
              footer: Obx(
                () {
                  return DialogFooter(
                    isLoading: controller.isLoadingRx.value,
                    type: DialogFooterType.cancelAndConfirm,
                    onCancel: () {
                      controller.interactive(
                        EnumDialogItemNormalEditWidgetInteractive
                            .tapDialogCancelButton,
                        data: context,
                      );
                    },
                    onConfirm: () async {
                      controller.interactive(
                          EnumDialogItemNormalEditWidgetInteractive
                              .tapDialogConfirmButton,
                          data: true);
                      final outputModel = await controller.checkOutputModel();

                      if (outputModel == null) {
                        controller.interactive(
                            EnumDialogItemNormalEditWidgetInteractive
                                .tapDialogConfirmButton,
                            data: false);
                        return;
                      }

                      final isSuccess = await onConfirm(outputModel);

                      if (isSuccess) {
                        controller.interactive(
                            EnumDialogItemNormalEditWidgetInteractive
                                .tapDialogConfirmButton,
                            data: context);
                      }

                      controller.interactive(
                          EnumDialogItemNormalEditWidgetInteractive
                              .tapDialogConfirmButton,
                          data: false);
                    },
                  );
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
    final controller = Get.find<DialogItemNormalEditWidgetController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PhotoSection(),
        SizedBox(height: 24.0.scale),
        const _NameField(),
        SizedBox(height: 24.0.scale),
        const _DescriptionField(),
        SizedBox(height: 24.0.scale),
        const _MinStockAlertField(),
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
                      ? EnumLocale.warehouseCategory.tr
                      : EnumLocale.createLevel1Category.tr,
                  selectedValue: selectedLevel1?.name,
                  visibleValues:
                      visibleLevel1.map((e) => e.name ?? '').toList(),
                  onValueSelected: (str) => controller.interactive(
                      EnumDialogItemNormalEditWidgetInteractive
                          .tapCategoryLevel1,
                      data: str),
                ),
                if (selectedLevel1 != null) ...[
                  SizedBox(height: 24.0.scale),
                  _DropdownField(
                    title: EnumLocale.createLevel2Category.tr,
                    selectedValue: selectedLevel2?.name,
                    visibleValues:
                        visibleLevel2.map((cat) => cat.name ?? '').toList(),
                    onValueSelected: (str) => controller.interactive(
                        EnumDialogItemNormalEditWidgetInteractive
                            .tapCategoryLevel2,
                        data: str),
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
                        EnumDialogItemNormalEditWidgetInteractive
                            .tapCategoryLevel3,
                        data: str),
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

class _PhotoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemNormalEditWidgetController>();
    return Obx(
      () {
        final filePath = controller.filePathRx.value;
        final photoUrl = controller.photoUrlRx.value;
        final hasPhoto =
            (photoUrl?.isNotEmpty ?? false) || (filePath?.isNotEmpty ?? false);

        if (hasPhoto) {
          Widget? imageWidget;

          if (filePath?.isNotEmpty ?? false) {
            imageWidget = controller.convertFileToImage;
          } else if (photoUrl?.isNotEmpty ?? false) {
            imageWidget = WidgetUtil.networkImage(
              url: photoUrl!,
              height: 200.0.scale,
            );
          }

          if (imageWidget != null) {
            return DialogWithPhotoWidget(
              imageWidget: imageWidget,
              onReplacePhoto: () => controller.interactive(
                  EnumDialogItemNormalEditWidgetInteractive.replacePhoto),
              onDeletePhoto: () => controller.interactive(
                  EnumDialogItemNormalEditWidgetInteractive.deletePhoto),
            );
          }
        }

        return DialogWithoutPhotoWidget(
            onTap: () => controller.interactive(
                EnumDialogItemNormalEditWidgetInteractive.tapPhoto));
      },
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemNormalEditWidgetController>();
    return DialogSectionWidget(
      isRequired: true,
      title: EnumLocale.createItemName.tr,
      child: WidgetUtil.textField(
        controller: controller.nameController,
        maxLength: 100,
      ),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemNormalEditWidgetController>();
    return DialogSectionWidget(
      title: EnumLocale.warehouseDescriptionLabel.tr,
      child: WidgetUtil.textField(
        height: 197.0.scale,
        controller: controller.descriptionController,
        keyboardType: TextInputType.multiline,
        maxLength: 200,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
      ),
    );
  }
}

class _MinStockAlertField extends StatelessWidget {
  const _MinStockAlertField();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemNormalEditWidgetController>();
    return DialogSectionWidget(
      title: EnumLocale.createMinStockAlert.tr,
      child: WidgetUtil.textField(
        controller: controller.minStockAlertController,
        textFieldType: EnumTextFieldType.integer,
        maxLength: 7,
        keyboardType: TextInputType.number,
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
    final controller = Get.find<DialogItemNormalEditWidgetController>();
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
            EnumDialogItemNormalEditWidgetInteractive.tapDropdownButton),
      ),
    );
  }
}
