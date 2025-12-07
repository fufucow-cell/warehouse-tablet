part of 'warehouse_cabinet_page.dart';

class WarehouseCabinetPageController extends BasePageController {
  // MARK: - Properties

  final _model = WarehouseCabinetPageModel();
  List<Cabinet>? get cabinets => _model.cabinets;
  Rx<bool> get isEditModeRx => _model.isEditMode;
  String? get filterName => _model.filterName;
  String? get filterRoomId => _model.filterRoomId;

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

    _model.allCabinets = response.data;
    _applyFilters();
    update();
  }

  // 应用筛选条件
  void applyFilters({
    String? name,
    String? roomId,
  }) {
    _model.filterName = name;
    _model.filterRoomId = roomId;
    _applyFilters();
    update();
  }

  // 内部筛选方法
  void _applyFilters() {
    if (_model.allCabinets == null) {
      _model.cabinets = null;
      return;
    }

    List<Cabinet> filteredCabinets = List.from(_model.allCabinets!);

    // 按名称筛选
    if (_model.filterName != null && _model.filterName!.isNotEmpty) {
      final searchName = _model.filterName!.toLowerCase();
      filteredCabinets = filteredCabinets.where((cabinet) {
        final cabinetName = cabinet.name?.toLowerCase() ?? '';
        return cabinetName.contains(searchName);
      }).toList();
    }

    // 按房間筛选
    if (_model.filterRoomId != null) {
      final filterRoomId = _model.filterRoomId;
      filteredCabinets = filteredCabinets.where((cabinet) {
        // 如果筛选条件是特殊值 '__UNSET__'，筛选 room_id 为 null 的櫥櫃
        if (filterRoomId == '__UNSET__') {
          return cabinet.roomId == null;
        }
        // 否则按 room_id 匹配
        return cabinet.roomId == filterRoomId;
      }).toList();
    }

    _model.cabinets = filteredCabinets;
  }

  // 切换编辑模式
  void toggleEditMode() {
    _model.isEditMode.value = !_model.isEditMode.value;
    update();
  }

  // 删除橱柜
  void deleteCabinet(Cabinet cabinet) {
    // TODO: 实现删除橱柜的逻辑
    print('删除橱柜: ${cabinet.name} (${cabinet.cabinetId})');
  }
}
