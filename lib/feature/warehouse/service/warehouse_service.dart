import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog_item_search/dialog_item_search_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_api_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_create_request_model/warehouse_cabinet_create_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_read_request_model/warehouse_cabinet_read_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_update_request_model/warehouse_cabinet_update_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_category_create_request_model/warehouse_category_create_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_category_delete_request_model/warehouse_category_delete_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_category_read_request_model/warehouse_category_read_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_category_update_request_model/warehouse_category_update_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_create_request_model/warehouse_item_create_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_delete_request_model/warehouse_item_delete_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_edit_normal_request_model/warehouse_item_edit_normal_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_edit_position_request_model/warehouse_item_edit_position_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_edit_quantity_request_model/warehouse_item_edit_quantity_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_request_model/warehouse_item_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_record_read_request_model/warehouse_record_read_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/warehouse_category_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item_category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/room.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/warehouse_item_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_record.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/warehouse_record_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/api_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/device_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/locale_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/theme_util.dart';
import 'package:get/get.dart';

part 'warehouse_service_model.dart';

typedef ApiErrorHandler = void Function(BaseApiResponseModel<void> error);

class WarehouseService {
  // MARK: - Properties

  final _model = WarehouseServiceModel();
  final _logService = LogUtil.instance;
  final _deviceService = DeviceUtil.instance;
  final _themeService = ThemeUtil.instance;
  String get userId => _model.userId ?? '';
  String get userName => _model.userName ?? '';
  String get accessToken => _model.accessToken ?? '';
  String get refreshToken => _model.refreshToken ?? '';
  int get userRoleType => _model.userRoleType ?? -1;
  String get getHouseholdId => _model.household?.id ?? '';

  // 搜尋條件
  DialogItemSearchOutputModel? get getSearchCondition => _model.searchCondition;
  String get getSearchCabinetId => _model.searchCabinetId ?? '';
  // 房間
  List<WarehouseNameIdModel> get rooms => _model.rooms;
  // 櫃位
  List<Room> get getAllRoomCabinets => _model.allRoomCabinets.value ?? [];
  RxReadonly<List<Room>?> get allRoomCabinetsRx => _model.allRoomCabinets.readonly;
  List<RoomCabinetInfo> get roomCabinetInfos => _model.roomCabinetInfos;
  // 分類
  RxReadonly<List<Category>?> get allCategoriesRx => _model.allCategories.readonly;
  List<Category> get getAllCategories => allCategoriesRx.value ?? <Category>[];

  // 物品
  List<Item> get getAllCombineItems => _model.allCombineItems ?? <Item>[];
  List<Room> get getAllRoomCabinetItems => _model.allRoomCabinetItems.value ?? [];
  RxReadonly<List<Room>?> get allRoomCabinetItemsRx => _model.allRoomCabinetItems.readonly;

  // 記錄
  List<ItemRecord> get getAllRecords => _model.allRecords.value ?? <ItemRecord>[];
  RxReadonly<List<ItemRecord>?> get allRecordsRx => _model.allRecords.readonly;

  // Tab 選擇
  RxReadonly<EnumWarehouseTabItem> get mainPageSelectedTabItemRx => _model.mainPageSelectedTabItem.readonly;

  // MARK: - Init

  WarehouseService._internal();

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
      ApiUtil.unregister();
      Get.delete<WarehouseService>(force: true);
    }
  }

  static WarehouseService get instance {
    if (!Get.isRegistered<WarehouseService>()) {
      return register();
    }
    return Get.find<WarehouseService>();
  }

  // MARK: - Public Method

  void setRootContext(BuildContext context) {
    _model.rootContext = context;
  }

  Future<T?> showAlert<T>(Widget dialog) async {
    final context = _model.rootContext;

    if (context == null) {
      return null;
    }

    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (context) => dialog,
    );
  }

  void showSnackBar({required String title, String? message}) {
    _logService.showSnackBar(title: title, message: message ?? '');
  }

  Future<String?> openCamera() async {
    return await _deviceService.openCamera();
  }

  Future<String?> openGallery() async {
    return await _deviceService.openGallery();
  }

  Future<String?> compressImage(String imagePath, {int maxSide = 100}) async {
    return await _themeService.compressImageFile(imagePath, maxSide: maxSide);
  }

  Widget? convertFileToImage(
    String imagePath, {
    double? fitWidth,
    double? fitHeight,
  }) {
    return _themeService.convertFileToImage(
      imagePath,
      fitWidth: fitWidth,
      fitHeight: fitHeight,
    );
  }

  Future<String?> convertFileToBase64(String imagePath) async {
    return await _themeService.convertFileToBase64(imagePath);
  }

  void updateData(WarehouseMainPageRouterData data) {
    _model.userName = data.userName;
    _model.accessToken = data.accessToken;
    _model.refreshToken = data.refreshToken;
    _model.userRoleType = data.userRoleType;
    _model.household = WarehouseNameIdModel(
      id: data.household.id,
      name: data.household.name,
    );
    _model.rooms = data.rooms
        .map(
          (room) => WarehouseNameIdModel(
            id: room.id,
            name: room.name,
          ),
        )
        .toList();
    LocaleUtil.instance.switchFromCode(data.language);
    ThemeUtil.instance.switchFromString(data.theme);
    final domain = data.domain.endsWith('/') ? data.domain.substring(0, data.domain.length - 1) : data.domain;
    _registerWarehouseApiUtil(domain);
  }

  // 產出物品所在的房間與櫥櫃
  List<ItemPositionModel> genItemPositionsFromRoomCabinet(Item? item) {
    final allRoomCabinetItems = getAllRoomCabinetItems;
    final result = <ItemPositionModel>[];

    if (allRoomCabinetItems.isEmpty || (item?.id?.isEmpty ?? true)) {
      return [];
    }

    for (final room in allRoomCabinetItems) {
      if (room.cabinets?.isEmpty ?? true) {
        continue;
      }

      final matchCabinets = <ItemPositionCabinetModel>[];

      for (final cabinet in room.cabinets!) {
        if (cabinet.items?.isEmpty ?? true) {
          continue;
        }

        final matchItem = cabinet.items!.where((i) => i.id == item?.id).firstOrNull;

        if (matchItem != null) {
          matchCabinets.add(
            ItemPositionCabinetModel(
              id: cabinet.id ?? '',
              name: cabinet.name ?? EnumLocale.warehouseUnboundCabinet.tr,
              quantity: matchItem.quantity ?? 0,
            ),
          );
        }
      }

      if (matchCabinets.isNotEmpty) {
        final roomInfo = rooms.where((e) => e.id == room.roomId).firstOrNull;

        result.add(
          ItemPositionModel(
            roomId: roomInfo?.id ?? '',
            roomName: roomInfo?.name ?? EnumLocale.warehouseUnboundRoom.tr,
            cabinets: matchCabinets,
          ),
        );
      }
    }

    return result;
  }

  String convertCategoriesName(Item? item) {
    if (item == null) {
      return EnumLocale.warehouseUncategorized.tr;
    }

    List<String> names = [];

    void extractCategories(dynamic category) {
      if (category != null) {
        final categoryName = category.name;
        if (categoryName != null && categoryName is String) {
          names.add(categoryName);
        } else if (categoryName != null) {
          names.add(categoryName.toString());
        }
        // ItemCategory 使用 child，Category 使用 children
        if (category is ItemCategory) {
          extractCategories(category.child);
        } else if (category is Category) {
          final children = category.children;
          if (children != null && children.isNotEmpty) {
            extractCategories(children.first);
          }
        }
      }
    }

    extractCategories(item.category);
    return names.join(' > ');
  }

  // 釋放鍵盤
  void dismissKeyboard() {
    final primaryFocus = FocusManager.instance.primaryFocus;
    if (primaryFocus != null) {
      final focusContext = primaryFocus.context;

      if (focusContext != null) {
        if (focusContext.findAncestorWidgetOfExactType<TextField>() != null) {
          primaryFocus.unfocus();
        }
      } else {
        primaryFocus.unfocus();
      }
    }
  }

  // 添加搜尋條件
  void addSearchCondition(DialogItemSearchOutputModel model) {
    if ((model.searchText?.isNotEmpty ?? false) || model.categoryLevel1 != null) {
      _model.searchCondition = model;
      changeMainPageSelectedTabItem(EnumWarehouseTabItem.item);
    }
  }

  // 清除搜尋條件
  void clearSearchCondition() {
    _model.searchCondition = null;
  }

  List<Item> combineItems(List<Item> oldItems) {
    Map<String, List<Item>> groupItems = {};
    final newItems = <Item>[];

    for (var item in oldItems) {
      if (item.id?.isNotEmpty ?? false) {
        groupItems.putIfAbsent(item.id!, () => []).add(item);
      }
    }

    for (var entry in groupItems.entries) {
      final items = entry.value;

      if (items.isEmpty) {
        continue;
      }

      final totalQuantity = items.fold<int>(
        0,
        (sum, item) => sum + (item.quantity ?? 0),
      );

      final combinedItem = items.first.copyWith(quantity: totalQuantity);
      newItems.add(combinedItem);
    }

    return newItems;
  }

  List<Category> flattenAllLevel2Categories() {
    final result = <Category>[];

    for (final cat in getAllCategories) {
      if (cat.children?.isNotEmpty ?? false) {
        result.addAll(cat.children!);
      }
    }

    return result;
  }

  List<Category> flattenAllLevel3Categories() {
    final result = <Category>[];

    for (final cat in flattenAllLevel2Categories()) {
      if (cat.children?.isNotEmpty ?? false) {
        result.addAll(cat.children!);
      }
    }

    return result;
  }

  // 取得所有櫃位
  List<Cabinet> getAllCabinets() {
    return _model.allRoomCabinetItems.value?.expand((room) => room.cabinets ?? <Cabinet>[]).toList() ?? [];
  }

  // MARK: - Item APIs

  Future<List<Room>?> apiReqReadItems(
    WarehouseItemRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final response = await ApiUtil.sendRequest<WarehouseItemResponseModel>(
      EnumApiInfo.itemRead,
      requestModel: request,
      fromJson: WarehouseItemResponseModel.fromJson,
      onError: onError,
    );

    if (response?.data != null && request.roomId == null && request.cabinetId == null && request.categoryId == null && request.itemId == null) {
      _model.allRoomCabinetItems.value = response?.data;
      _genAllCombineItems();
    }

    return response?.data;
  }

  Future<BaseApiResponseModel<void>?> apiReqCreateItem(
    WarehouseItemCreateRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<BaseApiResponseModel<void>?>(
      EnumApiInfo.itemCreate,
      requestModel: request,
      onError: onError,
    );
  }

  Future<BaseApiResponseModel<void>?> apiReqUpdateItemNormal(
    WarehouseItemEditNormalRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<BaseApiResponseModel<void>?>(
      EnumApiInfo.itemUpdateNormal,
      requestModel: request,
      onError: onError,
    );
  }

  Future<BaseApiResponseModel<void>?> apiReqUpdateItemPosition(
    WarehouseItemEditPositionRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<BaseApiResponseModel<void>?>(
      EnumApiInfo.itemUpdatePosition,
      requestModel: request,
      onError: onError,
    );
  }

  Future<BaseApiResponseModel<void>?> apiReqUpdateItemQuantity(
    WarehouseItemEditQuantityRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<BaseApiResponseModel<void>?>(
      EnumApiInfo.itemUpdateQuantity,
      requestModel: request,
      onError: onError,
    );
  }

  Future<BaseApiResponseModel<void>?> apiReqDeleteItem(
    WarehouseItemDeleteRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<BaseApiResponseModel<void>?>(
      EnumApiInfo.itemDelete,
      requestModel: request,
      onError: onError,
    );
  }

  void clearSearchCabinetId() {
    _model.searchCabinetId = null;
  }

  void changeMainPageSelectedTabItem(
    EnumWarehouseTabItem item, {
    dynamic data,
  }) {
    switch (item) {
      case EnumWarehouseTabItem.item:
        if (data is String) {
          _model.searchCabinetId = data;
        }
      default:
        break;
    }

    _model.mainPageSelectedTabItem.value = item;
  }

  // MARK: - Cabinet APIs

  Future<List<Room>?> apiReqReadCabinets(
    WarehouseCabinetReadRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final response = await ApiUtil.sendRequest<WarehouseItemResponseModel>(
      EnumApiInfo.cabinetRead,
      requestModel: request,
      fromJson: WarehouseItemResponseModel.fromJson,
      onError: onError,
    );

    if (response?.data != null && request.roomId == null && request.cabinetId == null) {
      _genRoomCabinetInfo(response!.data!);
      _model.allRoomCabinets.value = response.data!;
    }

    return response?.data;
  }

  Future<Cabinet?> apiReqCreateCabinet(
    WarehouseCabinetCreateRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<Cabinet?>(
      EnumApiInfo.cabinetCreate,
      requestModel: request,
      fromJson: Cabinet.fromJson,
      onError: onError,
    );
  }

  Future<BaseApiResponseModel<void>?> apiReqUpdateCabinet(
    WarehouseCabinetUpdateRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<BaseApiResponseModel<void>?>(
      EnumApiInfo.cabinetUpdate,
      requestModel: request,
      onError: onError,
    );
  }

  // MARK: - Category APIs

  Future<Category?> apiReqCreateCategory(
    WarehouseCategoryCreateRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    return await ApiUtil.sendRequest<Category?>(
      EnumApiInfo.categoryCreate,
      requestModel: request,
      fromJson: Category.fromJson,
      onError: onError,
    );
  }

  Future<List<Category>?> apiReqReadCategory(
    WarehouseCategoryReadRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final response = await ApiUtil.sendRequest<WarehouseCategoryResponseModel>(
      EnumApiInfo.categoryRead,
      requestModel: request,
      fromJson: WarehouseCategoryResponseModel.fromJson,
      onError: onError,
    );

    if (request.categoryId == null && response?.data != null) {
      _model.allCategories.value = response?.data;
    }

    return response?.data;
  }

  Future<Category?> apiReqUpdateCategory(
    WarehouseCategoryUpdateRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    return await ApiUtil.sendRequest<Category?>(
      EnumApiInfo.categoryUpdate,
      requestModel: request,
      fromJson: Category.fromJson,
      onError: onError,
    );
  }

  Future<BaseApiResponseModel<void>?> apiReqDeleteCategory(
    WarehouseCategoryDeleteRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    return await ApiUtil.sendRequest<BaseApiResponseModel<void>?>(
      EnumApiInfo.categoryDelete,
      requestModel: request,
      onError: onError,
    );
  }

  // MARK: - Log APIs

  Future<List<ItemRecord>?> apiReqReadRecord(
    WarehouseRecordReadRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final response = await ApiUtil.sendRequest<WarehouseRecordResponseModel>(
      EnumApiInfo.recordRead,
      requestModel: request,
      fromJson: WarehouseRecordResponseModel.fromJson,
      onError: onError,
    );

    if (response?.data != null && request.itemId == null) {
      _model.allRecords.value = response?.data;
    }

    return response?.data;
  }

  // MARK: - Private Method

  void _genRoomCabinetInfo(List<Room> resRooms) {
    final result = <RoomCabinetInfo>[];

    for (WarehouseNameIdModel room in _model.rooms) {
      final roomMatch = resRooms.firstWhereOrNull((r) => r.roomId == room.id);
      List<CabinetInfo> cabinets = [];

      if (roomMatch != null) {
        cabinets = roomMatch.cabinets?.map<CabinetInfo>((cabinet) {
              return CabinetInfo(
                cabinetId: cabinet.id ?? '',
                cabinetName: cabinet.name ?? EnumLocale.warehouseUnboundCabinet.tr,
                quantity: cabinet.quantity ?? 0,
              );
            }).toList() ??
            [];
      }

      result.add(
        RoomCabinetInfo(
          roomId: room.id ?? '',
          roomName: room.name ?? EnumLocale.warehouseUnboundRoom.tr,
          quantity: roomMatch?.quantity ?? 0,
          cabinets: cabinets,
        ),
      );
    }

    final unboundRoom = resRooms.firstWhereOrNull((r) => r.roomId?.isEmpty ?? true);

    if (unboundRoom != null && (unboundRoom.cabinets?.isNotEmpty ?? false)) {
      result.add(
        RoomCabinetInfo(
          roomId: '',
          roomName: EnumLocale.warehouseUnboundRoom.tr,
          quantity: 0,
          cabinets: unboundRoom.cabinets?.map<CabinetInfo>((cabinet) {
                return CabinetInfo(
                  cabinetId: cabinet.id ?? '',
                  cabinetName: cabinet.name ?? EnumLocale.warehouseUnboundCabinet.tr,
                  quantity: cabinet.quantity ?? 0,
                );
              }).toList() ??
              [],
        ),
      );
    }

    _model.roomCabinetInfos = result;
  }

  void _genAllCombineItems() {
    final flattenItems =
        _model.allRoomCabinetItems.value?.expand((room) => room.cabinets ?? <Cabinet>[]).expand((cabinet) => cabinet.items ?? <Item>[]).toList() ??
            [];
    _model.allCombineItems = combineItems(flattenItems);
  }

  void _registerWarehouseApiUtil(String baseUrl) {
    ApiUtil.register(baseUrl);
  }
}
