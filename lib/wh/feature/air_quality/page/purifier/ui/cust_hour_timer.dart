import 'dart:async';

import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustHourTimer extends StatefulWidget {
  // MARK: - Properties
  final Function(int?) onTimeChanged;
  final double? textSize;
  final Color? selectionBackgroundColor;

  /// 初始小時 (1-12)，未指定時預設為 1
  final int? initialHour;

  // MARK: - Init
  const CustHourTimer({
    super.key,
    required this.onTimeChanged,
    this.textSize,
    this.selectionBackgroundColor,
    this.initialHour,
  });

  @override
  State<CustHourTimer> createState() => _CustHourTimerState();
}

class _CustHourTimerState extends State<CustHourTimer> {
  // MARK: - Properties
  late FixedExtentScrollController _hourController;
  int _selectedHourIndex = 0; // 默认索引 0，对应小时 1
  Timer? _scrollEndTimer;

  // MARK: - Init
  @override
  void initState() {
    super.initState();
    _updateControllers();
    _setupScrollListeners();
    // 初始化時通知外部目前選中值
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onSelectionChanged();
    });
  }

  @override
  void didUpdateWidget(CustHourTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialHour != widget.initialHour && widget.initialHour != null) {
      final hour = (widget.initialHour!).clamp(1, 12);
      _selectedHourIndex = hour - 1;
      if (_hourController.hasClients) {
        _hourController.jumpToItem(_selectedHourIndex);
      }
    }
  }

  @override
  void dispose() {
    _scrollEndTimer?.cancel();
    _hourController.removeListener(_onScroll);
    _hourController.dispose();
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
                  color: widget.selectionBackgroundColor ?? Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0.scale),
                ),
              ),
            ),
            // 小时选择 (1-12)
            CupertinoPicker(
              scrollController: _hourController,
              itemExtent: itemExtent.scale,
              useMagnifier: false,
              looping: false,
              diameterRatio: diameterRatio,
              squeeze: squeeze,
              onSelectedItemChanged: _onHourChanged,
              children: List.generate(
                12,
                (index) {
                  final hour = index + 1; // 1-12
                  return _PickerItem(
                    text: hour.toString(),
                    isSelected: _selectedHourIndex == index,
                    textSize: textSize,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // MARK: - Private Method

  void _setupScrollListeners() {
    _hourController.addListener(_onScroll);
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

    if (_hourController.hasClients) {
      final index = _hourController.selectedItem;
      if (index != _selectedHourIndex) {
        _selectedHourIndex = index;
        needsUpdate = true;
      }
    }

    if (needsUpdate) {
      setState(() {});
    }
  }

  void _updateControllers() {
    // 使用 initialHour (1-12) 或預設 1 小時，索引為 hour - 1
    final hour = (widget.initialHour ?? 1).clamp(1, 12);
    _selectedHourIndex = hour - 1;

    _hourController = FixedExtentScrollController(initialItem: _selectedHourIndex);
  }

  void _onHourChanged(int index) {
    _selectedHourIndex = index;
  }

  void _onSelectionChanged() {
    // 索引转换为实际小时数 (1-12)
    final hour = _selectedHourIndex + 1;
    widget.onTimeChanged(hour);
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
