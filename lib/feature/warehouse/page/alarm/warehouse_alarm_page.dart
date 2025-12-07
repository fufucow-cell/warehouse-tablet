import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_log_request_model/warehouse_log_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_log_response_model/log.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_log_response_model/warehouse_log_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/api_util.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'warehouse_alarm_page_controller.dart';
part 'warehouse_alarm_page_interactive.dart';
part 'warehouse_alarm_page_model.dart';
part 'warehouse_alarm_page_route.dart';

class WarehouseAlarmPage
    extends GetView<WarehouseAlarmPageController> {
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
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseAlarmPageController>(
      builder: (controller) {
        final alarmLogs = controller.alarmLogs;

        if (alarmLogs?.isEmpty ?? true) {
          return const Center(
            child: Text('暂无告警记录'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: alarmLogs!.length,
          itemBuilder: (context, index) {
            final log = alarmLogs[index];
            return _AlarmItem(log: log);
          },
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
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      color: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
    );
  }

  String _getItemName() {
    final entityNameList = log.entityName;
    if (entityNameList != null &&
        entityNameList.isNotEmpty) {
      // 如果是更新操作，优先显示新名称
      if (entityNameList.length >= 2 &&
          entityNameList[1] != null) {
        return entityNameList[1]!;
      }
      // 否则显示第一个值
      if (entityNameList[0] != null) {
        return entityNameList[0]!;
      }
    }
    return '未知物品';
  }

  List<Widget> _getChangeContent() {
    final operateType = log.operateType;

    // 如果是创建操作，显示"新增物品"
    if (operateType == 1) {
      return [
        const Text(
          '新增物品',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ];
    }

    final contents = <Widget>[];

    // 处理数量变更
    final quantityCountList = log.quantityCount;
    if (quantityCountList != null &&
        quantityCountList.isNotEmpty) {
      if (quantityCountList.length >= 2) {
        contents.add(
          Text(
            '數量：${_formatIntValue(quantityCountList[0])} → ${_formatIntValue(quantityCountList[1])}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        );
      }
    }

    // 处理库存报警数量变更
    final minStockCountList = log.minStockCount;
    if (minStockCountList != null &&
        minStockCountList.isNotEmpty) {
      if (minStockCountList.length >= 2) {
        contents.add(
          Text(
            '庫存警報：${_formatIntValue(minStockCountList[0])} → ${_formatIntValue(minStockCountList[1])}',
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
    final quantityCountList = log.quantityCount;
    final minStockCountList = log.minStockCount;

    int? currentQuantity;
    int? minStockCount;

    // 获取当前数量（新值或当前值）
    if (quantityCountList != null &&
        quantityCountList.isNotEmpty) {
      if (quantityCountList.length >= 2) {
        // 更新操作，取新值
        currentQuantity = quantityCountList[1];
      } else {
        // 只有一个值，表示当前数量
        currentQuantity = quantityCountList[0];
      }
    }

    // 获取库存报警数量（新值或当前值）
    if (minStockCountList != null &&
        minStockCountList.isNotEmpty) {
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
          '當前數量：$currentQuantity，低於庫存數量：$minStockCount',
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
      value?.toString() ?? '未設定';
}
