import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:get/get.dart';

class UserData {
  // properties

  String? _userId;
  String? get userId => _userId;

  String? _userName;
  String? get userName => _userName;

  String? _language;
  String? get language => _language;

  int? _theme;
  int? get theme => _theme;

  String? _accessToken;
  String? get accessToken => _accessToken;

  String? _refreshToken;
  String? get refreshToken => _refreshToken;

  Household? _house;
  Household? get house => _house;

  List<Room> _rooms = [];
  List<Room> get rooms => _rooms;

  int? _userRoleType;
  int? get userRoleType => _userRoleType;

  // Init

  UserData._internal();

  // Public Method

  static UserData register() {
    if (Get.isRegistered<UserData>()) {
      return Get.find<UserData>();
    } else {
      final service = UserData._internal();
      Get.put<UserData>(service, permanent: true);
      return service;
    }
  }

  static void unregister() {
    if (Get.isRegistered<UserData>()) {
      Get.delete<UserData>(force: true);
    }
  }

  void updateData(WarehouseMainPageRouterData data) {
    _userId = data.userId;
    _userName = data.userName;
    _language = data.language;
    _theme = data.theme;
    _accessToken = data.accessToken;
    _refreshToken = data.refreshToken;
    _userRoleType = data.userRoleType;

    // 转换 WarehouseMainRouterHousehold 为 Household
    _house = Household(
      id: data.household.id,
      name: data.household.name,
    );

    // 转换 WarehouseMainRouterRoom 列表为 Room 列表
    _rooms = data.rooms
        .map(
          (room) => Room(
            id: room.id,
            name: room.name,
          ),
        )
        .toList();
  }

  void updateUserId(String userId) {
    _userId = userId;
  }

  void updateUserName(String userName) {
    _userName = userName;
  }

  void updateLanguage(String language) {
    _language = language;
  }

  void updateTheme(int theme) {
    _theme = theme;
  }

  void updateAccessToken(String accessToken) {
    _accessToken = accessToken;
  }

  void updateRefreshToken(String refreshToken) {
    _refreshToken = refreshToken;
  }

  void updateHouse(Household house) {
    _house = house;
  }

  void updateRooms(List<Room> rooms) {
    _rooms = rooms;
  }

  void updateUserRoleType(int userRoleType) {
    _userRoleType = userRoleType;
  }
}

class Household {
  final String id;
  final String name;

  const Household({
    required this.id,
    required this.name,
  });
}

class Room {
  final String id;
  final String name;

  const Room({
    required this.id,
    required this.name,
  });
}
