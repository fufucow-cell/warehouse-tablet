import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustTimer extends StatefulWidget {
  final String title;
  final TimeOfDay? time;
  final Function(TimeOfDay?) onTimeChanged;

  const CustTimer({
    super.key,
    required this.title,
    required this.time,
    required this.onTimeChanged,
  });

  @override
  State<CustTimer> createState() => _CustTimerState();
}

class _CustTimerState extends State<CustTimer> {
  late FixedExtentScrollController _amPmController;
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  int _selectedAmPmIndex = 0;
  int _selectedHourIndex = 0;
  int _selectedMinuteIndex = 0;

  @override
  void initState() {
    super.initState();
    _updateControllers();
  }

  @override
  void didUpdateWidget(CustTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.time != widget.time) {
      final hour = widget.time?.hour ?? 8;
      final minute = widget.time?.minute ?? 0;
      final isAM = hour < 12;
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

      _selectedAmPmIndex = isAM ? 0 : 1;
      _selectedHourIndex = displayHour - 1;
      _selectedMinuteIndex = minute;

      if (_amPmController.hasClients) {
        _amPmController.jumpToItem(_selectedAmPmIndex);
      }
      if (_hourController.hasClients) {
        _hourController.jumpToItem(_selectedHourIndex);
      }
      if (_minuteController.hasClients) {
        _minuteController.jumpToItem(_selectedMinuteIndex);
      }
    }
  }

  void _updateControllers() {
    final hour = widget.time?.hour ?? 8;
    final minute = widget.time?.minute ?? 0;
    final isAM = hour < 12;
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    _selectedAmPmIndex = isAM ? 0 : 1;
    _selectedHourIndex = displayHour - 1;
    _selectedMinuteIndex = minute;

    _amPmController = FixedExtentScrollController(initialItem: _selectedAmPmIndex);
    _hourController = FixedExtentScrollController(initialItem: _selectedHourIndex);
    _minuteController = FixedExtentScrollController(initialItem: _selectedMinuteIndex);
  }

  @override
  void dispose() {
    _amPmController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  void _onAmPmChanged(int index) {
    setState(() {
      _selectedAmPmIndex = index;
    });
    _onSelectionChanged();
  }

  void _onHourChanged(int index) {
    setState(() {
      _selectedHourIndex = index;
    });
    _onSelectionChanged();
  }

  void _onMinuteChanged(int index) {
    setState(() {
      _selectedMinuteIndex = index;
    });
    _onSelectionChanged();
  }

  void _onSelectionChanged() {
    final isAM = _selectedAmPmIndex == 0;
    final displayHour = _selectedHourIndex + 1;
    final hour = isAM ? (displayHour == 12 ? 0 : displayHour) : (displayHour == 12 ? 12 : displayHour + 12);
    final minute = _selectedMinuteIndex;

    widget.onTimeChanged(TimeOfDay(hour: hour, minute: minute));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 593.0.scale,
          child: CustTextWidget(
            widget.title,
            size: 32.0.scale,
            color: EnumColor.textPrimary.color,
            align: TextAlign.center,
          ),
        ),
        SizedBox(height: 48.0.scale),
        SizedBox(
          width: double.infinity,
          height: 228.0.scale,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 上午/下午选择
              SizedBox(
                width: 65.0.scale,
                child: CupertinoPicker(
                  scrollController: _amPmController,
                  itemExtent: 46.0.scale,
                  useMagnifier: false,
                  looping: false,
                  onSelectedItemChanged: _onAmPmChanged,
                  children: [
                    Center(
                      child: _PickerItem(
                        text: EnumLocale.waterValueTimerAM.tr,
                        isSelected: _selectedAmPmIndex == 0,
                      ),
                    ),
                    Center(
                      child: _PickerItem(
                        text: EnumLocale.waterValueTimerPM.tr,
                        isSelected: _selectedAmPmIndex == 1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 88.0.scale),
              // 小时选择 (1-12)
              SizedBox(
                width: 38.0.scale,
                child: CupertinoPicker(
                  scrollController: _hourController,
                  itemExtent: 46.0.scale,
                  useMagnifier: false,
                  looping: false,
                  onSelectedItemChanged: _onHourChanged,
                  children: List.generate(
                    12,
                    (index) {
                      final hour = index + 1;
                      return Center(
                        child: _PickerItem(
                          text: hour.toString().padLeft(2, '0'),
                          isSelected: _selectedHourIndex == index,
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 88.0.scale),
              // 分钟选择 (0-59)
              SizedBox(
                width: 38.0.scale,
                child: CupertinoPicker(
                  scrollController: _minuteController,
                  itemExtent: 46.0.scale,
                  useMagnifier: false,
                  looping: false,
                  onSelectedItemChanged: _onMinuteChanged,
                  children: List.generate(
                    60,
                    (index) {
                      return Center(
                        child: _PickerItem(
                          text: index.toString().padLeft(2, '0'),
                          isSelected: _selectedMinuteIndex == index,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PickerItem extends StatelessWidget {
  final String text;
  final bool isSelected;

  const _PickerItem({
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CustTextWidget(
      text,
      size: 32.0.scale,
      color: isSelected ? EnumColor.engoWaterValueStatusOpening.color : EnumColor.textSecondary.color,
    );
  }
}
