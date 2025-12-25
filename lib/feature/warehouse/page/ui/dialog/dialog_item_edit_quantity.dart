import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';

class DialogItemEditQuantity extends StatefulWidget {
  final DialogItemEditQuantityModel dataModel;

  const DialogItemEditQuantity(this.dataModel, {super.key});

  @override
  State<DialogItemEditQuantity> createState() => _DialogItemEditQuantityState();
}

class _NewLocationItemModel {
  String? selectedRoom;
  String? selectedCabinet;
  int quantity;

  _NewLocationItemModel({
    this.selectedRoom,
    this.selectedCabinet,
    this.quantity = 1,
  });
}

class _DialogItemEditQuantityState extends State<DialogItemEditQuantity> {
  int _selectedTab = 0;
  final List<_NewLocationItemModel> _newLocations = [];

  void _addNewLocation() {
    setState(() {
      _newLocations.add(_NewLocationItemModel());
    });
  }

  void _removeNewLocation(int index) {
    setState(() {
      _newLocations.removeAt(index);
    });
  }

  void _updateNewLocationRoom(int index, String? room) {
    setState(() {
      _newLocations[index].selectedRoom = room;
      _newLocations[index].selectedCabinet = null; // 重置柜位选择
    });
  }

  void _updateNewLocationCabinet(int index, String? cabinet) {
    setState(() {
      _newLocations[index].selectedCabinet = cabinet;
    });
  }

  void _updateNewLocationQuantity(int index, int quantity) {
    setState(() {
      _newLocations[index].quantity = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogFrame(
      maxWidth: 1168.0,
      header: DialogHeader(title: EnumLocale.warehouseItemChange.tr),
      footer: DialogFooter(
        type: DialogFooterType.cancelAndConfirm,
        onCancel: () => Navigator.of(context).pop(),
        onConfirm: () {
          // TODO: 实现确认逻辑
          Navigator.of(context).pop();
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoCard(dataModel: widget.dataModel),
          SizedBox(height: 24.0.scale),
          _TabsSection(
            selectedTab: _selectedTab,
            onTabChanged: (index) => setState(() => _selectedTab = index),
          ),
          SizedBox(height: 24.0.scale),
          if (_selectedTab == 0) ...[
            _AddLocationButton(onPressed: _addNewLocation),
            SizedBox(height: 24.0.scale),
            _TotalQuantitySection(totalQuantity: widget.dataModel.totalQuantity),
            SizedBox(height: 24.0.scale),
            if (_newLocations.isNotEmpty || (widget.dataModel.locations?.isNotEmpty ?? false)) ...[
              _LocationsList(
                locations: widget.dataModel.locations ?? [],
                newLocations: _newLocations,
                onRemoveNewLocation: _removeNewLocation,
                onUpdateNewLocationRoom: _updateNewLocationRoom,
                onUpdateNewLocationCabinet: _updateNewLocationCabinet,
                onUpdateNewLocationQuantity: _updateNewLocationQuantity,
              ),
            ],
          ] else ...[
            _LocationEditContent(locations: widget.dataModel.locations ?? []),
          ],
        ],
      ),
    );
  }
}

class DialogItemEditQuantityModel {
  final String? itemName;
  final int? currentQuantity;
  final List<DialogItemEditQuantityLocationModel>? locations;

  DialogItemEditQuantityModel({
    this.itemName,
    this.currentQuantity,
    this.locations,
  });

  int get totalQuantity {
    if (locations == null || locations!.isEmpty) {
      return currentQuantity ?? 0;
    }
    return locations!.fold<int>(
      0,
      (sum, location) => sum + location.quantity,
    );
  }
}

class DialogItemEditQuantityLocationModel {
  final String locationId;
  final String locationName;
  final int quantity;

  DialogItemEditQuantityLocationModel({
    required this.locationId,
    required this.locationName,
    required this.quantity,
  });
}

class _InfoCard extends StatelessWidget {
  final DialogItemEditQuantityModel dataModel;

  const _InfoCard({required this.dataModel});

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
            value: dataModel.itemName ?? '',
          ),
          SizedBox(height: 24.0.scale),
          _InfoRow(
            label: EnumLocale.warehouseCurrentQuantityLabel.tr,
            value: (dataModel.currentQuantity ?? 0).toString(),
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

class _TabsSection extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  const _TabsSection({
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TabButton(
            label: '異動數量',
            isSelected: selectedTab == 0,
            onTap: () => onTabChanged(0),
          ),
        ),
        SizedBox(width: 32.0.scale),
        Expanded(
          child: _TabButton(
            label: '異動位置',
            isSelected: selectedTab == 1,
            onTap: () => onTabChanged(1),
          ),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0.scale,
          vertical: 16.0.scale,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 4.0.scale,
              color: isSelected ? EnumColor.accentBlue.color : Colors.transparent,
            ),
          ),
        ),
        child: WidgetUtil.textWidget(
          label,
          size: 28.0.scale,
          color: isSelected ? EnumColor.accentBlue.color : EnumColor.textSecondary.color,
        ),
      ),
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
  final List<DialogItemEditQuantityLocationModel> locations;
  final List<_NewLocationItemModel> newLocations;
  final Function(int) onRemoveNewLocation;
  final Function(int, String?) onUpdateNewLocationRoom;
  final Function(int, String?) onUpdateNewLocationCabinet;
  final Function(int, int) onUpdateNewLocationQuantity;

  const _LocationsList({
    required this.locations,
    required this.newLocations,
    required this.onRemoveNewLocation,
    required this.onUpdateNewLocationRoom,
    required this.onUpdateNewLocationCabinet,
    required this.onUpdateNewLocationQuantity,
  });

  @override
  Widget build(BuildContext context) {
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
          model: newLocations[i],
          index: i,
          onRemove: () => onRemoveNewLocation(i),
          onRoomChanged: (room) => onUpdateNewLocationRoom(i, room),
          onCabinetChanged: (cabinet) => onUpdateNewLocationCabinet(i, cabinet),
          onQuantityChanged: (quantity) => onUpdateNewLocationQuantity(i, quantity),
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

class _LocationEditContent extends StatelessWidget {
  final List<DialogItemEditQuantityLocationModel> locations;

  const _LocationEditContent({required this.locations});

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < locations.length; i++) ...[
          _LocationEditCard(location: locations[i]),
          if (i < locations.length - 1) SizedBox(height: 24.0.scale),
        ],
      ],
    );
  }
}

class _LocationEditCard extends StatefulWidget {
  final DialogItemEditQuantityLocationModel location;

  const _LocationEditCard({required this.location});

  @override
  State<_LocationEditCard> createState() => _LocationEditCardState();
}

class _LocationEditCardState extends State<_LocationEditCard> {
  late int _quantity;
  String? _selectedRoom;
  String? _selectedCabinet;

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
                  onRoomChanged: (room) => setState(() => _selectedRoom = room),
                ),
              ),
              SizedBox(width: 32.0.scale),
              Expanded(
                child: _ChangeCabinetField(
                  selectedCabinet: _selectedCabinet,
                  onCabinetChanged: (cabinet) => setState(() => _selectedCabinet = cabinet),
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
  final ValueChanged<String?> onRoomChanged;

  const _ChangeRoomField({
    required this.selectedRoom,
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
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 32.0.scale,
            vertical: 16.0.scale,
          ),
          decoration: BoxDecoration(
            color: EnumColor.backgroundSecondary.color,
            border: Border.all(
              width: 1.0.scale,
              color: EnumColor.lineBorder.color,
            ),
            borderRadius: BorderRadius.circular(16.0.scale),
          ),
          child: Row(
            children: [
              Expanded(
                child: WidgetUtil.textWidget(
                  selectedRoom ?? '請選擇',
                  size: 32.0.scale,
                  color: selectedRoom == null ? EnumColor.textSecondary.color : EnumColor.textPrimary.color,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 38.0.scale,
                color: EnumColor.textPrimary.color,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChangeCabinetField extends StatelessWidget {
  final String? selectedCabinet;
  final ValueChanged<String?> onCabinetChanged;

  const _ChangeCabinetField({
    required this.selectedCabinet,
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
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 32.0.scale,
            vertical: 16.0.scale,
          ),
          decoration: BoxDecoration(
            color: EnumColor.backgroundSecondary.color,
            border: Border.all(
              width: 1.0.scale,
              color: EnumColor.lineBorder.color,
            ),
            borderRadius: BorderRadius.circular(16.0.scale),
          ),
          child: Row(
            children: [
              Expanded(
                child: WidgetUtil.textWidget(
                  selectedCabinet ?? '請選擇',
                  size: 32.0.scale,
                  color: selectedCabinet == null ? EnumColor.textSecondary.color : EnumColor.textPrimary.color,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 38.0.scale,
                color: EnumColor.textPrimary.color,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NewLocationItem extends StatefulWidget {
  final _NewLocationItemModel model;
  final int index;
  final VoidCallback onRemove;
  final ValueChanged<String?> onRoomChanged;
  final ValueChanged<String?> onCabinetChanged;
  final ValueChanged<int> onQuantityChanged;

  const _NewLocationItem({
    required this.model,
    required this.index,
    required this.onRemove,
    required this.onRoomChanged,
    required this.onCabinetChanged,
    required this.onQuantityChanged,
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

  void _decrement() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
        widget.onQuantityChanged(_quantity);
      });
    }
  }

  void _increment() {
    setState(() {
      _quantity++;
      widget.onQuantityChanged(_quantity);
    });
  }

  void _onRoomSelected(String? room) {
    setState(() {
      _selectedRoom = room;
      _selectedCabinet = null;
      _availableCabinets = _getCabinetsForRoom(room);
    });
    widget.onRoomChanged(room);
  }

  @override
  void didUpdateWidget(_NewLocationItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model.selectedRoom != _selectedRoom) {
      _selectedRoom = widget.model.selectedRoom;
      _availableCabinets = _getCabinetsForRoom(_selectedRoom);
    }
    if (widget.model.selectedCabinet != _selectedCabinet) {
      _selectedCabinet = widget.model.selectedCabinet;
    }
    if (widget.model.quantity != _quantity) {
      _quantity = widget.model.quantity;
    }
  }

  void _onCabinetSelected(String? cabinet) {
    setState(() {
      _selectedCabinet = cabinet;
    });
    widget.onCabinetChanged(cabinet);
  }

  List<String> _getCabinetsForRoom(String? roomName) {
    if (roomName == null) return [];
    final service = WarehouseService.instance;
    // 通过房间名称找到对应的 roomId
    final roomModel = service.rooms.where((r) => r.name == roomName).firstOrNull;
    if (roomModel?.id == null) return [];

    // 通过 roomId 找到对应的 Room 对象
    final room = service.getAllRoomCabinetItems
        .where(
          (room) => room.roomId == roomModel!.id,
        )
        .firstOrNull;
    return room?.cabinets?.map((cabinet) => cabinet.name ?? '').where((name) => name.isNotEmpty).toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final service = WarehouseService.instance;
    final rooms = service.rooms.map((room) => room.name ?? '').where((name) => name.isNotEmpty).toList();

    // 如果选择了房间，更新可用柜位列表
    if (_selectedRoom != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _availableCabinets = _getCabinetsForRoom(_selectedRoom);
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
          onPressed: widget.onRemove,
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
