import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_log_request_model/warehouse_log_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_log_response_model/log.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_log_response_model/warehouse_log_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/api_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'warehouse_alarm_page_controller.dart';
part 'warehouse_alarm_page_interactive.dart';
part 'warehouse_alarm_page_model.dart';
part 'warehouse_alarm_page_route.dart';

class WarehouseAlarmPage extends GetView<WarehouseAlarmPageController> {
  const WarehouseAlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseAlarmPageController>(
      init: WarehouseAlarmPageController(),
      builder: (controller) {
        return Obx(
          () {
            return Skeletonizer(
              enabled: controller.isLoadingRx.value,
              child: _Body(),
            );
          },
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  // 格式化日期显示
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // 获取日期删除按钮的文字
  String _getDateDeleteButtonText(
    DateTime? startDate,
    DateTime? endDate,
  ) {
    if (startDate != null && endDate != null) {
      return EnumLocale.warehouseDeleteDateRange.tr;
    } else if (startDate != null) {
      return EnumLocale.warehouseDeleteAfterDate.tr;
    } else if (endDate != null) {
      return EnumLocale.warehouseDeleteBeforeDate.tr;
    }
    return EnumLocale.warehouseDeleteByDate.tr;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseAlarmPageController>(
      builder: (controller) {
        final alarmLogs = controller.alarmLogs;

        if (alarmLogs?.isEmpty ?? true) {
          return Center(
            child: Text(EnumLocale.warehouseNoAlarm.tr),
          );
        }

        return Column(
          children: [
            // 编辑模式下的工具栏（全选和批次删除）
            Obx(
              () {
                final isEditMode = controller.isEditModeRx.value;
                if (!isEditMode) {
                  return const SizedBox.shrink();
                }

                final selectedCount = controller.selectedLogIdsRx.length;
                final isAllSelected = controller.isAllSelected;

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  color: Colors.grey[200],
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          TextButton.icon(
                            onPressed: isAllSelected
                                ? () => controller.deselectAll()
                                : () => controller.selectAll(),
                            icon: Icon(
                              isAllSelected
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                            ),
                            label: Text(
                              isAllSelected
                                  ? EnumLocale.warehouseDeselectAll.tr
                                  : EnumLocale.warehouseSelectAll.tr,
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          // 起始日期选择器
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton.icon(
                                onPressed: () async {
                                  final pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        controller.startDate ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (pickedDate != null) {
                                    controller.setStartDate(
                                      pickedDate,
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.calendar_today,
                                ),
                                label: Text(
                                  controller.startDate != null
                                      ? '${EnumLocale.warehouseStartDateLabel.tr}${_formatDate(controller.startDate!)}'
                                      : EnumLocale.warehouseStartDate.tr,
                                ),
                              ),
                              if (controller.startDate != null)
                                IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    controller.setStartDate(null);
                                  },
                                  tooltip:
                                      EnumLocale.warehouseClearStartDate.tr,
                                ),
                            ],
                          ),
                          const SizedBox(width: 8.0),
                          // 结束日期选择器
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton.icon(
                                onPressed: () async {
                                  final pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        controller.endDate ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (pickedDate != null) {
                                    controller.setEndDate(
                                      pickedDate,
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.calendar_today,
                                ),
                                label: Text(
                                  controller.endDate != null
                                      ? '${EnumLocale.warehouseEndDateLabel.tr}${_formatDate(controller.endDate!)}'
                                      : EnumLocale.warehouseEndDate.tr,
                                ),
                              ),
                              if (controller.endDate != null)
                                IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    controller.setEndDate(null);
                                  },
                                  tooltip: EnumLocale.warehouseClearEndDate.tr,
                                ),
                            ],
                          ),
                          const Spacer(),
                          // 日期删除提示文字（在删除按钮左边）
                          if (controller.startDate != null ||
                              controller.endDate != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 8.0,
                              ),
                              child: Text(
                                _getDateDeleteButtonText(
                                  controller.startDate,
                                  controller.endDate,
                                ),
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          // 批次删除按钮（基于选中项）
                          if (selectedCount > 0)
                            TextButton.icon(
                              onPressed: () => controller.batchDelete(),
                              icon: const Icon(Icons.delete),
                              label: Text(EnumLocale.warehouseDeleteButton.tr),
                            ),
                          // 按日期删除按钮
                          if (controller.startDate != null ||
                              controller.endDate != null)
                            TextButton.icon(
                              onPressed: () => controller.deleteByDate(),
                              icon: const Icon(Icons.delete),
                              label: Text(EnumLocale.warehouseDeleteButton.tr),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            // 告警日志列表
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: alarmLogs!.length,
                itemBuilder: (context, index) {
                  final log = alarmLogs[index];
                  return _AlarmItem(log: log);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AlarmItem extends StatelessWidget {
  final Log log;

  const _AlarmItem({
    required this.log,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseAlarmPageController>();

    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      color: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 编辑模式下的复选框
            Obx(
              () {
                final isEditMode = controller.isEditModeRx.value;
                if (!isEditMode) {
                  return const SizedBox.shrink();
                }

                final isSelected = log.id != null &&
                    controller.selectedLogIdsRx.contains(log.id!);

                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Checkbox(
                    value: isSelected,
                    onChanged: log.id != null
                        ? (value) {
                            controller.toggleLogSelection(
                              log.id!,
                            );
                          }
                        : null,
                  ),
                );
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 物品名称（title）
                  Text(
                    _getItemName(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // 变更内容
                  ..._getChangeContent(),
                  const SizedBox(height: 8.0),
                  // 低于库存数量
                  _getStockAlarmInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getItemName() {
    final itemNameList = log.itemName;
    if (itemNameList != null && itemNameList.isNotEmpty) {
      // 如果是更新操作，优先显示新名称
      if (itemNameList.length >= 2 && itemNameList[1] != null && itemNameList[1]!.isNotEmpty) {
        return itemNameList[1]!;
      }
      // 否则显示第一个值
      if (itemNameList[0] != null && itemNameList[0]!.isNotEmpty) {
        return itemNameList[0]!;
      }
    }
    return EnumLocale.warehouseUnknownItem.tr;
  }

  List<Widget> _getChangeContent() {
    final operateType = log.operateType;

    // 如果是创建操作，显示"新增物品"
    if (operateType == 1) {
      return [
        Text(
          EnumLocale.warehouseCreateItem.tr,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ];
    }

    final contents = <Widget>[];

    // 处理数量变更
    final quantityCountList = log.itemQuantity?.totalCount;
    if (quantityCountList != null && quantityCountList.isNotEmpty) {
      if (quantityCountList.length >= 2) {
        contents.add(
          Text(
            EnumLocale.warehouseQuantityChange.tr
                .replaceAll('{from}', _formatIntValue(quantityCountList[0]))
                .replaceAll('{to}', _formatIntValue(quantityCountList[1])),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        );
      }
    }

    // 处理库存报警数量变更
    final minStockCountList = log.itemMinStockCount;
    if (minStockCountList != null && minStockCountList.isNotEmpty) {
      if (minStockCountList.length >= 2) {
        contents.add(
          Text(
            EnumLocale.warehouseStockAlertChange.tr
                .replaceAll('{from}', _formatIntValue(minStockCountList[0]))
                .replaceAll('{to}', _formatIntValue(minStockCountList[1])),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        );
      }
    }

    return contents;
  }

  Widget _getStockAlarmInfo() {
    final quantityCountList = log.itemQuantity?.totalCount;
    final minStockCountList = log.itemMinStockCount;

    int? currentQuantity;
    int? minStockCount;

    // 获取当前数量（新值或当前值）
    if (quantityCountList != null && quantityCountList.isNotEmpty) {
      if (quantityCountList.length >= 2) {
        // 更新操作，取新值
        currentQuantity = quantityCountList[1];
      } else {
        // 只有一个值，表示当前数量
        currentQuantity = quantityCountList[0];
      }
    }

    // 获取库存报警数量（新值或当前值）
    if (minStockCountList != null && minStockCountList.isNotEmpty) {
      if (minStockCountList.length >= 2) {
        // 更新操作，取新值
        minStockCount = minStockCountList[1];
      } else {
        // 只有一个值，表示库存报警数量（未变更）
        minStockCount = minStockCountList[0];
      }
    }

    if (currentQuantity != null && minStockCount != null) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          EnumLocale.warehouseCurrentQuantity.tr
              .replaceAll('{quantity}', '$currentQuantity')
              .replaceAll('{minStock}', '$minStockCount'),
          style: TextStyle(
            fontSize: 14,
            color: Colors.red.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  String _formatIntValue(int? value) =>
      value?.toString() ?? EnumLocale.optionNotSet.tr;
}
