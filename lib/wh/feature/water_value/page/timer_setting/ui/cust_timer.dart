import 'dart:async';

import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustTimer extends StatefulWidget {
  // MARK: - Properties
  final TimeOfDay? time;
  final Function(TimeOfDay?) onTimeChanged;
  final double? textSize;
  final Color? selectionOverlayColor;

  // MARK: - Init
  const CustTimer({
    super.key,
    this.time,
    required this.onTimeChanged,
    this.textSize,
    this.selectionOverlayColor,
  });

  @override
  State<CustTimer> createState() => _CustTimerState();
}

class _CustTimerState extends State<CustTimer> {
  // MARK: - Properties
  late FixedExtentScrollController _amPmController;
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  int _selectedAmPmIndex = 0;
  int _selectedHourIndex = 0;
  int _selectedMinuteIndex = 0;
  Timer? _scrollEndTimer;

  // MARK: - Init
  @override
  void initState() {
    super.initState();
    _updateControllers();
    _setupScrollListeners();
  }

  @override
  void didUpdateWidget(CustTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.time != widget.time) {
      final currentTime = widget.time ?? TimeOfDay.now();
      final hour = currentTime.hour;
      final minute = currentTime.minute;
      final isAM = hour < 12;
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

      _selectedAmPmIndex = isAM ? 0 : 1;
      _selectedHourIndex = displayHour - 1;
      _selectedMinuteIndex = minute;

      // 使用 SchedulerBinding 确保在下一帧更新，避免在构建过程中直接操作滚动控制器
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted && _amPmController.hasClients) {
          _amPmController.jumpToItem(_selectedAmPmIndex);
        }
        if (mounted && _hourController.hasClients) {
          _hourController.jumpToItem(_selectedHourIndex);
        }
        if (mounted && _minuteController.hasClients) {
          _minuteController.jumpToItem(_selectedMinuteIndex);
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollEndTimer?.cancel();
    _amPmController.removeListener(_onScroll);
    _hourController.removeListener(_onScroll);
    _minuteController.removeListener(_onScroll);
    _amPmController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textSize = widget.textSize ?? 40.0.scale;
    const itemExtentToTextSizeRatio = 3;
    const diameterRatio = 2.0;
    const squeeze = 1.05;
    final itemExtent = textSize * itemExtentToTextSizeRatio;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // 中间选中区域的灰色背景
            Center(
              child: Container(
                width: double.infinity,
                height: itemExtent.scale,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0.scale),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 上午/下午选择
                Expanded(
                  child: CupertinoPicker(
                    scrollController: _amPmController,
                    itemExtent: itemExtent.scale,
                    useMagnifier: false,
                    looping: false,
                    diameterRatio: diameterRatio,
                    squeeze: squeeze,
                    selectionOverlay: widget.selectionOverlayColor != null
                        ? CupertinoPickerDefaultSelectionOverlay(
                            background: widget.selectionOverlayColor!,
                          )
                        : null,
                    onSelectedItemChanged: _onAmPmChanged,
                    children: [
                      _PickerItem(
                        text: EnumLocale.waterValueTimerAM.tr,
                        isSelected: _selectedAmPmIndex == 0,
                        textSize: textSize,
                      ),
                      _PickerItem(
                        text: EnumLocale.waterValueTimerPM.tr,
                        isSelected: _selectedAmPmIndex == 1,
                        textSize: textSize,
                      ),
                    ],
                  ),
                ),
                // 小时选择 (1-12)
                Expanded(
                  child: CupertinoPicker(
                    scrollController: _hourController,
                    itemExtent: itemExtent.scale,
                    useMagnifier: false,
                    looping: false,
                    diameterRatio: diameterRatio,
                    squeeze: squeeze,
                    selectionOverlay: widget.selectionOverlayColor != null
                        ? CupertinoPickerDefaultSelectionOverlay(
                            background: widget.selectionOverlayColor!,
                          )
                        : null,
                    onSelectedItemChanged: _onHourChanged,
                    children: List.generate(
                      12,
                      (index) {
                        final hour = index + 1;
                        return _PickerItem(
                          text: hour.toString().padLeft(2, '0'),
                          isSelected: _selectedHourIndex == index,
                          textSize: textSize,
                        );
                      },
                    ),
                  ),
                ),
                // 分钟选择 (0-59)
                Expanded(
                  child: CupertinoPicker(
                    scrollController: _minuteController,
                    itemExtent: itemExtent.scale,
                    useMagnifier: false,
                    looping: false,
                    diameterRatio: diameterRatio,
                    squeeze: squeeze,
                    selectionOverlay: widget.selectionOverlayColor != null
                        ? CupertinoPickerDefaultSelectionOverlay(
                            background: widget.selectionOverlayColor!,
                          )
                        : null,
                    onSelectedItemChanged: _onMinuteChanged,
                    children: List.generate(
                      60,
                      (index) {
                        return _PickerItem(
                          text: index.toString().padLeft(2, '0'),
                          isSelected: _selectedMinuteIndex == index,
                          textSize: textSize,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // MARK: - Private Method
  void _setupScrollListeners() {
    _amPmController.addListener(_onScroll);
    _hourController.addListener(_onScroll);
    _minuteController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted) {
      return;
    }

    // 取消之前的定时器
    _scrollEndTimer?.cancel();

    // 设置新的定时器，在滚动停止后更新状态
    _scrollEndTimer = Timer(const Duration(milliseconds: 150), () {
      if (mounted) {
        _updateSelectedIndicesFromControllers();
        _onSelectionChanged();
      }
    });
  }

  void _updateSelectedIndicesFromControllers() {
    if (!mounted) {
      return;
    }

    bool needsUpdate = false;

    if (_amPmController.hasClients) {
      final index = _amPmController.selectedItem;
      if (index != _selectedAmPmIndex) {
        _selectedAmPmIndex = index;
        needsUpdate = true;
      }
    }

    if (_hourController.hasClients) {
      final index = _hourController.selectedItem;
      if (index != _selectedHourIndex) {
        _selectedHourIndex = index;
        needsUpdate = true;
      }
    }

    if (_minuteController.hasClients) {
      final index = _minuteController.selectedItem;
      if (index != _selectedMinuteIndex) {
        _selectedMinuteIndex = index;
        needsUpdate = true;
      }
    }

    if (needsUpdate) {
      setState(() {});
    }
  }

  void _updateControllers() {
    final currentTime = widget.time ?? TimeOfDay.now();
    final hour = currentTime.hour;
    final minute = currentTime.minute;
    final isAM = hour < 12;
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    _selectedAmPmIndex = isAM ? 0 : 1;
    _selectedHourIndex = displayHour - 1;
    _selectedMinuteIndex = minute;

    _amPmController = FixedExtentScrollController(initialItem: _selectedAmPmIndex);
    _hourController = FixedExtentScrollController(initialItem: _selectedHourIndex);
    _minuteController = FixedExtentScrollController(initialItem: _selectedMinuteIndex);
  }

  void _onAmPmChanged(int index) {
    _selectedAmPmIndex = index;
  }

  void _onHourChanged(int index) {
    _selectedHourIndex = index;
  }

  void _onMinuteChanged(int index) {
    _selectedMinuteIndex = index;
  }

  void _onSelectionChanged() {
    final isAM = _selectedAmPmIndex == 0;
    final displayHour = _selectedHourIndex + 1;
    final hour = isAM ? (displayHour == 12 ? 0 : displayHour) : (displayHour == 12 ? 12 : displayHour + 12);
    final minute = _selectedMinuteIndex;
    widget.onTimeChanged(TimeOfDay(hour: hour, minute: minute));
  }
}

class _PickerItem extends StatelessWidget {
  // MARK: - Properties
  final String text;
  final bool isSelected;
  final double textSize;

  // MARK: - Init
  const _PickerItem({
    required this.text,
    required this.isSelected,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      minWidth: 0.0,
      minHeight: 0.0,
      maxWidth: double.infinity,
      maxHeight: double.infinity,
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: CustTextWidget(
            text,
            size: textSize,
            color: isSelected ? EnumColor.engoWaterValueStatusOpening.color : EnumColor.engoTextPrimary.color,
          ),
        ),
      ),
    );
  }
}
