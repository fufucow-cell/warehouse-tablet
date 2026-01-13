import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog_item_create/dialog_item_create_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog_item_create/dialog_item_create_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/cust_text_field.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/cust_dropdown_menu_button.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/cust_shimmer_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog_section_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog_with_photo_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog_without_photo_widget.dart';
import 'package:get/get.dart';

class DialogItemCreateWidget extends StatelessWidget {
  final Future<bool> Function(DialogItemCreateOutputModel) onConfirm;

  const DialogItemCreateWidget({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogItemCreateWidgetController>(
      init: DialogItemCreateWidgetController(),
      builder: (controller) {
        return Obx(
          () {
            final isLoading = controller.isLoadingRx.value;
            final isRecognizing = controller.isRecognizingRx.value;

            return AbsorbPointer(
              absorbing: isRecognizing,
              child: DialogFrame(
                width: 962.0.scale,
                minHeight: 1024.0.scale,
                header: DialogHeader(title: EnumLocale.createItem.tr),
                footer: DialogFooter(
                  type: DialogFooterType.cancelAndConfirm,
                  isLoading: isLoading,
                  onCancel: isRecognizing
                      ? null
                      : () {
                          controller.interactive(
                            EnumDialogItemCreateWidgetInteractive.tapDialogCancelButton,
                            data: context,
                          );
                        },
                  onConfirm: isRecognizing
                      ? null
                      : () async {
                          controller.interactive(
                            EnumDialogItemCreateWidgetInteractive.tapDialogConfirmButton,
                            data: true,
                          );
                          final outputModel = await controller.checkOutputModel();

                          if (outputModel == null) {
                            controller.interactive(
                              EnumDialogItemCreateWidgetInteractive.tapDialogConfirmButton,
                              data: false,
                            );
                            return;
                          }

                          final isSuccess = await onConfirm(outputModel);

                          controller.interactive(
                            EnumDialogItemCreateWidgetInteractive.tapDialogConfirmButton,
                            data: isSuccess ? context : false,
                          );
                        },
                ),
                child: const _Body(),
              ),
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
    final controller = Get.find<DialogItemCreateWidgetController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SmartAddButton(),
        SizedBox(height: 24.0.scale),
        _PhotoSection(),
        SizedBox(height: 24.0.scale),
        const _NameField(),
        SizedBox(height: 24.0.scale),
        const _DescriptionField(),
        SizedBox(height: 24.0.scale),
        Row(
          children: [
            const Expanded(
              child: _QuantityField(),
            ),
            SizedBox(width: 24.0.scale),
            const Expanded(
              child: _MinStockAlertField(),
            ),
          ],
        ),
        SizedBox(height: 24.0.scale),
        Row(
          children: [
            Expanded(
              child: Obx(
                () => _DropdownField(
                  title: EnumLocale.room.tr,
                  selectedValue: controller.selectedRoomRx.value?.name,
                  visibleValues: controller.getRoomNameList(),
                  onValueSelected: (str) => controller.interactive(
                    EnumDialogItemCreateWidgetInteractive.tapRoom,
                    data: str,
                  ),
                ),
              ),
            ),
            SizedBox(width: 24.0.scale),
            Expanded(
              child: Obx(
                () => _DropdownField(
                  title: EnumLocale.cabinet.tr,
                  selectedValue: controller.selectedCabinetRx.value?.name,
                  visibleValues: controller.getVisibleCabinetNameList(),
                  onValueSelected: (str) => controller.interactive(
                    EnumDialogItemCreateWidgetInteractive.tapCabinet,
                    data: str,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.0.scale),
        Obx(
          () {
            final controller = Get.find<DialogItemCreateWidgetController>();
            final selectedLevel1 = controller.selectedCategoryLevel1Rx.value;
            final selectedLevel2 = controller.selectedCategoryLevel2Rx.value;
            final selectedLevel3 = controller.selectedCategoryLevel3Rx.value;
            final visibleLevel1 = controller.visibleCategoryLevel1Rx.value;
            final visibleLevel2 = controller.visibleCategoryLevel2Rx.value;
            final visibleLevel3 = controller.visibleCategoryLevel3Rx.value;

            return Column(
              children: [
                _DropdownField(
                  title: selectedLevel1 == null ? EnumLocale.category.tr : EnumLocale.createLevel1Category.tr,
                  selectedValue: selectedLevel1?.name,
                  visibleValues: visibleLevel1.map((e) => e.name ?? '').toList(),
                  onValueSelected: (str) => controller.interactive(
                    EnumDialogItemCreateWidgetInteractive.tapCategoryLevel1,
                    data: str,
                  ),
                ),
                if (selectedLevel1 != null) ...[
                  SizedBox(height: 24.0.scale),
                  _DropdownField(
                    title: EnumLocale.createLevel2Category.tr,
                    selectedValue: selectedLevel2?.name,
                    visibleValues: visibleLevel2.map((cat) => cat.name ?? '').toList(),
                    onValueSelected: (str) => controller.interactive(
                      EnumDialogItemCreateWidgetInteractive.tapCategoryLevel2,
                      data: str,
                    ),
                  ),
                ],
                if (selectedLevel2 != null) ...[
                  SizedBox(height: 24.0.scale),
                  _DropdownField(
                    title: EnumLocale.createLevel3Category.tr,
                    selectedValue: selectedLevel3?.name,
                    visibleValues: visibleLevel3.map((cat) => cat.name ?? '').toList(),
                    onValueSelected: (str) => controller.interactive(
                      EnumDialogItemCreateWidgetInteractive.tapCategoryLevel3,
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

class _SmartAddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemCreateWidgetController>();

    return OutlinedButton(
      onPressed: () => controller.interactive(EnumDialogItemCreateWidgetInteractive.tapSmartAddButton),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 16.0.scale,
        ),
        backgroundColor: EnumColor.backgroundAccentBlue.color,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0.scale),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EnumImage.cCamera.image(size: Size.square(38.0.scale)),
          SizedBox(width: 16.0.scale),
          CustTextWidget(
            EnumLocale.createSmartAddItem.tr,
            size: 28.0.scale,
            color: EnumColor.accentBlue.color,
          ),
        ],
      ),
    );
  }
}

class _PhotoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemCreateWidgetController>();
    return Obx(
      () {
        final hasPhoto = controller.filePathRx.value != null;
        final imageWidget = hasPhoto
            ? controller.convertFileToImage(
                controller.filePathRx.value!,
                fitHeight: 200.0.scale,
              )
            : null;

        if (imageWidget != null) {
          return DialogWithPhotoWidget(
            imageWidget: imageWidget,
            onReplacePhoto: () => controller.interactive(
              EnumDialogItemCreateWidgetInteractive.replacePhoto,
            ),
            onDeletePhoto: () => controller.interactive(EnumDialogItemCreateWidgetInteractive.deletePhoto),
          );
        } else {
          return DialogWithoutPhotoWidget(
            onTap: () => controller.interactive(EnumDialogItemCreateWidgetInteractive.tapPhoto),
          );
        }
      },
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemCreateWidgetController>();
    return Obx(
      () {
        final isRecognizing = controller.isRecognizingRx.value;
        return DialogSectionWidget(
          isRequired: true,
          title: EnumLocale.createItemName.tr,
          child: isRecognizing
              ? ShimmerTextWidget(
                  '${EnumLocale.warehouseImageRecognizing.tr}...',
                )
              : CustTextField(
                  controller: controller.nameController,
                  maxLength: 100,
                ),
        );
      },
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemCreateWidgetController>();
    return Obx(
      () {
        final isRecognizing = controller.isRecognizingRx.value;
        return DialogSectionWidget(
          title: EnumLocale.warehouseDescriptionLabel.tr,
          child: isRecognizing
              ? ShimmerTextWidget(
                  '${EnumLocale.warehouseImageRecognizing.tr}...',
                )
              : CustTextField(
                  height: 197.0.scale,
                  controller: controller.descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLength: 200,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                ),
        );
      },
    );
  }
}

class _QuantityField extends StatelessWidget {
  const _QuantityField();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemCreateWidgetController>();
    return DialogSectionWidget(
      title: EnumLocale.quantity.tr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QuantityButton(
            eImage: EnumImage.cMinus,
            onPressed: () => controller.interactive(
              EnumDialogItemCreateWidgetInteractive.decrementQuantity,
            ),
          ),
          SizedBox(width: 16.0.scale),
          Expanded(
            child: CustTextField(
              controller: controller.quantityController,
              textFieldType: EnumTextFieldType.integer,
              maxLength: 7,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 16.0.scale),
          _QuantityButton(
            eImage: EnumImage.cPlus,
            onPressed: () => controller.interactive(
              EnumDialogItemCreateWidgetInteractive.incrementQuantity,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final EnumImage eImage;
  final VoidCallback onPressed;

  const _QuantityButton({
    required this.eImage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: EnumColor.backgroundPrimary.color,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16.0.scale),
        child: Container(
          width: 70.0.scale,
          height: 70.0.scale,
          padding: EdgeInsets.all(15.0.scale),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0.scale,
              color: EnumColor.lineBorder.color,
            ),
            borderRadius: BorderRadius.circular(16.0.scale),
          ),
          child: eImage.image(
            size: Size.square(40.0.scale),
            color: EnumColor.iconSecondary.color,
          ),
        ),
      ),
    );
  }
}

class _MinStockAlertField extends StatelessWidget {
  const _MinStockAlertField();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemCreateWidgetController>();
    return DialogSectionWidget(
      title: EnumLocale.createMinStockAlert.tr,
      child: CustTextField(
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
    final controller = Get.find<DialogItemCreateWidgetController>();
    return DialogSectionWidget(
      title: title,
      child: CustTextDropdownButton(
        selectedValue: selectedValue,
        values: visibleValues,
        buttonTextColor: selectedValue == null ? EnumColor.textSecondary.color : null,
        menuMaxHeight: 290.0.scale,
        onValueSelected: onValueSelected,
        onMenuOpened: () => controller.interactive(
          EnumDialogItemCreateWidgetInteractive.tapDropdownButton,
        ),
      ),
    );
  }
}
