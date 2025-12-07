import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_log_request_model/warehouse_log_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_log_response_model/log.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_log_response_model/warehouse_log_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/api_util.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'warehouse_record_page_controller.dart';
part 'warehouse_record_page_interactive.dart';
part 'warehouse_record_page_model.dart';
part 'warehouse_record_page_route.dart';

class WarehouseRecordPage extends GetView<WarehouseRecordPageController> {
  const WarehouseRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseRecordPageController>(
      init: WarehouseRecordPageController(),
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
    return GetBuilder<WarehouseRecordPageController>(
      builder: (controller) {
        final logs = controller.logs;

        if (logs?.isEmpty ?? true) {
          return const Center(
            child: Text('暂无记录'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: logs!.length,
          itemBuilder: (context, index) {
            final log = logs[index];
            return _LogItem(log: log);
          },
        );
      },
    );
  }
}

class _LogItem extends StatelessWidget {
  final Log log;

  const _LogItem({
    required this.log,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              _getIconForOperateType(log.operateType),
              color: _getColorForOperateType(log.operateType),
              size: 24,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: _getColorForOperateType(log.operateType)
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          EnumOperateType.fromInt(log.operateType).title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _getColorForOperateType(log.operateType),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        EnumEntityType.fromInt(log.entityType).title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  ..._getModifyContent(),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (log.createdAt != null)
                  Text(
                    _formatTimestamp(log.createdAt!),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                if (log.userName != null) ...[
                  if (log.createdAt != null) const SizedBox(height: 4.0),
                  Text(
                    log.userName!,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForOperateType(int? operateType) {
    final type = EnumOperateType.fromInt(operateType);
    switch (type) {
      case EnumOperateType.create:
        return Icons.add;
      case EnumOperateType.update:
        return Icons.edit;
      case EnumOperateType.delete:
        return Icons.delete;
      default:
        return Icons.info;
    }
  }

  Color _getColorForOperateType(int? operateType) {
    final type = EnumOperateType.fromInt(operateType);
    switch (type) {
      case EnumOperateType.create:
        return Colors.green;
      case EnumOperateType.update:
        return Colors.blue;
      case EnumOperateType.delete:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  // 格式化值，null 显示为"未設定"
  String _formatValue(String? value) => value ?? '未設定';
  String _formatIntValue(int? value) => value?.toString() ?? '未設定';

  List<Widget> _getModifyContent() {
    final operateType = EnumOperateType.fromInt(log.operateType);
    final entityType = EnumEntityType.fromInt(log.entityType);

    // 創建與刪除的調整內容比較單純
    if (operateType == EnumOperateType.create) {
      final entityName =
          log.entityName?.isNotEmpty == true ? log.entityName![0] : null;
      return [
        Text(
          '名稱：${_formatValue(entityName)}',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ];
    } else if (operateType == EnumOperateType.delete) {
      final entityName =
          log.entityName?.isNotEmpty == true ? log.entityName![0] : null;
      return [
        Text(
          '名稱：${_formatValue(entityName)}',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ];
    }

    // 更新操作需要顯示詳細的調整內容
    // 根據數組內容判斷變更：空數組 = 無變更，一個值 = 新增/刪除，兩個值 = 更新
    final contents = <Widget>[];

    // 處理名稱變更
    final entityNameList = log.entityName;
    if (entityNameList != null && entityNameList.isNotEmpty) {
      if (entityNameList.length >= 2) {
        contents.add(
          Text(
            '名稱：${_formatValue(entityNameList[0])} → ${_formatValue(entityNameList[1])}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        );
      }
    }

    // 處理描述變更
    final descriptionNameList = log.descriptionName;
    if (descriptionNameList != null && descriptionNameList.isNotEmpty) {
      if (descriptionNameList.length >= 2) {
        contents.add(
          Text(
            '描述：${_formatValue(descriptionNameList[0])} → ${_formatValue(descriptionNameList[1])}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        );
      }
    }

    // 處理分類變更（只對物品適用）
    if (entityType == EnumEntityType.item) {
      final categoryNameList = log.categoryName;
      if (categoryNameList != null && categoryNameList.isNotEmpty) {
        if (categoryNameList.length >= 2) {
          contents.add(
            Text(
              '分類：${_formatValue(categoryNameList[0])} → ${_formatValue(categoryNameList[1])}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          );
        }
      }
    }

    // 處理數量變更（只對物品適用）
    if (entityType == EnumEntityType.item) {
      final quantityCountList = log.quantityCount;
      if (quantityCountList != null && quantityCountList.isNotEmpty) {
        if (quantityCountList.length >= 2) {
          contents.add(
            Text(
              '數量：${_formatIntValue(quantityCountList[0])} → ${_formatIntValue(quantityCountList[1])}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          );
        }
      }
    }

    // 處理最小庫存變更（只對物品適用）
    if (entityType == EnumEntityType.item) {
      final minStockCountList = log.minStockCount;
      if (minStockCountList != null && minStockCountList.isNotEmpty) {
        if (minStockCountList.length >= 2) {
          contents.add(
            Text(
              '庫存：${_formatIntValue(minStockCountList[0])} → ${_formatIntValue(minStockCountList[1])}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          );
        }
      }
    }

    // 處理房間移動（對櫥櫃和物品都適用）
    final roomNameList = log.roomName;
    if (roomNameList != null && roomNameList.isNotEmpty) {
      if (roomNameList.length >= 2) {
        contents.add(
          Text(
            '房間：${_formatValue(roomNameList[0])} → ${_formatValue(roomNameList[1])}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        );
      }
    }

    // 處理照片變更
    final photoUrlList = log.photoUrl;
    if (photoUrlList != null && photoUrlList.isNotEmpty) {
      if (photoUrlList.length >= 2) {
        contents.add(
          const Text(
            '照片',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        );
      }
    }

    if (contents.isEmpty) {
      return [
        const Text(
          '無調整內容',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ];
    }

    return contents;
  }
}
