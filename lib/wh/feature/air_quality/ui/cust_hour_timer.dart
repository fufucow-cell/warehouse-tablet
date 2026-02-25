import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustHourTimer extends StatefulWidget {
  final Function(int?) onTimeChanged;
  final int? initialHour;

  const CustHourTimer({
    super.key,
    required this.onTimeChanged,
    this.initialHour,
  });

  @override
  State<CustHourTimer> createState() => _CustHourTimerState();
}

class _CustHourTimerState extends State<CustHourTimer> {
  late FixedExtentScrollController _hourController;
  int _selectedHourIndex = 0;
  Timer? _scrollEndTimer;

  @override
  void initState() {
    super.initState();
    _updateControllers();
    _setupScrollListeners();
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
    const textSize = 40.0;
    const itemExtentToTextSizeRatio = 1.8;
    const diameterRatio = 2.0;
    const squeeze = 1.05;
    const itemExtent = textSize * itemExtentToTextSizeRatio;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Center(
              child: Container(
                width: double.infinity,
                height: itemExtent,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            CupertinoPicker(
              scrollController: _hourController,
              itemExtent: itemExtent,
              useMagnifier: false,
              looping: false,
              diameterRatio: diameterRatio,
              squeeze: squeeze,
              onSelectedItemChanged: _onHourChanged,
              children: List.generate(
                12,
                (index) {
                  final hour = index + 1;
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

  void _setupScrollListeners() {
    _hourController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted) {
      return;
    }

    _scrollEndTimer?.cancel();

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
    final hour = (widget.initialHour ?? 1).clamp(1, 12);
    _selectedHourIndex = hour - 1;
    _hourController = FixedExtentScrollController(initialItem: _selectedHourIndex);
  }

  void _onHourChanged(int index) {
    _selectedHourIndex = index;
  }

  void _onSelectionChanged() {
    setState(() {
      final hour = _selectedHourIndex + 1;
      widget.onTimeChanged(hour);
    });
  }
}

class _PickerItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final double textSize;

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
          child: Text(
            text,
            style: TextStyle(
              fontSize: textSize,
              color: isSelected ? const Color(0xFFFB9B51) : const Color(0xFF292929),
            ),
          ),
        ),
      ),
    );
  }
}
