import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_create/dialog_cabinet_create_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_create/dialog_cabinet_create_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog_section_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/cust_text_field.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/cust_dropdown_menu_button.dart';
import 'package:get/get.dart';

class DialogCabinetCreateWidget extends StatelessWidget {
  final Future<bool> Function(DialogCabinetCreateOutputModel) onConfirm;

  const DialogCabinetCreateWidget({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogCabinetCreateWidgetController>(
      init: DialogCabinetCreateWidgetController(),
      builder: (controller) {
        return DialogFrame(
          width: 720.0.scale,
          minHeight: 346.0.scale,
          header: DialogHeader(title: EnumLocale.warehouseTagTypeCreateCabinet.tr),
          footer: Obx(
            () {
              final isLoading = controller.isLoadingRx.value;
              return DialogFooter(
                type: DialogFooterType.cancelAndConfirm,
                isLoading: isLoading,
                onCancel: () {
                  controller.interactive(
                    EnumDialogCabinetCreateWidgetInteractive.tapDialogCancelButton,
                    data: context,
                  );
                },
                onConfirm: () async {
                  final outputModel = await controller.checkOutputModel();

                  if (outputModel == null) {
                    return;
                  }

                  controller.interactive(
                    EnumDialogCabinetCreateWidgetInteractive.tapDialogConfirmButton,
                    data: true,
                  );
                  final isSuccess = await onConfirm(outputModel);

                  if (isSuccess) {
                    controller.interactive(
                      EnumDialogCabinetCreateWidgetInteractive.tapDialogConfirmButton,
                      data: context,
                    );
                  }

                  controller.interactive(
                    EnumDialogCabinetCreateWidgetInteractive.tapDialogConfirmButton,
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
    final controller = Get.find<DialogCabinetCreateWidgetController>();
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _NameField(),
            SizedBox(height: 24.0.scale),
            _RoomField(
              selectedValue: controller.selectedRoomRx.value?.name,
              visibleValues: controller.getRoomNameList(),
              onValueSelected: (str) => controller.interactive(
                EnumDialogCabinetCreateWidgetInteractive.tapRoomButton,
                data: str,
              ),
            ),
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
    final controller = Get.find<DialogCabinetCreateWidgetController>();
    return DialogSectionWidget(
      isRequired: true,
      title: EnumLocale.createCabinetName.tr,
      child: CustTextField(
        controller: controller.nameController,
        maxLength: 100,
      ),
    );
  }
}

class _RoomField extends StatelessWidget {
  final String? selectedValue;
  final List<String> visibleValues;
  final Function(String?) onValueSelected;

  const _RoomField({
    required this.selectedValue,
    required this.visibleValues,
    required this.onValueSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DialogSectionWidget(
      title: EnumLocale.room.tr,
      child: CustTextDropdownButton(
        selectedValue: selectedValue,
        values: visibleValues,
        buttonTextColor: selectedValue == null ? EnumColor.textSecondary.color : null,
        menuMaxHeight: 290.0.scale,
        onValueSelected: onValueSelected,
      ),
    );
  }
}
