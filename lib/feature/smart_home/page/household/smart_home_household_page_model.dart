part of 'smart_home_household_page.dart';

class SmartHomeHouseholdPageModel {
  String? userId;
  String? userName;
  String? homeId;
  HomeHouseholdResponseModel? householdData;
  final homeNameController = TextEditingController();
  int currentHouseholdIndex = 0;
}
