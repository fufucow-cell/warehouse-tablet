part of 'warehouse_record_page.dart';

class WarehouseRecordPageController extends BasePageController {
  // MARK: - Properties

  final _model = WarehouseRecordPageModel();
  List<Log>? get logs => _model.logs;

  // MARK: - Init

  WarehouseRecordPageController() {
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

    _model.logs = response.data;
    update();
  }
}
