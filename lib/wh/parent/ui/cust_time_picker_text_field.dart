import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';

class CustTimePickerTextField extends StatefulWidget {
  final TimeOfDay? selectedTime;
  final EnumTimePickerMode mode;
  final void Function(TimeOfDay) onTimeSelected;
  final String? placeholder;
  final bool canEdit;

  const CustTimePickerTextField({
    super.key,
    this.selectedTime,
    this.mode = EnumTimePickerMode.hourToMinute,
    required this.onTimeSelected,
    this.placeholder,
    this.canEdit = true,
  });

  @override
  State<CustTimePickerTextField> createState() =>
      _CustTimePickerTextFieldState();
}

class _CustTimePickerTextFieldState extends State<CustTimePickerTextField> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.selectedTime;
  }

  @override
  void didUpdateWidget(CustTimePickerTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedTime != widget.selectedTime) {
      _selectedTime = widget.selectedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.canEdit ? () => _showTimePicker(context) : null,
        borderRadius: BorderRadius.circular(16.0.scale),
        child: Container(
          constraints: const BoxConstraints.expand(),
          padding: EdgeInsets.symmetric(horizontal: 32.0.scale),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0.scale),
            color: widget.canEdit
                ? EnumColor.backgroundPrimary.color
                : EnumColor.backgroundSecondary.color,
            border: Border.all(
              color: EnumColor.lineBorder.color,
              width: 1.0.scale,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CustTextWidget(
                  widget.mode.convertTimeToText(_selectedTime,
                      placeholder: widget.placeholder),
                  size: 32.0.scale,
                  color: _selectedTime != null
                      ? EnumColor.textPrimary.color
                      : EnumColor.textSecondary.color,
                ),
              ),
              SizedBox(width: 16.0.scale),
              EnumImage.cArrowDown.image(
                size: Size.square(38.0.scale),
                color: _selectedTime != null
                    ? EnumColor.textPrimary.color
                    : EnumColor.textSecondary.color,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final now = TimeOfDay.now();
    final initial = _selectedTime ?? now;

    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );

    if (picked != null) {
      final result = switch (widget.mode) {
        EnumTimePickerMode.hourOnly => TimeOfDay(hour: picked.hour, minute: 0),
        EnumTimePickerMode.minuteOnly =>
          TimeOfDay(hour: 0, minute: picked.minute),
        _ => picked,
      };
      setState(() {
        _selectedTime = result;
      });
      widget.onTimeSelected(result);
    }
  }
}

enum EnumTimePickerMode {
  minuteOnly,
  hourOnly,
  hourToMinute;

  String convertTimeToText(TimeOfDay? time, {String? placeholder}) {
    if (time == null) {
      return placeholder ?? '請選擇時間';
    }
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');

    return switch (this) {
      minuteOnly => minute,
      hourOnly => hour,
      hourToMinute => '$hour:$minute',
    };
  }
}
