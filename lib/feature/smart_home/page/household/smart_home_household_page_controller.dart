part of 'smart_home_household_page.dart';

class SmartHomeHouseholdPageController extends BasePageController {
  // MARK: - Properties

  final _model = SmartHomeHouseholdPageModel();
  final _homeService = SmartHomeService.instance;
  HomeHouseholdResponseModel? get householdData => _model.householdData;
  TextEditingController get homeNameController => _model.homeNameController;
  bool get hasHousehold =>
      _model.householdData != null &&
      (_model.householdData?.homeName?.isNotEmpty ?? false);

  List<Household>? get householdList => _homeService.getUserData?.household;

  int get currentHouseholdIndex => _model.currentHouseholdIndex;

  Household? get currentHousehold {
    final households = householdList;
    if (households == null || households.isEmpty) {
      return null;
    }
    if (_model.currentHouseholdIndex >= 0 &&
        _model.currentHouseholdIndex < households.length) {
      return households[_model.currentHouseholdIndex];
    }
    return households.first;
  }

  // MARK: - Init

  SmartHomeHouseholdPageController() {
    super.init();
    _model.userId = _homeService.getUserData?.id;
    _model.userName = _homeService.getUserData?.userName;
    _model.currentHouseholdIndex = 0;
    final households = _homeService.getUserData?.household;
    if (households != null && households.isNotEmpty) {
      _model.homeId = households.first.homeId;
    }
  }

  // MARK: - Override Method

  @override
  void onClose() {
    _model.homeNameController.dispose();
    super.onClose();
  }

  // MARK: - Method

  @override
  Future<void> apiProcessing() async {
    final response = await ApiUtil.sendRequest<HomeHouseholdResponseModel>(
      EnumApiInfo.homeFetch,
      requestModel: HomeHouseholdRequestModel(
        homeId: _model.homeId?.toString(),
      ),
      fromJson: HomeHouseholdResponseModel.fromJson,
    );

    _homeService.updateHomeHouseholdData(response);
    _model.householdData = response;
    update();
  }

  Future<void> createHome() async {
    final homeName = _model.homeNameController.text.trim();
    if (homeName.isEmpty) {
      return;
    }

    try {
      await ApiUtil.sendRequest<HomeHouseholdResponseModel>(
        EnumApiInfo.homeCreate,
        requestModel: HomeHouseholdRequestModel(homeName: homeName),
        fromJson: HomeHouseholdResponseModel.fromJson,
      );

      _model.homeNameController.clear();
      await startApiProcess();
    } on Exception {
      // 错误处理
    }
  }

  Future<void> switchHousehold(int index) async {
    final households = householdList;
    if (households == null || index < 0 || index >= households.length) {
      return;
    }

    _model.currentHouseholdIndex = index;
    final newHomeId = households[index].homeId;
    _model.homeId = newHomeId;

    // 先从已保存的数据中查找该家庭的数据
    final cachedData = _homeService.getHouseholdDataByHomeId(newHomeId);
    if (cachedData != null) {
      // 如果已有缓存数据，直接使用，不需要调用 API
      _model.householdData = cachedData;
      _homeService.updateHomeHouseholdData(cachedData);
      update();
    } else {
      // 如果没有缓存，才调用 API 加载数据
      _model.householdData = null;
      update();
      await startApiProcess();
    }
  }
}
