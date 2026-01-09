// 扁平化所有櫥櫃
import 'package:collection/collection.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';

class CabinetUtil {
  static final _service = WarehouseService.instance;

  // 取得所有房間名稱
  static List<String> getRoomNameList({bool includeUnboundRoom = false}) {
    if (includeUnboundRoom) {
      return _service.getRoomCabinetInfos.map((room) => room.roomName).toList();
    } else {
      return _service.getRoomCabinetInfos
          .where((room) => room.roomId.isNotEmpty)
          .map((room) => room.roomName)
          .toList();
    }
  }

  // 扁平化所有櫥櫃
  static List<CabinetInfo> flattenAllCabinets(
      {bool includeUnboundRoom = false}) {
    if (includeUnboundRoom) {
      return _service.getRoomCabinetInfos
          .expand<CabinetInfo>((room) => room.cabinets)
          .toList();
    } else {
      return _service.getRoomCabinetInfos
          .where((room) => room.roomId.isNotEmpty)
          .expand<CabinetInfo>((room) => room.cabinets)
          .toList();
    }
  }

  // 指定房間下所有櫥櫃
  static List<CabinetInfo> getAllCabinetsFromRoom(
      {String? roomId, String? roomName}) {
    RoomCabinetInfo? roomCabinetInfos;

    if (roomName?.isNotEmpty ?? false) {
      roomCabinetInfos = _service.getRoomCabinetInfos
          .firstWhereOrNull((room) => room.roomName == roomName);
    }

    roomCabinetInfos = _service.getRoomCabinetInfos
        .firstWhereOrNull((room) => room.roomId == (roomId ?? ''));
    return roomCabinetInfos?.cabinets ?? [];
  }

  // 取得房間名稱經由櫃位 ID
  static String? getRoomNameByCabinetId(String? cabinetId) {
    for (final room in _service.getRoomCabinetInfos) {
      for (final cabinet in room.cabinets) {
        if (cabinet.cabinetId == cabinetId) {
          return room.roomName;
        }
      }
    }

    return null;
  }

  // 比對房間
  static RoomCabinetInfo? getRoomByName(String? roomName) {
    return _service.getRoomCabinetInfos
        .firstWhereOrNull((room) => room.roomName == roomName);
  }

  // 比對櫃位
  static CabinetInfo? getCabinetByName(String? cabinetName) {
    return flattenAllCabinets(includeUnboundRoom: true)
        .firstWhereOrNull((cabinet) => cabinet.cabinetName == cabinetName);
  }

  // 取得可顯示的櫃位名稱
  static List<String> getVisibleCabinetNameList(String? roomName,
      {bool includeUnboundRoom = false}) {
    if ((roomName?.isEmpty ?? true) ||
        roomName == EnumLocale.optionPleaseSelectRoom.tr ||
        roomName == EnumLocale.optionPleaseSelect.tr) {
      return flattenAllCabinets(includeUnboundRoom: includeUnboundRoom)
          .map((cabinet) => cabinet.cabinetName)
          .toList();
    }

    final matchRoom = _service.getRoomCabinetInfos
        .firstWhereOrNull((room) => room.roomName == roomName);
    final visibleCabinets =
        matchRoom?.cabinets.map((cabinet) => cabinet.cabinetName).toList() ??
            [];
    return visibleCabinets;
  }

  static List<WarehouseNameIdModel> getCabinetsFromRoomNameId(
      WarehouseNameIdModel? room) {
    if (room == null) {
      return flattenAllCabinets()
          .map(
            (cabinet) => WarehouseNameIdModel(
              id: cabinet.cabinetId,
              name: cabinet.cabinetName,
            ),
          )
          .toList();
    }

    return _service.getAllRoomCabinetItems
            .firstWhereOrNull((e) => e.roomId == room.id)
            ?.cabinets
            ?.map(
              (cabinet) => WarehouseNameIdModel(
                id: cabinet.id ?? '',
                name: cabinet.name ?? '',
              ),
            )
            .toList() ??
        [];
  }
}
