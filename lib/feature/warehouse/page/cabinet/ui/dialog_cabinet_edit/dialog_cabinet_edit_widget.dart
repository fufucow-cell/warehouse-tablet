import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_edit/dialog_cabinet_edit_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_edit/dialog_cabinet_edit_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog_section_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

class DialogCabinetEditWidget extends StatelessWidget {
  final Future<bool> Function(List<DialogCabinetEditOutputModel>) onConfirm;
  final RoomCabinetInfo room;

  const DialogCabinetEditWidget({
    super.key,
    required this.onConfirm,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogCabinetEditWidgetController>(
      init: DialogCabinetEditWidgetController(room),
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
                  await controller.handleConfirm(onConfirm, context);
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CurrentField(),
        SizedBox(height: 24.0.scale),
        _CabinetListField(),
      ],
    );
  }
}

class _CurrentField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogCabinetEditWidgetController>();
    return DialogSectionWidget(
      title: EnumLocale.editCabinetRoomName.tr,
      child: WidgetUtil.textField(
        controller: TextEditingController(text: controller.getRoom.roomName),
        isReadOnly: true,
      ),
    );
  }
}

class _CabinetListField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogCabinetEditWidgetController>();
    return Obx(
      () {
        final editModels = controller.editModelsRx.value;
        if (editModels.isEmpty) {
          return const SizedBox.shrink();
        }
        return CustomScrollView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final model = editModels[index];
                  return Column(
                    children: [
                      _CabinetField(editModel: model),
                      if (index < editModels.length - 1) SizedBox(height: 12.0.scale),
                    ],
                  );
                },
                childCount: editModels.length,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CabinetField extends StatelessWidget {
  final EditModel editModel;

  const _CabinetField({
    required this.editModel,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogCabinetEditWidgetController>();
    final isExpanded = editModel.isExpanded;
    final isDelete = editModel.isDelete;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DialogSectionWidget(
                title: editModel.oldCabinet.name ?? '',
                isRequired: true,
                child: WidgetUtil.textField(
                  textColor: isDelete ? EnumColor.textSecondary.color : null,
                  isReadOnly: isDelete,
                  controller: isDelete
                      ? TextEditingController(
                          text: EnumLocale.editCabinetWillDelete.tr,
                        )
                      : editModel.textController,
                ),
              ),
            ),
            SizedBox(width: 12.0.scale),
            _ActionTool(editModel: editModel),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isExpanded
              ? Column(
                  children: [
                    SizedBox(height: 12.0.scale),
                    DialogSectionWidget(
                      title: EnumLocale.editCabinetMoveToNewRoom.tr,
                      child: WidgetUtil.textDropdownButton(
                        selectedValue: editModel.newRoom?.name,
                        values: controller.getRoomNameList(
                          isExcludeOldRoomName: true,
                        ),
                        onValueSelected: (value) => controller.interactive(
                          EnumDialogCabinetEditWidgetInteractive.tapRoomButton,
                          data: ChangeRoomModel(
                            editModel: editModel,
                            newRoomName: value,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _ActionTool extends StatelessWidget {
  final EditModel editModel;

  const _ActionTool({
    required this.editModel,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogCabinetEditWidgetController>();
    final isExpanded = editModel.isExpanded;
    final isDelete = editModel.isDelete;
    return Row(
      children: [
        _ActionButton(
          eImage: isExpanded ? EnumImage.cArrowUp2 : EnumImage.cArrowDown2,
          onTap: () => controller.interactive(
            EnumDialogCabinetEditWidgetInteractive.tapExpandButton,
            data: editModel,
          ),
        ),
        SizedBox(width: 12.0.scale),
        _ActionButton(
          eImage: isDelete ? EnumImage.cRecover : EnumImage.cTrash3,
          onTap: () => controller.interactive(
            EnumDialogCabinetEditWidgetInteractive.tapDeleteButton,
            data: editModel,
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
    return Padding(
      padding: EdgeInsets.only(top: 50.0.scale),
      child: Material(
        color: EnumColor.backgroundPrimary.color,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.0.scale),
          child: Ink(
            child: Container(
              padding: EdgeInsets.all(
                15.0.scale,
              ),
              width: 70.0.scale,
              height: 70.0.scale,
              child: eImage.image(
                color: EnumColor.iconSecondary.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
