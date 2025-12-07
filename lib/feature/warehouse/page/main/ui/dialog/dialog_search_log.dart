import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page.dart';
import 'package:flutter_smart_home_tablet/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/util/root_router_util.dart';

/// 日志搜索对话框
class DialogSearchLog {
  /// 显示日志搜索对话框
  static void show({
    DateTime? initialStartDate,
    DateTime? initialEndDate,
    EnumOperateType? initialOperateType,
    EnumEntityType? initialEntityType,
    Function({
      DateTime? startDate,
      DateTime? endDate,
      EnumOperateType? operateType,
      EnumEntityType? entityType,
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
      builder: (context) => _SearchLogDialogWidget(
        initialStartDate: initialStartDate,
        initialEndDate: initialEndDate,
        initialOperateType: initialOperateType,
        initialEntityType: initialEntityType,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }
}

/// 日志搜索对话框 Widget
class _SearchLogDialogWidget extends StatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final EnumOperateType? initialOperateType;
  final EnumEntityType? initialEntityType;
  final Function({
    DateTime? startDate,
    DateTime? endDate,
    EnumOperateType? operateType,
    EnumEntityType? entityType,
  })? onConfirm;
  final VoidCallback? onCancel;

  const _SearchLogDialogWidget({
    this.initialStartDate,
    this.initialEndDate,
    this.initialOperateType,
    this.initialEntityType,
    this.onConfirm,
    this.onCancel,
  });

  @override
  State<_SearchLogDialogWidget> createState() =>
      _SearchLogDialogWidgetState();
}

class _SearchLogDialogWidgetState
    extends State<_SearchLogDialogWidget> {
  DateTime? _startDate;
  DateTime? _endDate;
  EnumOperateType? _selectedOperateType;
  EnumEntityType? _selectedEntityType;

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;
    _selectedOperateType = widget.initialOperateType;
    _selectedEntityType = widget.initialEntityType;
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
              SizedBox(height: 16.0.scale),
              // 操作类型下拉选单
              DropdownButtonFormField<EnumOperateType?>(
                value: _selectedOperateType,
                decoration: const InputDecoration(
                  labelText: '操作類型',
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem<EnumOperateType?>(
                    value: null,
                    child: Text('全部'),
                  ),
                  ...EnumOperateType.values
                      .where((e) => e != EnumOperateType.unknown)
                      .map((type) {
                    return DropdownMenuItem<EnumOperateType?>(
                      value: type,
                      child: Text(type.title),
                    );
                  }),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedOperateType = value;
                  });
                },
              ),
              SizedBox(height: 16.0.scale),
              // 实体类型下拉选单
              DropdownButtonFormField<EnumEntityType?>(
                value: _selectedEntityType,
                decoration: const InputDecoration(
                  labelText: '實體類型',
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem<EnumEntityType?>(
                    value: null,
                    child: Text('全部'),
                  ),
                  ...EnumEntityType.values
                      .where((e) => e != EnumEntityType.unknown)
                      .map((type) {
                    return DropdownMenuItem<EnumEntityType?>(
                      value: type,
                      child: Text(type.title),
                    );
                  }),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedEntityType = value;
                  });
                },
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
                        operateType: _selectedOperateType,
                        entityType: _selectedEntityType,
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
