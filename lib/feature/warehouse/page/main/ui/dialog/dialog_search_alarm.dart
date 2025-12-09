import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/temp_router_util.dart';

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
    final context = TempRouterUtil.getRootContext();
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
    final dialogInsetPadding =
        30.0.scale > 0 ? 30.0.scale : 30.0;
    return Dialog(
      insetPadding: EdgeInsets.all(dialogInsetPadding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth =
              MediaQuery.of(context).size.width;
          final scale600 = 600.0.scale;
          final scale60 = 60.0.scale;
          final scale40 = 40.0.scale;
          final scale8 = 8.0.scale;
          final dialogMaxWidth =
              scale600 > 0 ? scale600 : 600.0;
          final insetPaddingValue =
              scale60 > 0 ? scale60 : 60.0;
          final containerPaddingValue =
              scale40 > 0 ? scale40 : 40.0;
          final horizontalPaddingValue =
              scale8 > 0 ? scale8 : 8.0;
          final screenMinusPadding =
              screenWidth - (insetPaddingValue * 2);
          final dialogWidth =
              (dialogMaxWidth < screenMinusPadding)
                  ? dialogMaxWidth
                  : screenMinusPadding;
          final maxHeight =
              MediaQuery.of(context).size.height * 0.8;
          return Container(
            width: dialogWidth,
            padding: EdgeInsets.all(containerPaddingValue),
            constraints: BoxConstraints(
              maxWidth: dialogWidth,
              maxHeight: maxHeight,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                children: [
                  // Title 居中
                  Center(
                    child: Text(
                      EnumLocale.searchTitle.tr,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  // 起始日期选择器
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () async {
                              final pickedDate =
                                  await showDatePicker(
                                context: context,
                                initialDate: _startDate ??
                                    DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _startDate = pickedDate;
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.calendar_today,
                            ),
                            label: Text(
                              _startDate != null
                                  ? '${EnumLocale.searchStartDateLabel.tr}：${_formatDate(_startDate!)}'
                                  : EnumLocale
                                      .searchStartDate.tr,
                            ),
                          ),
                        ),
                        if (_startDate != null)
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _startDate = null;
                              });
                            },
                            tooltip: EnumLocale
                                .searchClearStartDate.tr,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // 结束日期选择器
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () async {
                              final pickedDate =
                                  await showDatePicker(
                                context: context,
                                initialDate: _endDate ??
                                    DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _endDate = pickedDate;
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.calendar_today,
                            ),
                            label: Text(
                              _endDate != null
                                  ? '${EnumLocale.searchEndDateLabel.tr}：${_formatDate(_endDate!)}'
                                  : EnumLocale
                                      .searchEndDate.tr,
                            ),
                          ),
                        ),
                        if (_endDate != null)
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _endDate = null;
                              });
                            },
                            tooltip: EnumLocale
                                .searchClearEndDate.tr,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onCancel?.call();
                          },
                          child: Text(
                            EnumLocale.commonCancel.tr,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onConfirm?.call(
                              startDate: _startDate,
                              endDate: _endDate,
                            );
                          },
                          child: Text(
                            EnumLocale.commonConfirm.tr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
