import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/util/root_router_util.dart';

/// 告警搜索对话框
class DialogSearchAlarm {
  /// 显示告警搜索对话框
  static void show({
    DateTime? initialStartDate,
    DateTime? initialEndDate,
    Function({
      DateTime? startDate,
      DateTime? endDate,
    })? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    final context = RootRouterUtil.instance.rootContext;
    if (context == null) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _SearchAlarmDialogWidget(
        initialStartDate: initialStartDate,
        initialEndDate: initialEndDate,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }
}

/// 告警搜索对话框 Widget
class _SearchAlarmDialogWidget extends StatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function({
    DateTime? startDate,
    DateTime? endDate,
  })? onConfirm;
  final VoidCallback? onCancel;

  const _SearchAlarmDialogWidget({
    this.initialStartDate,
    this.initialEndDate,
    this.onConfirm,
    this.onCancel,
  });

  @override
  State<_SearchAlarmDialogWidget> createState() =>
      _SearchAlarmDialogWidgetState();
}

class _SearchAlarmDialogWidgetState
    extends State<_SearchAlarmDialogWidget> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;
  }

  // 格式化日期显示
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32.0.scale),
          padding: EdgeInsets.all(24.0.scale),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16.0.scale),
          ),
          constraints: BoxConstraints(
            maxWidth: 600.0.scale,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title 居中
              Center(
                child: Text(
                  '搜尋',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(height: 24.0.scale),
              // 起始日期选择器
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _startDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _startDate = pickedDate;
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        _startDate != null
                            ? '起始：${_formatDate(_startDate!)}'
                            : '起始日期',
                      ),
                    ),
                  ),
                  if (_startDate != null)
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () {
                        setState(() {
                          _startDate = null;
                        });
                      },
                      tooltip: '清除起始日期',
                    ),
                ],
              ),
              SizedBox(height: 16.0.scale),
              // 结束日期选择器
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _endDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _endDate = pickedDate;
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        _endDate != null
                            ? '结束：${_formatDate(_endDate!)}'
                            : '结束日期',
                      ),
                    ),
                  ),
                  if (_endDate != null)
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () {
                        setState(() {
                          _endDate = null;
                        });
                      },
                      tooltip: '清除结束日期',
                    ),
                ],
              ),
              SizedBox(height: 24.0.scale),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onCancel?.call();
                    },
                    child: const Text('取消'),
                  ),
                  SizedBox(width: 12.0.scale),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onConfirm?.call(
                        startDate: _startDate,
                        endDate: _endDate,
                      );
                    },
                    child: const Text('確認'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
