import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog_item_search/dialog_item_search_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_api_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_request_model/warehouse_cabinet_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_category_request_model/warehouse_category_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_create_request_model/warehouse_item_create_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_request_model/warehouse_item_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_log_request_model/warehouse_log_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/warehouse_category_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
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
  RxReadonly<DialogItemSearchOutputModel?> get searchConditionRx => _model.searchCondition.readonly;
  // 房間
  List<WarehouseNameIdModel> get rooms => _model.rooms;
  List<Room> get getAllRoomCabinetItems => _model.allRoomCabinetItems.value ?? [];
  RxReadonly<List<Room>?> get allRoomCabinetItemsRx => _model.allRoomCabinetItems.readonly;

  // 分類
  RxReadonly<List<Category>?> get allCategoriesRx => _model.allCategories.readonly;
  List<Category> get getAllCategories => allCategoriesRx.value ?? <Category>[];

  // 物品
  // List<Item> get getAllLowStockItems => _model.allLowStockItems.value ?? <Item>[];
  // RxReadonly<List<Item>?> get allLowStockItemsRx => _model.allLowStockItems.readonly;
  List<Item> get getAllCombineItems => _model.allCombineItems ?? <Item>[];
  // Map<String, List<Item>> get getAllGroupItems => _model.allGroupItems ?? <String, List<Item>>{};

  // 記錄
  List<ItemRecord>? get getAllRecords => _model.allRecords;

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
      Get.delete<WarehouseService>(force: true);
    }
  }

  static WarehouseService get instance => register();

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

  Widget? convertFileToImage(String imagePath, {double? fitWidth, double? fitHeight}) {
    return _themeService.convertFileToImage(imagePath, fitWidth: fitWidth, fitHeight: fitHeight);
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
  }

  // List<DialogItemInfoRoomModel> filterItemFromRooms(Item item) {
  //   final allRooms = _model.allRoomCabinetItems.value;

  //   if (allRooms == null || (item.id?.isEmpty ?? true)) {
  //     return [];
  //   }

  //   final result = <DialogItemInfoRoomModel>[];
  //   final itemId = item.id!;

  //   for (final room in allRooms) {
  //     if (room.cabinets?.isEmpty ?? true) {
  //       continue;
  //     }

  //     final matchingCabinets = <DialogItemInfoCabinetModel>[];

  //     for (final cabinet in room.cabinets!) {
  //       if (cabinet.items?.isEmpty ?? true) {
  //         continue;
  //       }

  //       final matchingItem = cabinet.items!.where((i) => i.id == itemId).firstOrNull;

  //       if (matchingItem != null) {
  //         matchingCabinets.add(
  //           DialogItemInfoCabinetModel(
  //             cabinetId: cabinet.id ?? '',
  //             cabinetName: cabinet.name ?? EnumLocale.warehouseUncategorized.tr,
  //             quantity: matchingItem.quantity ?? 0,
  //           ),
  //         );
  //       }
  //     }

  //     if (matchingCabinets.isNotEmpty) {
  //       final roomInfo = _model.rooms.where((r) => r.id == room.roomId).firstOrNull;

  //       result.add(
  //         DialogItemInfoRoomModel(
  //           roomId: roomInfo?.id ?? '',
  //           roomName: roomInfo?.name ?? EnumLocale.warehouseUncategorized.tr,
  //           cabinets: matchingCabinets,
  //         ),
  //       );
  //     }
  //   }

  //   return result;
  // }

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
        extractCategories(category.children);
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
      _model.searchCondition.value = model;
    }
  }

  // 清除搜尋條件
  void clearSearchCondition() {
    _model.searchCondition.value = null;
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

  // MARK: - Item APIs

  Future<List<Room>?> apiReqFetchItems(
    WarehouseItemRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    _model.allRoomCabinetItems.value = null;
    final response = await ApiUtil.sendRequest<WarehouseItemResponseModel>(
      EnumApiInfo.itemFetch,
      requestModel: request,
      fromJson: WarehouseItemResponseModel.fromJson,
      onError: onError,
    );
    _model.allRoomCabinetItems.value = response?.data;
    _genAllCombineItems();
    return response?.data;
  }

  Future<ApiEmptyResponse?> apiReqCreateItem(
    WarehouseItemCreateRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<ApiEmptyResponse>(
      EnumApiInfo.itemCreate,
      requestModel: request,
      onError: onError,
    );
  }

  Future<ApiEmptyResponse?> apiReqModifyItem(
    WarehouseItemRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<ApiEmptyResponse>(
      EnumApiInfo.itemModify,
      requestModel: request,
      onError: onError,
    );
  }

  Future<ApiEmptyResponse?> apiReqDeleteItem(
    WarehouseItemRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<ApiEmptyResponse>(
      EnumApiInfo.itemDelete,
      requestModel: request,
      onError: onError,
    );
  }

  void changeMainPageSelectedTabItem(EnumWarehouseTabItem item) {
    _model.mainPageSelectedTabItem.value = item;
  }

  // MARK: - Cabinet APIs

  Future<List<Room>?> apiReqFetchCabinets(
    WarehouseCabinetRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final response = await ApiUtil.sendRequest<WarehouseItemResponseModel>(
      EnumApiInfo.cabinetFetch,
      requestModel: request,
      fromJson: WarehouseItemResponseModel.fromJson,
      onError: onError,
    );
    return response?.data;
  }

  Future<ApiEmptyResponse?> apiReqCreateCabinet(
    WarehouseCabinetRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<ApiEmptyResponse>(
      EnumApiInfo.cabinetCreate,
      requestModel: request,
      onError: onError,
    );
  }

  Future<ApiEmptyResponse?> apiReqModifyCabinet(
    WarehouseCabinetRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<ApiEmptyResponse>(
      EnumApiInfo.cabinetModify,
      requestModel: request,
      onError: onError,
    );
  }

  Future<ApiEmptyResponse?> apiReqDeleteCabinet(
    WarehouseCabinetRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<ApiEmptyResponse>(
      EnumApiInfo.cabinetDelete,
      requestModel: request,
      onError: onError,
    );
  }

  // MARK: - Category APIs

  Future<List<Category>?> apiReqFetchCategories(
    WarehouseCategoryRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final response = await ApiUtil.sendRequest<WarehouseCategoryResponseModel>(
      EnumApiInfo.categoryFetch,
      requestModel: request,
      fromJson: WarehouseCategoryResponseModel.fromJson,
      onError: onError,
    );
    _model.allCategories.value = response?.data;
    return response?.data;
  }

  Future<ApiEmptyResponse?> apiReqCreateCategory(
    WarehouseCategoryRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<ApiEmptyResponse>(
      EnumApiInfo.categoryCreate,
      requestModel: request,
      onError: onError,
    );
  }

  Future<ApiEmptyResponse?> apiReqModifyCategory(
    WarehouseCategoryRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<ApiEmptyResponse>(
      EnumApiInfo.categoryModify,
      requestModel: request,
      onError: onError,
    );
  }

  Future<ApiEmptyResponse?> apiReqDeleteCategory(
    WarehouseCategoryRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<ApiEmptyResponse>(
      EnumApiInfo.categoryDelete,
      requestModel: request,
      onError: onError,
    );
  }

  // MARK: - Log APIs

  Future<List<ItemRecord>?> apiReqFetchLogs(
    WarehouseRecordRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final response = await ApiUtil.sendRequest<WarehouseRecordResponseModel>(
      EnumApiInfo.logFetch,
      requestModel: request,
      fromJson: WarehouseRecordResponseModel.fromJson,
      onError: onError,
    );
    _model.allRecords = response?.data;
    return response?.data ?? [];
  }

  Future<ApiEmptyResponse?> apiReqCreateLog(
    WarehouseRecordRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<ApiEmptyResponse>(
      EnumApiInfo.logCreate,
      requestModel: request,
      onError: onError,
    );
  }

  Future<ApiEmptyResponse?> apiReqDeleteLog(
    WarehouseRecordRequestModel request, {
    ApiErrorHandler? onError,
  }) {
    return ApiUtil.sendRequest<ApiEmptyResponse>(
      EnumApiInfo.logDelete,
      requestModel: request,
      onError: onError,
    );
  }

  // MARK: - Private Method

  void _genAllCombineItems() {
    final flattenItems =
        _model.allRoomCabinetItems.value?.expand((room) => room.cabinets ?? <Cabinet>[]).expand((cabinet) => cabinet.items ?? <Item>[]).toList() ??
            [];
    _model.allCombineItems = combineItems(flattenItems);
  }

  // void _genGroupItems() {
  //   final flattenItems =
  //       _model.allRoomCabinetItems.value?.expand((room) => room.cabinets ?? <Cabinet>[]).expand((cabinet) => cabinet.items ?? <Item>[]).toList() ??
  //           [];
  //   Map<String, List<Item>> groupItems = {};

  //   for (var item in flattenItems) {
  //     if (item.id?.isNotEmpty ?? false) {
  //       groupItems.putIfAbsent(item.id!, () => []).add(item);
  //     }
  //   }

  //   _model.allGroupItems = groupItems;
  // }

  // void _genAllLowStockItems() {
  //   final List<Item> lowStockItems = <Item>[];

  //   for (final map in getAllGroupItems.entries) {
  //     final items = map.value;
  //     final totalQuantity = items.fold(0, (sum, item) => sum + (item.quantity ?? 0));
  //     if (totalQuantity < (items.first.minStockAlert ?? 0)) {
  //       lowStockItems.add(items.first.copyWith(quantity: totalQuantity));
  //     }
  //   }

  //   _model.allLowStockItems.value = lowStockItems;
  // }
}
