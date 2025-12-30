import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_position/dialog_item_edit_position_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_position/dialog_item_edit_position_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class DialogItemEditPositionWidget extends StatelessWidget {
  final String itemId;
  final Future<bool> Function(List<DialogItemEditPositionOutputModel>) onConfirm;

  const DialogItemEditPositionWidget({
    super.key,
    required this.itemId,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogItemEditPositionWidgetController>(
      init: DialogItemEditPositionWidgetController(itemId),
      builder: (controller) {
        return DialogFrame(
          width: 1168.0.scale,
          header: DialogHeader(title: EnumLocale.editPosition.tr),
          footer: Obx(
            () {
              return DialogFooter(
                isLoading: controller.isLoadingRx.value,
                type: DialogFooterType.cancelAndConfirm,
                onCancel: () {
                  controller.interactive(
                    EnumDialogItemEditPositionWidgetInteractive.tapDialogCancelButton,
                    data: context,
                  );
                },
                onConfirm: () async {
                  controller.interactive(
                    EnumDialogItemEditPositionWidgetInteractive.tapDialogConfirmButton,
                    data: true,
                  );
                  final outputData = controller.checkOutputData();

                  if (outputData.isEmpty) {
                    controller.interactive(
                      EnumDialogItemEditPositionWidgetInteractive.tapDialogConfirmButton,
                      data: false,
                    );
                    return;
                  }

                  final isSuccess = await onConfirm(outputData);

                  if (isSuccess) {
                    controller.interactive(
                      EnumDialogItemEditPositionWidgetInteractive.tapDialogConfirmButton,
                      data: context,
                    );
                  }

                  controller.interactive(
                    EnumDialogItemEditPositionWidgetInteractive.tapDialogConfirmButton,
                    data: false,
                  );
                },
              );
            },
          ),
          child: _Body(),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemEditPositionWidgetController>();
    final positions = controller.getPositions;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoCard(),
        SizedBox(height: 24.0.scale),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < positions.length; i++) ...[
              _PositionEditCard(model: positions[i]),
              if (i < positions.length - 1) SizedBox(height: 32.0.scale),
            ],
          ],
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemEditPositionWidgetController>();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 32.0.scale,
        vertical: 44.0.scale,
      ),
      decoration: BoxDecoration(
        color: EnumColor.backgroundSecondary.color,
        borderRadius: BorderRadius.circular(20.0.scale),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(
            label: EnumLocale.createItemName.tr,
            value: controller.getItemName,
          ),
          SizedBox(height: 24.0.scale),
          _InfoRow(
            label: EnumLocale.warehouseCurrentQuantityLabel.tr,
            value: controller.getOriginQuantity,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 112.0.scale,
          child: WidgetUtil.textWidget(
            label,
            size: 28.0.scale,
            color: EnumColor.textSecondary.color,
          ),
        ),
        SizedBox(width: 24.0.scale),
        Expanded(
          child: WidgetUtil.textWidget(
            value,
            size: 28.0.scale,
          ),
        ),
      ],
    );
  }
}

class _PositionEditCard extends StatelessWidget {
  final DisplayPositionModel model;

  const _PositionEditCard({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1056.0.scale,
      padding: EdgeInsets.all(32.0.scale),
      decoration: BoxDecoration(
        color: EnumColor.backgroundDropdown.color,
        borderRadius: BorderRadius.circular(20.0.scale),
        boxShadow: [
          BoxShadow(
            color: EnumColor.shadowCard.color,
            blurRadius: 16.0.scale,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OriginalPositionInfo(model: model),
          SizedBox(height: 24.0.scale),
          _ChangeQuantitySection(model: model),
          SizedBox(height: 32.0.scale),
          _DropdownSection(model: model),
        ],
      ),
    );
  }
}

class _OriginalPositionInfo extends StatelessWidget {
  final DisplayPositionModel model;

  const _OriginalPositionInfo({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemEditPositionWidgetController>();
    return Row(
      children: [
        WidgetUtil.textWidget(
          controller.getPositionName(model),
          size: 28.0.scale,
          weightType: EnumFontWeightType.bold,
        ),
        SizedBox(width: 24.0.scale),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.scale),
          decoration: BoxDecoration(
            color: EnumColor.accentBlue.color,
            borderRadius: BorderRadius.circular(12.0.scale),
          ),
          child: WidgetUtil.textWidget(
            model.quantity.toString(),
            size: 28.0.scale,
            color: EnumColor.textWhite.color,
          ),
        ),
      ],
    );
  }
}

class _ChangeQuantitySection extends StatelessWidget {
  final DisplayPositionModel model;

  const _ChangeQuantitySection({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemEditPositionWidgetController>();
    final textController = controller.getQuantityControllers[model.index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetUtil.textWidget(
          EnumLocale.warehouseMoveQuantity.tr,
          size: 26.0.scale,
          color: EnumColor.textSecondary.color,
        ),
        SizedBox(height: 12.0.scale),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _QuantityButton(
              eImage: EnumImage.cMinus,
              textController: textController,
            ),
            SizedBox(width: 16.0.scale),
            SizedBox(
              width: 180.0.scale,
              height: 70.0.scale,
              child: WidgetUtil.textField(
                controller: textController,
                textFieldType: EnumTextFieldType.integer,
                maxLength: 7,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: 16.0.scale),
            _QuantityButton(
              eImage: EnumImage.cPlus,
              textController: textController,
            ),
          ],
        ),
      ],
    );
  }
}

/// 數量按鈕
class _QuantityButton extends StatelessWidget {
  final EnumImage eImage;
  final TextEditingController textController;

  const _QuantityButton({
    required this.eImage,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemEditPositionWidgetController>();
    return Material(
      color: EnumColor.backgroundDropdown.color,
      borderRadius: BorderRadius.circular(16.0.scale),
      child: InkWell(
        onTap: () {
          controller.interactive(
            (eImage == EnumImage.cPlus)
                ? EnumDialogItemEditPositionWidgetInteractive.tapIncrementQuantity
                : EnumDialogItemEditPositionWidgetInteractive.tapDecrementQuantity,
            data: textController,
          );
        },
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

class _DropdownSection extends StatelessWidget {
  final DisplayPositionModel model;

  const _DropdownSection({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemEditPositionWidgetController>();
    return Obx(
      () {
        final changeRooms = controller.changeRoomsRx.value;
        final changeCabinets = controller.changeCabinetsRx.value;
        final selectedRoomName = changeRooms[model.index].name!;
        final selectedCabinetName = changeCabinets[model.index].name!;

        return Row(
          children: [
            Expanded(
              child: _ChangePositionField(
                title: EnumLocale.warehouseChangeRoom.tr,
                values: controller.getRoomNameList(),
                selectedValue: selectedRoomName,
                onValueSelected: (str) {
                  final room = controller.getRoomByName(str);
                  if (room != null) {
                    controller.interactive(
                      EnumDialogItemEditPositionWidgetInteractive.tapUpdateRoom,
                      data: UpdatePositionModel(
                        index: model.index,
                        position: room,
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(width: 32.0.scale),
            Expanded(
              child: _ChangePositionField(
                title: EnumLocale.warehouseChangeCabinet.tr,
                values: controller.getVisibleCabinetNameList(selectedRoomName),
                selectedValue: selectedCabinetName,
                onValueSelected: (str) {
                  final cabinet = controller.getCabinetByName(str);
                  if (cabinet != null) {
                    controller.interactive(
                      EnumDialogItemEditPositionWidgetInteractive.tapUpdateCabinet,
                      data: UpdatePositionModel(
                        index: model.index,
                        position: cabinet,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ChangePositionField extends StatelessWidget {
  final String title;
  final List<String> values;
  final String selectedValue;
  final Function(String?) onValueSelected;

  const _ChangePositionField({
    required this.title,
    required this.values,
    required this.selectedValue,
    required this.onValueSelected,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemEditPositionWidgetController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetUtil.textWidget(
          title,
          size: 26.0.scale,
          color: EnumColor.textSecondary.color,
        ),
        SizedBox(height: 12.0.scale),
        WidgetUtil.textDropdownButton(
          selectedValue: selectedValue,
          values: values,
          onValueSelected: onValueSelected,
          onMenuOpened: () => controller.interactive(
            EnumDialogItemEditPositionWidgetInteractive.tapDropdownButton,
          ),
        ),
      ],
    );
  }
}
