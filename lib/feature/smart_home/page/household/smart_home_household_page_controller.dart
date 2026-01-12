part of 'smart_home_household_page.dart';

class SmartHomeHouseholdPageController extends GetxController {
  // MARK: - Properties

  final _model = SmartHomeHouseholdPageModel();
  final _homeService = SmartHomeService.instance;
  HomeHouseholdResponseModel? get householdData => _model.householdData;

  // MARK: - Init

  SmartHomeHouseholdPageController() {
    final households = _homeService.getUserData?.household;
    if (households != null && households.isNotEmpty) {
      _model.householdId = households.first.householdId;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadHouseholdData();
    });
  }

  // MARK: - Private Method

  Future<void> _loadHouseholdData() async {
    final response = await _homeService.apiReqReadHomeHousehold(_model.householdId);
    _model.householdData = response;
    update();
  }
}
