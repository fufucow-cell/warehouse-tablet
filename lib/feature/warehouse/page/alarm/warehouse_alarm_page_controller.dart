part of 'warehouse_alarm_page.dart';

class WarehouseAlarmPageController extends BasePageController {
  // MARK: - Properties

  final _model = WarehouseAlarmPageModel();
  List<Log>? get alarmLogs => _model.alarmLogs;
  Rx<bool> get isEditModeRx => _model.isEditMode;
  RxSet<String> get selectedLogIdsRx => _model.selectedLogIds;
  DateTime? get startDate => _model.startDate;
  DateTime? get endDate => _model.endDate;

  // MARK: - Init

  WarehouseAlarmPageController() {
    super.init();
  }

  // MARK: - Methods

  @override
  Future<void> apiProcessing() async {
    final response = await ApiUtil.sendRequest<WarehouseLogResponseModel>(
      EnumApiInfo.logFetch,
      requestModel: WarehouseLogRequestModel(),
      fromJson: WarehouseLogResponseModel.fromJson,
    );

    // 过滤出 log_type = 2 (alarm) 的日志
    _model.allAlarmLogs = response.data
        ?.where((log) => log.logType == 2)
        .toList();
    _applyFilters();
    update();
  }

  // 应用筛选条件
  void applyFilters({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    _model.startDate = startDate;
    _model.endDate = endDate;
    _applyFilters();
    update();
  }

  // 内部筛选方法
  void _applyFilters() {
    if (_model.allAlarmLogs == null) {
      _model.alarmLogs = null;
      return;
    }

    List<Log> filteredLogs = List.from(_model.allAlarmLogs!);

    // 按日期筛选
    if (_model.startDate != null || _model.endDate != null) {
      filteredLogs = filteredLogs.where((log) {
        if (log.createdAt == null) return false;

        final logDate = DateTime.fromMillisecondsSinceEpoch(log.createdAt! * 1000);
        final logDateOnly = DateTime(logDate.year, logDate.month, logDate.day);

        if (_model.startDate != null && _model.endDate != null) {
          // 两个日期都选了：筛选范围内的日志
          final startOnly = DateTime(
            _model.startDate!.year,
            _model.startDate!.month,
            _model.startDate!.day,
          );
          final endOnly = DateTime(
            _model.endDate!.year,
            _model.endDate!.month,
            _model.endDate!.day,
          );
          return logDateOnly.isAtSameMomentAs(startOnly) ||
              logDateOnly.isAtSameMomentAs(endOnly) ||
              (logDateOnly.isAfter(startOnly) && logDateOnly.isBefore(endOnly));
        } else if (_model.startDate != null) {
          // 只选了起始日期：筛选此日期之后的日志
          final startOnly = DateTime(
            _model.startDate!.year,
            _model.startDate!.month,
            _model.startDate!.day,
          );
          return logDateOnly.isAtSameMomentAs(startOnly) ||
              logDateOnly.isAfter(startOnly);
        } else if (_model.endDate != null) {
          // 只选了结束日期：筛选此日期之前的日志
          final endOnly = DateTime(
            _model.endDate!.year,
            _model.endDate!.month,
            _model.endDate!.day,
          );
          return logDateOnly.isAtSameMomentAs(endOnly) ||
              logDateOnly.isBefore(endOnly);
        }

        return true;
      }).toList();
    }

    _model.alarmLogs = filteredLogs;
  }

  // 切换编辑模式
  void toggleEditMode() {
    _model.isEditMode.value = !_model.isEditMode.value;
    if (!_model.isEditMode.value) {
      // 退出编辑模式时清空选择
      _model.selectedLogIds.clear();
      _model.startDate = null;
      _model.endDate = null;
    }
    update();
  }

  // 设置起始日期
  void setStartDate(DateTime? date) {
    _model.startDate = date;
    update();
  }

  // 设置结束日期
  void setEndDate(DateTime? date) {
    _model.endDate = date;
    update();
  }

  // 切换单个日志的选择状态
  void toggleLogSelection(String logId) {
    if (_model.selectedLogIds.contains(logId)) {
      _model.selectedLogIds.remove(logId);
    } else {
      _model.selectedLogIds.add(logId);
    }
    update();
  }

  // 全选
  void selectAll() {
    if (_model.alarmLogs != null) {
      for (final log in _model.alarmLogs!) {
        if (log.logId != null) {
          _model.selectedLogIds.add(log.logId!);
        }
      }
    }
    update();
  }

  // 取消全选
  void deselectAll() {
    _model.selectedLogIds.clear();
    update();
  }

  // 检查是否全选
  bool get isAllSelected {
    if (_model.alarmLogs == null || _model.alarmLogs!.isEmpty) return false;
    final validLogIds = _model.alarmLogs!
        .where((log) => log.logId != null)
        .map((log) => log.logId!)
        .toSet();
    return validLogIds.isNotEmpty &&
        _model.selectedLogIds.containsAll(validLogIds);
  }

  // 批次删除（基于选中的项）
  void batchDelete() {
    final selectedIds = _model.selectedLogIds.toList();
    if (selectedIds.isEmpty) {
      return;
    }
    // TODO: 实现批次删除逻辑
    print('批次删除告警日志: $selectedIds');
    // 删除后刷新列表
    _model.selectedLogIds.clear();
    startApiProcess();
  }

  // 基于日期删除日志
  void deleteByDate() {
    if (_model.alarmLogs == null || _model.alarmLogs!.isEmpty) {
      return;
    }

    final startDate = _model.startDate;
    final endDate = _model.endDate;

    // 如果两个日期都没选，不执行删除
    if (startDate == null && endDate == null) {
      return;
    }

    final List<String> idsToDelete = [];

    for (final log in _model.alarmLogs!) {
      if (log.logId == null || log.createdAt == null) {
        continue;
      }

      final logDate = DateTime.fromMillisecondsSinceEpoch(log.createdAt! * 1000);
      final logDateOnly = DateTime(logDate.year, logDate.month, logDate.day);

      bool shouldDelete = false;

      if (startDate != null && endDate != null) {
        // 两个日期都选了：删除范围内的日志（包含起始和结束日期）
        final startOnly = DateTime(startDate.year, startDate.month, startDate.day);
        final endOnly = DateTime(endDate.year, endDate.month, endDate.day);
        shouldDelete = logDateOnly.isAtSameMomentAs(startOnly) ||
            logDateOnly.isAtSameMomentAs(endOnly) ||
            (logDateOnly.isAfter(startOnly) && logDateOnly.isBefore(endOnly));
      } else if (startDate != null) {
        // 只选了起始日期：删除此日期之后的日志
        final startOnly = DateTime(startDate.year, startDate.month, startDate.day);
        shouldDelete = logDateOnly.isAtSameMomentAs(startOnly) ||
            logDateOnly.isAfter(startOnly);
      } else if (endDate != null) {
        // 只选了结束日期：删除此日期之前的日志
        final endOnly = DateTime(endDate.year, endDate.month, endDate.day);
        shouldDelete = logDateOnly.isAtSameMomentAs(endOnly) ||
            logDateOnly.isBefore(endOnly);
      }

      if (shouldDelete) {
        idsToDelete.add(log.logId!);
      }
    }

    if (idsToDelete.isEmpty) {
      return;
    }

    // TODO: 实现基于日期的批次删除逻辑
    print('基于日期删除告警日志: $idsToDelete (起始日期: $startDate, 结束日期: $endDate)');
    // 删除后刷新列表
    _model.startDate = null;
    _model.endDate = null;
    startApiProcess();
  }
}
