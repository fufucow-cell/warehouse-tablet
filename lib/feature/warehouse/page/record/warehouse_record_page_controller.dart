import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/util/record_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_record_read_request_model/warehouse_record_read_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'warehouse_record_page_interactive.dart';
part 'warehouse_record_page_route.dart';

class WarehouseRecordPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseRecordPageModel();
  final _service = WarehouseService.instance;
  final scrollController = ScrollController();
  Timer? _refreshDebounceTimer;
  List<int> get columnRatioRx => _model.columnRatio;
  String get avatarUrl => _service.userAvatar;
  RxReadonly<List<CombineRecord>?> get allLogsRx => _model.allLogs.readonly;
  RxReadonly<List<CombineRecord>> get visibleLogsRx => _model.visibleLogs.readonly;
  RxReadonly<bool> get isShowFilterMenuRx => _model.isShowFilterMenu.readonly;
  RxReadonly<EnumFilterType> get filterTypeRx => _model.filterType.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(
      EnumLogType.debug,
      '[WarehouseRecordPageController] onInit - $hashCode',
    );
    _checkData();
  }

  @override
  void onClose() {
    LogUtil.i(
      EnumLogType.debug,
      '[WarehouseRecordPageController] onClose - $hashCode',
    );
    _refreshDebounceTimer?.cancel();
    scrollController.dispose();
    super.onClose();
  }

  // MARK: - Public Method

  List<String> get getFilterNames {
    return EnumFilterType.values.map((type) => type.title).toList();
  }

  // MARK: - Private Method

  void _checkData() {
    final allLogs = _service.allRecordsRx.value;

    if (allLogs == null) {
      _queryApiData();
    } else {
      final combineRecords = RecordUtil.combineItemRecords(allLogs);
      _genVisibleLogs(combineRecords);
      _model.allLogs.value = combineRecords;
    }
  }

  Future<void> _queryApiData() async {
    final response = await _service.apiReqReadRecord(
      WarehouseRecordReadRequestModel(
        householdId: _service.getHouseholdId,
      ),
    );

    if (response != null) {
      final combineRecords = RecordUtil.combineItemRecords(response);
      _genVisibleLogs(combineRecords);
      _model.allLogs.value = combineRecords;
    }
  }

  void _genVisibleLogs(List<CombineRecord> allRecords) {
    final startDate = _model.filterType.value.startDate;

    if (startDate == null) {
      _model.visibleLogs.value = allRecords;
      return;
    }

    final startTimestamp = startDate.millisecondsSinceEpoch ~/ 1000;

    final visibleLogs = allRecords.where((record) {
      // epoch 是毫秒，需要转换为秒进行比较
      final recordTimestamp = record.epoch ~/ 1000;
      return recordTimestamp >= startTimestamp;
    }).toList();

    _model.visibleLogs.value = visibleLogs;
  }
}
