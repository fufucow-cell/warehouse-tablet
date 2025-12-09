import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/temp_router_util.dart';

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
    final context = TempRouterUtil.getRootContext();
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
                  const SizedBox(height: 16.0),
                  // 操作类型下拉选单
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: DropdownButtonFormField<
                        EnumOperateType?>(
                      value: _selectedOperateType,
                      decoration: InputDecoration(
                        labelText: EnumLocale
                            .searchOperationType.tr,
                        border: const OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem<EnumOperateType?>(
                          value: null,
                          child:
                              Text(EnumLocale.optionAll.tr),
                        ),
                        ...EnumOperateType.values
                            .where(
                          (e) =>
                              e != EnumOperateType.unknown,
                        )
                            .map((type) {
                          return DropdownMenuItem<
                              EnumOperateType?>(
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
                  ),
                  const SizedBox(height: 16.0),
                  // 实体类型下拉选单
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: DropdownButtonFormField<
                        EnumEntityType?>(
                      value: _selectedEntityType,
                      decoration: InputDecoration(
                        labelText:
                            EnumLocale.searchEntityType.tr,
                        border: const OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem<EnumEntityType?>(
                          value: null,
                          child:
                              Text(EnumLocale.optionAll.tr),
                        ),
                        ...EnumEntityType.values
                            .where(
                          (e) =>
                              e != EnumEntityType.unknown,
                        )
                            .map((type) {
                          return DropdownMenuItem<
                              EnumEntityType?>(
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
                              operateType:
                                  _selectedOperateType,
                              entityType:
                                  _selectedEntityType,
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
