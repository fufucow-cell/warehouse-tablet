part of 'warehouse_item_page.dart';

class WarehouseItemPageController extends BasePageController {
  // MARK: - Properties

  final _model = WarehouseItemPageModel();
  List<Item>? get items => _model.items;

  // MARK: - Init

  WarehouseItemPageController() {
    super.init();
  }

  // MARK: - Methods

  @override
  Future<void> apiProcessing() async {
    final response = await ApiUtil.sendRequest<WarehouseItemResponseModel>(
      EnumApiInfo.itemFetch,
      requestModel: WarehouseItemRequestModel(),
      fromJson: WarehouseItemResponseModel.fromJson,
    );

    _model.items = response.data;
    update();
  }
}
