import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustDatePickerTextField extends StatefulWidget {
  final DateTime? selectedDate;
  final EnumDatePickerMode mode;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime) onDateSelected;
  final String? placeholder;
  final bool canEdit;

  const CustDatePickerTextField({
    super.key,
    this.selectedDate,
    this.mode = EnumDatePickerMode.yearToDay,
    this.firstDate,
    this.lastDate,
    required this.onDateSelected,
    this.placeholder,
    this.canEdit = true,
  });

  @override
  State<CustDatePickerTextField> createState() => _CustDatePickerTextFieldState();
}

class _CustDatePickerTextFieldState extends State<CustDatePickerTextField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  @override
  void didUpdateWidget(CustDatePickerTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate) {
      _selectedDate = widget.selectedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.canEdit ? () => _showDatePicker(context) : null,
        borderRadius: BorderRadius.circular(8.0.scale),
        child: Container(
          constraints: const BoxConstraints.expand(),
          padding: EdgeInsets.symmetric(
            horizontal: 16.0.scale,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0.scale),
            color: widget.canEdit ? EnumColor.backgroundPrimary.color : EnumColor.backgroundSecondary.color,
            border: Border.all(
              color: EnumColor.lineBorder.color,
              width: 1.0.scale,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: CustTextWidget(
                  widget.mode.convertDateToText(_selectedDate, placeholder: widget.placeholder),
                  size: 32.0.scale,
                  color: _selectedDate != null ? EnumColor.textPrimary.color : EnumColor.textSecondary.color,
                ),
              ),
              SizedBox(width: 8.0.scale),
              EnumImage.cArrowDown.image(
                size: Size.square(32.0.scale),
                color: _selectedDate != null ? EnumColor.textPrimary.color : EnumColor.textSecondary.color,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final initial = _selectedDate ?? now;
    final first = widget.firstDate ?? DateTime(now.year, now.month - 3, now.day);
    final last = widget.lastDate ?? DateTime(now.year, now.month + 3, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: initial.isBefore(first) ? first : (initial.isAfter(last) ? last : initial),
      firstDate: first,
      lastDate: last,
      initialDatePickerMode: widget.mode.initialPickerMode,
    );

    if (picked != null) {
      final result = switch (widget.mode) {
        EnumDatePickerMode.yearOnly => DateTime(picked.year, now.month, now.day),
        EnumDatePickerMode.monthOnly || EnumDatePickerMode.yearToMonth => DateTime(picked.year, picked.month, now.day),
        _ => picked,
      };
      setState(() {
        _selectedDate = result;
      });
      widget.onDateSelected(result);
    }
  }
}

enum EnumDatePickerMode {
  dayOnly('dd'),
  monthOnly('MM'),
  yearOnly('yyyy'),
  monthToDay('MM/dd'),
  yearToDay('yyyy/MM/dd'),
  yearToMonth('yyyy/MM');

  final String format;

  const EnumDatePickerMode(this.format);

  DatePickerMode get initialPickerMode => switch (this) {
        yearOnly || yearToMonth => DatePickerMode.year,
        _ => DatePickerMode.day,
      };

  String convertDateToText(DateTime? date, {String? placeholder}) {
    if (date == null) {
      return placeholder ?? '請選擇日期';
    }
    return DateFormat(format).format(date);
  }
}
