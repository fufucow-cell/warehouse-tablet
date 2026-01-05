import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_quantity/dialog_item_edit_quantity_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_quantity/dialog_item_edit_quantity_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/item_info_card.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

class DialogItemEditQuantityWidget extends StatelessWidget {
  final Future<bool> Function(List<DialogItemEditQuantityOutputModel>) onConfirm;
  final String itemId;

  const DialogItemEditQuantityWidget({
    super.key,
    required this.itemId,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogItemEditQuantityWidgetController>(
      init: DialogItemEditQuantityWidgetController(itemId),
      builder: (controller) {
        return DialogFrame(
          width: 1168.0.scale,
          header: DialogHeader(title: EnumLocale.warehouseTagTypeUpdateQuantity.tr),
          footer: Obx(
            () {
              return DialogFooter(
                isLoading: controller.isLoadingRx.value,
                type: DialogFooterType.cancelAndConfirm,
                onCancel: () {
                  controller.interactive(
                    EnumDialogItemEditQuantityWidgetInteractive.tapDialogCancelButton,
                    data: context,
                  );
                },
                onConfirm: () async {
                  controller.interactive(
                    EnumDialogItemEditQuantityWidgetInteractive.tapDialogConfirmButton,
                    data: true,
                  );
                  final outputData = controller.checkOutputData();

                  if (outputData == null) {
                    controller.interactive(
                      EnumDialogItemEditQuantityWidgetInteractive.tapDialogConfirmButton,
                      data: false,
                    );
                    return;
                  }

                  if (outputData.isEmpty) {
                    controller.interactive(
                      EnumDialogItemEditQuantityWidgetInteractive.tapDialogConfirmButton,
                      data: false,
                    );
                    return;
                  }

                  final isSuccess = await onConfirm(outputData);

                  if (isSuccess) {
                    controller.interactive(
                      EnumDialogItemEditQuantityWidgetInteractive.tapDialogConfirmButton,
                      data: context,
                    );
                  }

                  controller.interactive(
                    EnumDialogItemEditQuantityWidgetInteractive.tapDialogConfirmButton,
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
    final controller = Get.find<DialogItemEditQuantityWidgetController>();
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemInfoCard(
              itemName: controller.getItemName,
              count: controller.getOldQuantity,
              isHistory: false,
            ),
            SizedBox(height: 24.0.scale),
            _PositionInfo(),
            SizedBox(height: 24.0.scale),
            _PositionCard(
              oldDisplayList: controller.getOldDisplayPositionList,
            ),
            SizedBox(height: 24.0.scale),
            _PositionCard(
              newDisplayList: controller.getNewDisplayPositionList,
            ),
          ],
        );
      },
    );
  }
}

/// 位置資訊
class _PositionInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemEditQuantityWidgetController>();
    return Row(
      children: [
        WidgetUtil.textWidget(
          EnumLocale.warehouseTotalQuantityAfterAdjustment.tr,
          size: 28.0.scale,
        ),
        SizedBox(width: 24.0.scale),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.scale),
          decoration: BoxDecoration(
            color: EnumColor.accentBlue.color,
            borderRadius: BorderRadius.circular(12.0.scale),
          ),
          child: Obx(
            () {
              return WidgetUtil.textWidget(
                controller.newQuantityRx.value.toString(),
                size: 28.0.scale,
                color: EnumColor.textWhite.color,
              );
            },
          ),
        ),
        SizedBox(width: 24.0.scale),
        const Spacer(),
        Obx(
          () {
            final maxCount = controller.getMaxNewPositions;
            final newCount = controller.newPositionsRx.value.length;
            final isEnabled = newCount < maxCount;
            return OutlinedButton(
              onPressed: () {
                if (isEnabled) {
                  controller.interactive(
                    EnumDialogItemEditQuantityWidgetInteractive.tapAddNewPostion,
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0.scale,
                  vertical: 16.0.scale,
                ),
                backgroundColor: EnumColor.backgroundAccentBlue.color,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0.scale),
                ),
              ),
              child: (!isEnabled)
                  ? WidgetUtil.textWidget(
                      EnumLocale.warehouseMaxNewPositionsReached.tr,
                      size: 28.0.scale,
                      color: EnumColor.accentBlue.color,
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        EnumImage.cPlus.image(
                          size: Size.square(40.0.scale),
                          color: EnumColor.accentBlue.color,
                        ),
                        SizedBox(width: 3.0.scale),
                        WidgetUtil.textWidget(
                          EnumLocale.warehouseAddStorageLocation.tr,
                          size: 28.0.scale,
                          color: EnumColor.accentBlue.color,
                        ),
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }
}

/// 位置外匡卡片
class _PositionCard extends StatelessWidget {
  final List<DisplayPositionModel>? oldDisplayList;
  final List<DisplayPositionModel>? newDisplayList;

  const _PositionCard({
    this.oldDisplayList,
    this.newDisplayList,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemEditQuantityWidgetController>();
    final displayList = oldDisplayList ?? newDisplayList;
    final isOld = oldDisplayList != null;

    if (displayList?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }

    return Container(
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: displayList!.asMap().entries.expand((entry) {
          final index = entry.key;
          final model = entry.value;
          final isLast = index == displayList.length - 1;
          TextEditingController? textController;

          if (isOld) {
            if (index < controller.quantityControllers.length) {
              textController = controller.quantityControllers[index];
            }
          } else {
            final newIndex = index + controller.getOldDisplayPositionList.length;
            if (newIndex < controller.quantityControllers.length) {
              textController = controller.quantityControllers[newIndex];
            }
          }

          final divider = Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0.scale),
            child: Divider(
              height: 1.0.scale,
              thickness: 1.0.scale,
              color: EnumColor.lineDividerLight.color,
            ),
          );

          return isOld
              ? [
                  _OldPositionItem(
                    model: model,
                    textController: textController!,
                  ),
                  if (!isLast) divider,
                ]
              : [
                  _NewPositionItem(
                    model: model,
                    textController: textController!,
                    index: index,
                  ),
                  if (!isLast) divider,
                ];
        }).toList(),
      ),
    );
  }
}

/// 舊位置項目
class _OldPositionItem extends StatelessWidget {
  final DisplayPositionModel model;
  final TextEditingController textController;

  const _OldPositionItem({
    required this.model,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    final locationName = '${model.roomName} → ${model.cabinetName}';

    return Row(
      children: [
        WidgetUtil.textWidget(
          locationName,
          size: 28.0.scale,
        ),
        SizedBox(width: 64.0.scale),
        const Spacer(),
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

/// 新增位置項目
class _NewPositionItem extends StatelessWidget {
  final DisplayPositionModel model;
  final TextEditingController textController;
  final int index;

  const _NewPositionItem({
    required this.model,
    required this.textController,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemEditQuantityWidgetController>();
    DisplayPositionModel? displayModel;

    if (index < controller.newPositionsRx.value.length) {
      displayModel = controller.getNewDisplayPositionList[index];
    }

    final roomNames = controller.getRoomNameList();
    final visibleCabinetNames = controller.getVisibleCabinetNameList(displayModel?.roomName);

    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: WidgetUtil.textDropdownButton(
              selectedValue: model.roomName,
              values: roomNames,
              menuMaxHeight: 290.0.scale,
              onValueSelected: (str) {
                final room = controller.getRoomByName(str);
                if (str != null && room != null) {
                  controller.interactive(
                    EnumDialogItemEditQuantityWidgetInteractive.tapUpdateNewPositionRoom,
                    data: UpdatePositionModel(
                      index: index,
                      position: WarehouseNameIdModel(id: room.roomId, name: room.roomName),
                    ),
                  );
                }
              },
              onMenuOpened: () => controller.interactive(
                EnumDialogItemEditQuantityWidgetInteractive.tapDropdownButton,
              ),
            ),
          ),
          SizedBox(width: 32.0.scale),
          Expanded(
            child: WidgetUtil.textDropdownButton(
              selectedValue: model.cabinetName,
              values: visibleCabinetNames,
              menuMaxHeight: 290.0.scale,
              onValueSelected: (str) {
                final cabinet = controller.getCabinetByName(str);
                if (str != null && cabinet != null) {
                  controller.interactive(
                    EnumDialogItemEditQuantityWidgetInteractive.tapUpdateNewPositionCabinet,
                    data: UpdatePositionModel(
                      index: index,
                      position: WarehouseNameIdModel(id: cabinet.cabinetId, name: cabinet.cabinetName),
                    ),
                  );
                }
              },
              onMenuOpened: () => controller.interactive(
                EnumDialogItemEditQuantityWidgetInteractive.tapDropdownButton,
              ),
            ),
          ),
          SizedBox(width: 32.0.scale),
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
      ),
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
    final controller = Get.find<DialogItemEditQuantityWidgetController>();
    return Material(
      color: EnumColor.backgroundDropdown.color,
      child: InkWell(
        onTap: () {
          controller.interactive(
            (eImage == EnumImage.cPlus)
                ? EnumDialogItemEditQuantityWidgetInteractive.tapIncrementQuantity
                : EnumDialogItemEditQuantityWidgetInteractive.tapDecrementQuantity,
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
