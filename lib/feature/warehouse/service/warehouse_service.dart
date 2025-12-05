import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:get/get.dart';

part 'warehouse_service_model.dart';

class WarehouseService {
  // MARK: - Properties

  final _model = WarehouseServiceModel();
  String? get userId => _model.userId;
  String? get userName => _model.userName;
  String? get language => _model.language;
  int? get theme => _model.theme;
  String? get accessToken => _model.accessToken;
  String? get refreshToken => _model.refreshToken;
  WarehouseHomeModel? get house => _model.house;
  List<WarehouseHomeModel> get rooms => _model.rooms;
  int? get userRoleType => _model.userRoleType;

  // MARK: - Init

  WarehouseService._internal();

  // MARK: - Public Method

  static WarehouseService register() {
    if (Get.isRegistered<WarehouseService>()) {
      return Get.find<WarehouseService>();
    } else {
      final service = WarehouseService._internal();
      Get.put<WarehouseService>(service, permanent: true);
      return service;
    }
  }

  static void unregister() {
    if (Get.isRegistered<WarehouseService>()) {
      Get.delete<WarehouseService>(force: true);
    }
  }

  static WarehouseService get instance => register();

  void updateData(WarehouseMainPageRouterData data) {
    _model.userId = data.userId;
    _model.userName = data.userName;
    _model.language = data.language;
    _model.theme = data.theme;
    _model.accessToken = data.accessToken;
    _model.refreshToken = data.refreshToken;
    _model.userRoleType = data.userRoleType;
    _model.house = WarehouseHomeModel(
      id: data.household.id,
      name: data.household.name,
    );
    _model.rooms = data.rooms
        .map(
          (room) => WarehouseHomeModel(
            id: room.id,
            name: room.name,
          ),
        )
        .toList();
  }
}
