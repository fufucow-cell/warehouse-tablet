import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_edit/dialog_cabinet_edit_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_edit/dialog_cabinet_edit_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/actions.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog_section_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class DialogCabinetEditWidget extends StatelessWidget {
  final Future<bool> Function(DialogCabinetEditOutputModel) onConfirm;
  final Cabinet cabinet;

  const DialogCabinetEditWidget({
    super.key,
    required this.onConfirm,
    required this.cabinet,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogCabinetEditWidgetController>(
      init: DialogCabinetEditWidgetController(cabinet),
      builder: (controller) {
        return DialogFrame(
          width: 720.0.scale,
          minHeight: 625.0.scale,
          header: DialogHeader(title: EnumLocale.editCabinetTitle.tr),
          footer: Obx(
            () {
              final isLoading = controller.isLoadingRx.value;
              return DialogFooter(
                type: DialogFooterType.cancelAndConfirm,
                isLoading: isLoading,
                onCancel: () {
                  controller.interactive(
                    EnumDialogCabinetEditWidgetInteractive.tapDialogCancelButton,
                    data: context,
                  );
                },
                onConfirm: () async {
                  final outputModel = await controller.checkOutputModel();

                  if (outputModel == null) {
                    return;
                  }

                  controller.interactive(
                    EnumDialogCabinetEditWidgetInteractive.tapDialogConfirmButton,
                    data: true,
                  );
                  final isSuccess = await onConfirm(outputModel);

                  if (isSuccess) {
                    controller.interactive(
                      EnumDialogCabinetEditWidgetInteractive.tapDialogConfirmButton,
                      data: context,
                    );
                  }

                  controller.interactive(
                    EnumDialogCabinetEditWidgetInteractive.tapDialogConfirmButton,
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
    final controller = Get.find<DialogCabinetEditWidgetController>();
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _NameField(),
            SizedBox(height: 24.0.scale),
            _RoomField(
              selectedValue: controller.selectedRoomIdRx.value != null
                  ? controller.getRoomNameList().firstWhereOrNull(
                        (name) => controller.getRoomIdByName(name) == controller.selectedRoomIdRx.value,
                      )
                  : null,
              visibleValues: controller.getRoomNameList(),
              onValueSelected: (str) => controller.interactive(EnumDialogCabinetEditWidgetInteractive.tapRoomButton, data: str),
              onDelete: () => controller.interactive(EnumDialogCabinetEditWidgetInteractive.tapDeleteRoomButton),
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
    final controller = Get.find<DialogCabinetEditWidgetController>();
    return DialogSectionWidget(
      isRequired: true,
      title: EnumLocale.createCabinetName.tr,
      child: WidgetUtil.textField(
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
  final VoidCallback onDelete;

  const _RoomField({
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
            isRequired: true,
            title: EnumLocale.createCabinetRoom.tr,
            child: WidgetUtil.textDropdownButton(
              selectedValue: selectedValue,
              values: visibleValues,
              buttonTextColor: selectedValue == null ? EnumColor.textSecondary.color : null,
              menuMaxHeight: 290.0.scale,
              onValueSelected: onValueSelected,
            ),
          ),
        ),
        if (selectedValue != null && selectedValue != EnumLocale.optionPleaseSelect.tr) ...[
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
