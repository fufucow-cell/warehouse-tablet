import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_position/dialog_item_edit_position_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_position/dialog_item_edit_position_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class DialogItemEditPositionWidget extends StatelessWidget {
  final String itemId;

  const DialogItemEditPositionWidget({
    super.key,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogItemEditPositionWidgetController>(
      init: DialogItemEditPositionWidgetController(itemId),
      builder: (controller) {
        return Obx(
          () {
            return DialogFrame(
              width: 1168.0.scale,
              header: DialogHeader(title: EnumLocale.warehouseItemChange.tr),
              footer: DialogFooter(
                type: DialogFooterType.cancelAndConfirm,
                onCancel: () {
                  controller.interactive(
                    EnumDialogItemEditPositionWidgetInteractive.tapDialogCancelButton,
                    data: context,
                  );
                },
                onConfirm: () {
                  controller.interactive(
                    EnumDialogItemEditPositionWidgetInteractive.tapDialogConfirmButton,
                    data: context,
                  );
                },
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoCard(
                    itemName: controller.itemNameRx.value ?? '',
                    currentQuantity: controller.currentQuantityRx.value ?? 0,
                  ),
                  SizedBox(height: 24.0.scale),
                  _LocationEditContent(
                    locations: controller.locationsRx.value,
                    controller: controller,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String itemName;
  final int currentQuantity;

  const _InfoCard({
    required this.itemName,
    required this.currentQuantity,
  });

  @override
  Widget build(BuildContext context) {
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
            value: itemName,
          ),
          SizedBox(height: 24.0.scale),
          _InfoRow(
            label: EnumLocale.warehouseCurrentQuantityLabel.tr,
            value: currentQuantity.toString(),
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

class _LocationEditContent extends StatelessWidget {
  final List<DialogItemEditPositionLocationModel> locations;
  final DialogItemEditPositionWidgetController controller;

  const _LocationEditContent({
    required this.locations,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < locations.length; i++) ...[
          _LocationEditCard(
            location: locations[i],
            controller: controller,
          ),
          if (i < locations.length - 1) SizedBox(height: 24.0.scale),
        ],
      ],
    );
  }
}

class _LocationEditCard extends StatefulWidget {
  final DialogItemEditPositionLocationModel location;
  final DialogItemEditPositionWidgetController controller;

  const _LocationEditCard({
    required this.location,
    required this.controller,
  });

  @override
  State<_LocationEditCard> createState() => _LocationEditCardState();
}

class _LocationEditCardState extends State<_LocationEditCard> {
  late int _quantity;
  String? _selectedRoom;
  String? _selectedCabinet;
  List<String> _availableCabinets = [];

  @override
  void initState() {
    super.initState();
    _quantity = widget.location.quantity;
  }

  void _decrement() {
    if (_quantity > 0) {
      setState(() => _quantity--);
    }
  }

  void _increment() {
    setState(() => _quantity++);
  }

  void _onRoomSelected(String? room) {
    setState(() {
      _selectedRoom = room;
      _selectedCabinet = null;
      _availableCabinets = widget.controller.getCabinetsForRoom(room);
    });
  }

  void _onCabinetSelected(String? cabinet) {
    setState(() {
      _selectedCabinet = cabinet;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 如果选择了房间，更新可用柜位列表
    if (_selectedRoom != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _availableCabinets = widget.controller.getCabinetsForRoom(_selectedRoom);
          });
        }
      });
    }

    return Container(
      padding: EdgeInsets.all(32.0.scale),
      decoration: BoxDecoration(
        color: EnumColor.backgroundPrimary.color,
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
          Row(
            children: [
              WidgetUtil.textWidget(
                widget.location.locationName,
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
                  _quantity.toString(),
                  size: 28.0.scale,
                  color: EnumColor.textWhite.color,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.0.scale),
          _ChangeQuantitySection(
            quantity: _quantity,
            onDecrement: _decrement,
            onIncrement: _increment,
          ),
          SizedBox(height: 32.0.scale),
          Row(
            children: [
              Expanded(
                child: _ChangeRoomField(
                  selectedRoom: _selectedRoom,
                  availableRooms: widget.controller.getRoomNameList(),
                  onRoomChanged: _onRoomSelected,
                ),
              ),
              SizedBox(width: 32.0.scale),
              Expanded(
                child: _ChangeCabinetField(
                  selectedCabinet: _selectedCabinet,
                  availableCabinets: _availableCabinets,
                  onCabinetChanged: _onCabinetSelected,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChangeQuantitySection extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _ChangeQuantitySection({
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetUtil.textWidget(
          '更改數量',
          size: 26.0.scale,
          color: EnumColor.textSecondary.color,
        ),
        SizedBox(height: 12.0.scale),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _QuantityButton(
              icon: Icons.remove,
              onPressed: onDecrement,
            ),
            SizedBox(width: 16.0.scale),
            Expanded(
              child: Container(
                height: 70.0.scale,
                padding: EdgeInsets.all(16.0.scale),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0.scale,
                    color: EnumColor.lineBorder.color,
                  ),
                  borderRadius: BorderRadius.circular(16.0.scale),
                ),
                child: Center(
                  child: WidgetUtil.textWidget(
                    quantity.toString(),
                    size: 32.0.scale,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.0.scale),
            _QuantityButton(
              icon: Icons.add,
              onPressed: onIncrement,
            ),
          ],
        ),
      ],
    );
  }
}

class _ChangeRoomField extends StatelessWidget {
  final String? selectedRoom;
  final List<String> availableRooms;
  final ValueChanged<String?> onRoomChanged;

  const _ChangeRoomField({
    required this.selectedRoom,
    required this.availableRooms,
    required this.onRoomChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetUtil.textWidget(
          '更改房間',
          size: 26.0.scale,
          color: EnumColor.textSecondary.color,
        ),
        SizedBox(height: 12.0.scale),
        WidgetUtil.textDropdownButton(
          selectedValue: selectedRoom,
          values: availableRooms,
          buttonTextColor: selectedRoom == null ? EnumColor.textSecondary.color : null,
          onValueSelected: (str, idx) => onRoomChanged(str),
        ),
      ],
    );
  }
}

class _ChangeCabinetField extends StatelessWidget {
  final String? selectedCabinet;
  final List<String> availableCabinets;
  final ValueChanged<String?> onCabinetChanged;

  const _ChangeCabinetField({
    required this.selectedCabinet,
    required this.availableCabinets,
    required this.onCabinetChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetUtil.textWidget(
          '更改櫥櫃/架子（可選）',
          size: 26.0.scale,
          color: EnumColor.textSecondary.color,
        ),
        SizedBox(height: 12.0.scale),
        WidgetUtil.textDropdownButton(
          selectedValue: selectedCabinet,
          values: availableCabinets,
          buttonTextColor: selectedCabinet == null ? EnumColor.textSecondary.color : null,
          onValueSelected: (str, idx) => onCabinetChanged(str),
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0.scale,
      height: 70.0.scale,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0.scale,
          color: EnumColor.lineBorder.color,
        ),
        borderRadius: BorderRadius.circular(16.0.scale),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16.0.scale),
          child: Icon(
            icon,
            size: 40.0.scale,
            color: EnumColor.textPrimary.color,
          ),
        ),
      ),
    );
  }
}
