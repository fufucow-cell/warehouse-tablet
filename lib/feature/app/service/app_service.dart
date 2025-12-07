import 'package:flutter_smart_home_tablet/model/response_model/user_login_response_model/user_login_response_model.dart';
import 'package:get/get.dart';

part 'app_service_model.dart';

class AppService {
  // MARK: - Properties

  final _model = AppServiceModel();
  UserLoginResponseModel? get getUserData => _model.userLoginData;

  // MARK: - Init

  AppService._internal();

  // MARK: - Public Method

  static AppService register() {
    if (Get.isRegistered<AppService>()) {
      return Get.find<AppService>();
    } else {
      final service = AppService._internal();
      Get.put<AppService>(service, permanent: true);
      return service;
    }
  }

  static void unregister() {
    if (Get.isRegistered<AppService>()) {
      Get.delete<AppService>(force: true);
    }
  }

  static AppService get instance => register();

  void updateUserLoginData(UserLoginResponseModel? data) {
    _model.userLoginData = data;
  }
}
