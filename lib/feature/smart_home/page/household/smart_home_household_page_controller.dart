part of 'smart_home_household_page.dart';

class SmartHomeHouseholdPageController
    extends BasePageController {
  // MARK: - Properties

  final _model = SmartHomeHouseholdPageModel();
  final _homeService = SmartHomeService.instance;
  HomeHouseholdResponseModel? get householdData =>
      _model.householdData;
  TextEditingController get homeNameController =>
      _model.homeNameController;
  bool get hasHousehold =>
      _model.householdData != null &&
      (_model.householdData?.homeName?.isNotEmpty ?? false);

  // MARK: - Init

  SmartHomeHouseholdPageController() {
    super.init();
    _model.userId = _homeService.getUserData?.id;
    _model.userName = _homeService.getUserData?.userName;
    _model.homeId = _homeService.getUserData?.houseId;
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
    final response = await ApiUtil.sendRequest<
        HomeHouseholdResponseModel>(
      EnumApiInfo.homeFetch,
      requestModel:
          HomeHouseholdRequestModel(homeId: _model.homeId),
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
        requestModel: HomeHouseholdRequestModel()
          ..homeName = homeName,
        fromJson: HomeHouseholdResponseModel.fromJson,
      );

      _model.homeNameController.clear();
      startApiProcess();
    } catch (e) {
      // 错误处理
    }
  }
}
