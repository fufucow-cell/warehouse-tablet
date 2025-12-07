part of 'warehouse_cabinet_page.dart';

class WarehouseCabinetPageController extends BasePageController {
  // MARK: - Properties

  final _model = WarehouseCabinetPageModel();
  List<Cabinet>? get cabinets => _model.cabinets;

  // MARK: - Init

  WarehouseCabinetPageController() {
    super.init();
  }

  // MARK: - Methods

  @override
  Future<void> apiProcessing() async {
    final response = await ApiUtil.sendRequest<WarehouseCabinetResponseModel>(
      EnumApiInfo.cabinetFetch,
      requestModel: WarehouseCabinetRequestModel(),
      fromJson: WarehouseCabinetResponseModel.fromJson,
    );

    _model.cabinets = response.data;
    update();
  }
}
