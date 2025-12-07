part of 'warehouse_alarm_page.dart';

class WarehouseAlarmPageController extends BasePageController {
  // MARK: - Properties

  final _model = WarehouseAlarmPageModel();
  List<Log>? get alarmLogs => _model.alarmLogs;

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
    _model.alarmLogs = response.data
        ?.where((log) => log.logType == 2)
        .toList();
    update();
  }
}
