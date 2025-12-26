import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_quantity/dialog_item_edit_quantity_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_quantity/dialog_item_edit_quantity_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class DialogItemEditQuantityWidget extends StatelessWidget {
  final String itemId;

  const DialogItemEditQuantityWidget({
    super.key,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogItemEditQuantityWidgetController>(
      init: DialogItemEditQuantityWidgetController(itemId),
      builder: (controller) {
        return Obx(
          () {
            return DialogFrame(
              maxWidth: 1168.0,
              header: DialogHeader(title: EnumLocale.warehouseItemChange.tr),
              footer: DialogFooter(
                type: DialogFooterType.cancelAndConfirm,
                onCancel: () {
                  controller.interactive(
                    EnumDialogItemEditQuantityWidgetInteractive.tapDialogCancelButton,
                    data: context,
                  );
                },
                onConfirm: () {
                  controller.interactive(
                    EnumDialogItemEditQuantityWidgetInteractive.tapDialogConfirmButton,
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
                  _AddLocationButton(
                    onPressed: () {
                      controller.interactive(
                        EnumDialogItemEditQuantityWidgetInteractive.tapAddLocation,
                      );
                    },
                  ),
                  SizedBox(height: 24.0.scale),
                  _TotalQuantitySection(totalQuantity: controller.totalQuantity),
                  SizedBox(height: 24.0.scale),
                  if (controller.newLocationsRx.value.isNotEmpty ||
                      controller.locationsRx.value.isNotEmpty) ...[
                    _LocationsList(
                      controller: controller,
                    ),
                  ],
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

class _AddLocationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddLocationButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add,
            size: 40.0.scale,
            color: EnumColor.accentBlue.color,
          ),
          SizedBox(width: 12.0.scale),
          WidgetUtil.textWidget(
            '新增存放位置',
            size: 28.0.scale,
            color: EnumColor.accentBlue.color,
          ),
        ],
      ),
    );
  }
}

class _TotalQuantitySection extends StatelessWidget {
  final int totalQuantity;

  const _TotalQuantitySection({required this.totalQuantity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WidgetUtil.textWidget(
          '調整後總數量',
          size: 28.0.scale,
        ),
        SizedBox(width: 24.0.scale),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.scale),
          decoration: BoxDecoration(
            color: EnumColor.accentBlue.color,
            borderRadius: BorderRadius.circular(12.0.scale),
          ),
          child: WidgetUtil.textWidget(
            totalQuantity.toString(),
            size: 28.0.scale,
            color: EnumColor.textWhite.color,
          ),
        ),
      ],
    );
  }
}

class _LocationsList extends StatelessWidget {
  final DialogItemEditQuantityWidgetController controller;

  const _LocationsList({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final locations = controller.locationsRx.value;
    final newLocations = controller.newLocationsRx.value;
    final allItems = <Widget>[];

    // 添加原有的位置
    for (int i = 0; i < locations.length; i++) {
      allItems.add(_LocationItem(location: locations[i]));
      if (i < locations.length - 1 || newLocations.isNotEmpty) {
        allItems.add(SizedBox(height: 32.0.scale));
        allItems.add(
          Divider(
            height: 1.0.scale,
            thickness: 1.0.scale,
            color: EnumColor.lineDividerLight.color,
          ),
        );
        allItems.add(SizedBox(height: 32.0.scale));
      }
    }

    // 添加新增的位置
    for (int i = 0; i < newLocations.length; i++) {
      allItems.add(
        _NewLocationItem(
          controller: controller,
          model: newLocations[i],
          index: i,
        ),
      );
      if (i < newLocations.length - 1) {
        allItems.add(SizedBox(height: 32.0.scale));
        allItems.add(
          Divider(
            height: 1.0.scale,
            thickness: 1.0.scale,
            color: EnumColor.lineDividerLight.color,
          ),
        );
        allItems.add(SizedBox(height: 32.0.scale));
      }
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: allItems,
      ),
    );
  }
}

class _LocationItem extends StatefulWidget {
  final DialogItemEditQuantityLocationModel location;

  const _LocationItem({required this.location});

  @override
  State<_LocationItem> createState() => _LocationItemState();
}

class _LocationItemState extends State<_LocationItem> {
  late int _quantity;

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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: WidgetUtil.textWidget(
            widget.location.locationName,
            size: 28.0.scale,
          ),
        ),
        SizedBox(width: 64.0.scale),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _QuantityButton(
              icon: Icons.remove,
              onPressed: _decrement,
            ),
            SizedBox(width: 16.0.scale),
            Container(
              width: 180.0.scale,
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
                  _quantity.toString(),
                  size: 32.0.scale,
                ),
              ),
            ),
            SizedBox(width: 16.0.scale),
            _QuantityButton(
              icon: Icons.add,
              onPressed: _increment,
            ),
          ],
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

class _NewLocationItem extends StatefulWidget {
  final DialogItemEditQuantityWidgetController controller;
  final NewLocationItemModel model;
  final int index;

  const _NewLocationItem({
    required this.controller,
    required this.model,
    required this.index,
  });

  @override
  State<_NewLocationItem> createState() => _NewLocationItemState();
}

class _NewLocationItemState extends State<_NewLocationItem> {
  late int _quantity;
  String? _selectedRoom;
  String? _selectedCabinet;
  List<String> _availableCabinets = [];

  @override
  void initState() {
    super.initState();
    _quantity = widget.model.quantity;
    _selectedRoom = widget.model.selectedRoom;
    _selectedCabinet = widget.model.selectedCabinet;
  }

  @override
  void didUpdateWidget(_NewLocationItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model.selectedRoom != _selectedRoom) {
      _selectedRoom = widget.model.selectedRoom;
      _availableCabinets = widget.controller.getCabinetsForRoom(_selectedRoom);
    }
    if (widget.model.selectedCabinet != _selectedCabinet) {
      _selectedCabinet = widget.model.selectedCabinet;
    }
    if (widget.model.quantity != _quantity) {
      _quantity = widget.model.quantity;
    }
  }

  void _decrement() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });
      widget.controller.interactive(
        EnumDialogItemEditQuantityWidgetInteractive.tapUpdateNewLocationQuantity,
        data: {'index': widget.index, 'quantity': _quantity},
      );
    }
  }

  void _increment() {
    setState(() {
      _quantity++;
    });
    widget.controller.interactive(
      EnumDialogItemEditQuantityWidgetInteractive.tapUpdateNewLocationQuantity,
      data: {'index': widget.index, 'quantity': _quantity},
    );
  }

  void _onRoomSelected(String? room) {
    setState(() {
      _selectedRoom = room;
      _selectedCabinet = null;
      _availableCabinets = widget.controller.getCabinetsForRoom(room);
    });
    widget.controller.interactive(
      EnumDialogItemEditQuantityWidgetInteractive.tapUpdateNewLocationRoom,
      data: {'index': widget.index, 'room': room},
    );
  }

  void _onCabinetSelected(String? cabinet) {
    setState(() {
      _selectedCabinet = cabinet;
    });
    widget.controller.interactive(
      EnumDialogItemEditQuantityWidgetInteractive.tapUpdateNewLocationCabinet,
      data: {'index': widget.index, 'cabinet': cabinet},
    );
  }

  @override
  Widget build(BuildContext context) {
    final rooms = widget.controller.getRoomNameList();

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

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetUtil.textWidget(
                '房間',
                size: 26.0.scale,
                color: EnumColor.textSecondary.color,
              ),
              SizedBox(height: 12.0.scale),
              WidgetUtil.textDropdownButton(
                selectedValue: _selectedRoom,
                values: rooms,
                buttonTextColor: _selectedRoom == null ? EnumColor.textSecondary.color : null,
                onValueSelected: (str, idx) => _onRoomSelected(str),
              ),
            ],
          ),
        ),
        SizedBox(width: 32.0.scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetUtil.textWidget(
                '櫃位',
                size: 26.0.scale,
                color: EnumColor.textSecondary.color,
              ),
              SizedBox(height: 12.0.scale),
              WidgetUtil.textDropdownButton(
                selectedValue: _selectedCabinet,
                values: _availableCabinets,
                buttonTextColor: _selectedCabinet == null ? EnumColor.textSecondary.color : null,
                onValueSelected: (str, idx) => _onCabinetSelected(str),
              ),
            ],
          ),
        ),
        SizedBox(width: 32.0.scale),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WidgetUtil.textWidget(
              '數量',
              size: 26.0.scale,
              color: EnumColor.textSecondary.color,
            ),
            SizedBox(height: 12.0.scale),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _QuantityButton(
                  icon: Icons.remove,
                  onPressed: _decrement,
                ),
                SizedBox(width: 16.0.scale),
                Container(
                  width: 180.0.scale,
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
                      _quantity.toString(),
                      size: 32.0.scale,
                    ),
                  ),
                ),
                SizedBox(width: 16.0.scale),
                _QuantityButton(
                  icon: Icons.add,
                  onPressed: _increment,
                ),
              ],
            ),
          ],
        ),
        SizedBox(width: 16.0.scale),
        IconButton(
          onPressed: () {
            widget.controller.interactive(
              EnumDialogItemEditQuantityWidgetInteractive.tapRemoveNewLocation,
              data: widget.index,
            );
          },
          icon: Icon(
            Icons.delete_outline,
            size: 40.0.scale,
            color: EnumColor.textSecondary.color,
          ),
        ),
      ],
    );
  }
}
