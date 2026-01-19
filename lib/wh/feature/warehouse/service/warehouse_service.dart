import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/ui/dialog_item_search/dialog_item_search_widget_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/warehouse_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/error_map_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/base_api_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_cabinet_create_request_model/warehouse_cabinet_create_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_cabinet_delete_request_model/warehouse_cabinet_delete_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_cabinet_read_request_model/warehouse_cabinet_read_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_cabinet_update_request_model/warehouse_cabinet_update_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_category_create_request_model/warehouse_category_create_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_category_delete_request_model/warehouse_category_delete_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_category_read_request_model/warehouse_category_read_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_category_update_request_model/warehouse_category_update_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_item_create_request_model/warehouse_item_create_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_item_create_smart_request_model/warehouse_item_create_smart_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_item_delete_request_model/warehouse_item_delete_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_item_edit_normal_request_model/warehouse_item_edit_normal_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_item_edit_position_request_model/warehouse_item_edit_position_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_item_edit_quantity_request_model/warehouse_item_edit_quantity_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_item_request_model/warehouse_item_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_record_read_request_model/warehouse_record_read_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_category_response_model/warehouse_category_response_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item_category.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/room.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/warehouse_item_response_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_smart_response_model/warehouse_item_smart_response_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_record.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_record_response_model/warehouse_record_response_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/api_service/api_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/api_service/api_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/device_service/device_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/router_service/router_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/storage_service/storage_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'warehouse_service_model.dart';

typedef ApiErrorHandler = void Function(BaseApiResponseModel<void> error);

class WarehouseService {
  // MARK: - Properties

  final _model = WarehouseServiceModel();
  ThemeService get _themeService => ThemeService.instance;
  RouterService get _routerService => RouterService.instance;
  String get userId => _model.userId ?? '';
  String get userName => _model.userName ?? '';
  String get userAvatar => _model.userAvatar ?? '';
  String get accessToken => _model.accessToken ?? '';
  String get refreshToken => _model.refreshToken ?? '';
  int get userRoleType => _model.userRoleType ?? -1;
  String get getHouseholdId => _model.household?.id ?? '';
  String get getLocaleCode => LocaleService.instance.getCurrentLocaleCode;

  // 搜尋條件
  DialogItemSearchOutputModel? get getSearchCondition => _model.searchCondition.value;
  RxReadonly<DialogItemSearchOutputModel?> get searchConditionRx => _model.searchCondition.readonly;
  String get getSearchCabinetId => _model.searchCabinetId ?? '';
  // 房間
  List<WarehouseNameIdModel> get rooms => _model.rooms;
  // 櫃位
  List<Room> get getAllRoomCabinets => _model.allRoomCabinets.value ?? [];
  RxReadonly<List<Room>?> get allRoomCabinetsRx => _model.allRoomCabinets.readonly;
  List<RoomCabinetInfo> get getRoomCabinetInfos => _model.roomCabinetInfos;
  // 分類
  RxReadonly<List<Category>?> get allCategoriesRx => _model.allCategories.readonly;
  List<Category> get getAllCategories => _model.allCategories.value ?? <Category>[];

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
      ApiService.unregister();
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

  void addNewCategory(WarehouseNameIdModel category) {
    final newCategories = List<Category>.from(_model.allCategories.value ?? []);
    newCategories.add(Category(id: category.id!, name: category.name!));
    _model.allCategories.value = newCategories;
  }

  Future<T?> showAlert<T>(Widget dialog) async {
    final context = _routerService.getRootNavigatorContext;

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
    CustSnackBar.show(
      context: _routerService.getRootNavigatorContext,
      title: title,
      message: message ?? '',
    );
  }

  // 默认错误处理函数
  void _defaultErrorHandler(BaseApiResponseModel<void> error) {
    if (error.code == EnumErrorMap.code106.code) {
      return;
    }

    showSnackBar(
      title: EnumLocale.commonRequestFailed.tr,
      message: '[${error.code}] ${error.message}',
    );
  }

  // 默认成功处理函数
  void _defaultSuccessHandler([String? message]) {
    showSnackBar(
      title: EnumLocale.commonSuccess.tr,
      message: message ?? '',
    );
  }

  Future<String?> openCamera() async {
    return await DeviceService.instance.openCamera();
  }

  Future<String?> openGallery() async {
    return await DeviceService.instance.openGallery();
  }

  Future<String?> compressImage(String imagePath, {int maxSide = 200}) async {
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

  void setContext(BuildContext context) {
    final service = RouterService.register();
    service.findRootNavigatorContext(context);
    DeviceService.register(context);
  }

  void registerServices(WarehouseMainPageRouterData data) {
    LogService.register();
    final domain = data.domain.endsWith('/') ? data.domain.substring(0, data.domain.length - 1) : data.domain;
    EnvironmentService.register().initData(
      isModuleMode: data.isModuleMode,
      domainUrl: domain,
      accessToken: data.accessToken,
      refreshToken: data.refreshToken,
    );
    ThemeService.register();
    LocaleService.register();
    StorageService.register();
    ApiService.register();
    _model.userName = data.userName;
    _model.userAvatar = data.userAvatar;
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

    if (data.isModuleMode) {
      LocaleService.instance.switchFromCode(data.language);
      ThemeService.instance.switchFromString(data.theme);
    }

    EnvironmentService.instance.switchEnvironment(EnumEnvironment.fromString(data.environment));
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
      _model.searchCondition.value = model;
      changeMainPageSelectedTabItem(EnumWarehouseTabItem.item);
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

  // 取得所有櫃位
  List<Cabinet> getAllCabinets() {
    return _model.allRoomCabinetItems.value?.expand((room) => room.cabinets ?? <Cabinet>[]).toList() ?? [];
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

  // MARK: - Item APIs

  Future<List<Room>?> apiReqReadItems(
    WarehouseItemRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final response = await ApiService.sendRequest<WarehouseItemResponseModel>(
      EnumApiInfo.itemRead,
      requestModel: request,
      fromJson: WarehouseItemResponseModel.fromJson,
      onError: onError ?? _defaultErrorHandler,
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
  }) async {
    final result = await ApiService.sendRequest<BaseApiResponseModel<void>?>(
      EnumApiInfo.itemCreate,
      requestModel: request,
      onError: onError ?? _defaultErrorHandler,
    );
    if (result != null) {
      _defaultSuccessHandler(EnumLocale.warehouseItemCreate.tr);
    }
    return result;
  }

  Future<WarehouseItemSmartResponseModel?> apiReqCreateItemSmart(
    WarehouseItemCreateSmartRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final result = await ApiService.sendRequest<WarehouseItemSmartResponseModel?>(
      EnumApiInfo.itemSmartCreate,
      requestModel: request,
      fromJson: WarehouseItemSmartResponseModel.fromJson,
      onError: onError ?? _defaultErrorHandler,
    );
    if (result != null) {
      _defaultSuccessHandler(EnumLocale.warehouseItemCreate.tr);
    }
    return result;
  }

  Future<BaseApiResponseModel<void>?> apiReqUpdateItemNormal(
    WarehouseItemEditNormalRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final result = await ApiService.sendRequest<BaseApiResponseModel<void>?>(
      EnumApiInfo.itemUpdateNormal,
      requestModel: request,
      onError: onError ?? _defaultErrorHandler,
    );
    if (result != null) {
      _defaultSuccessHandler(EnumLocale.warehouseItemUpdateMessage.tr);
    }
    return result;
  }

  Future<BaseApiResponseModel<void>?> apiReqUpdateItemPosition(
    WarehouseItemEditPositionRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final result = await ApiService.sendRequest<BaseApiResponseModel<void>?>(
      EnumApiInfo.itemUpdatePosition,
      requestModel: request,
      onError: onError ?? _defaultErrorHandler,
    );
    if (result != null) {
      _defaultSuccessHandler(EnumLocale.warehouseItemUpdateMessage.tr);
    }
    return result;
  }

  Future<BaseApiResponseModel<void>?> apiReqUpdateItemQuantity(
    WarehouseItemEditQuantityRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final result = await ApiService.sendRequest<BaseApiResponseModel<void>?>(
      EnumApiInfo.itemUpdateQuantity,
      requestModel: request,
      onError: onError ?? _defaultErrorHandler,
    );
    if (result != null) {
      _defaultSuccessHandler(EnumLocale.warehouseItemUpdateMessage.tr);
    }
    return result;
  }

  Future<BaseApiResponseModel<void>?> apiReqDeleteItem(
    WarehouseItemDeleteRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final result = await ApiService.sendRequest<BaseApiResponseModel<void>?>(
      EnumApiInfo.itemDelete,
      requestModel: request,
      onError: onError ?? _defaultErrorHandler,
    );
    if (result != null) {
      _defaultSuccessHandler(EnumLocale.warehouseItemDelete.tr);
    }
    return result;
  }

  // MARK: - Cabinet APIs

  Future<List<Room>?> apiReqReadCabinets(
    WarehouseCabinetReadRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final response = await ApiService.sendRequest<WarehouseItemResponseModel>(
      EnumApiInfo.cabinetRead,
      requestModel: request,
      fromJson: WarehouseItemResponseModel.fromJson,
      onError: onError ?? _defaultErrorHandler,
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
  }) async {
    final result = await ApiService.sendRequest<Cabinet?>(
      EnumApiInfo.cabinetCreate,
      requestModel: request,
      fromJson: Cabinet.fromJson,
      onError: onError ?? _defaultErrorHandler,
    );
    if (result != null) {
      _defaultSuccessHandler(EnumLocale.warehouseCabinetCreate.tr);
    }
    return result;
  }

  Future<BaseApiResponseModel<void>?> apiReqUpdateCabinet(
    WarehouseCabinetUpdateRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final result = await ApiService.sendRequest<BaseApiResponseModel<void>?>(
      EnumApiInfo.cabinetUpdate,
      requestModel: request,
      onError: onError ?? _defaultErrorHandler,
    );
    if (result != null) {
      _defaultSuccessHandler(EnumLocale.warehouseCabinetUpdateMessage.tr);
    }
    return result;
  }

  Future<BaseApiResponseModel<void>?> apiReqDeleteCabinet(
    WarehouseCabinetDeleteRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final result = await ApiService.sendRequest<BaseApiResponseModel<void>?>(
      EnumApiInfo.cabinetDelete,
      requestModel: request,
      onError: onError ?? _defaultErrorHandler,
    );
    if (result != null) {
      _defaultSuccessHandler(EnumLocale.warehouseCabinetDelete.tr);
    }
    return result;
  }

  // MARK: - Category APIs

  Future<Category?> apiReqCreateCategory(
    WarehouseCategoryCreateRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final result = await ApiService.sendRequest<Category?>(
      EnumApiInfo.categoryCreate,
      requestModel: request,
      fromJson: Category.fromJson,
      onError: onError ?? _defaultErrorHandler,
    );
    if (result != null) {
      _defaultSuccessHandler(EnumLocale.warehouseCategoryCreate.tr);
    }
    return result;
  }

  Future<List<Category>?> apiReqReadCategory(
    WarehouseCategoryReadRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final response = await ApiService.sendRequest<WarehouseCategoryResponseModel>(
      EnumApiInfo.categoryRead,
      requestModel: request,
      fromJson: WarehouseCategoryResponseModel.fromJson,
      onError: onError ?? _defaultErrorHandler,
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
    final result = await ApiService.sendRequest<Category?>(
      EnumApiInfo.categoryUpdate,
      requestModel: request,
      fromJson: Category.fromJson,
      onError: onError ?? _defaultErrorHandler,
    );
    if (result != null) {
      _defaultSuccessHandler(EnumLocale.warehouseCategoryUpdateMessage.tr);
    }
    return result;
  }

  Future<BaseApiResponseModel<void>?> apiReqDeleteCategory(
    WarehouseCategoryDeleteRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final result = await ApiService.sendRequest<BaseApiResponseModel<void>?>(
      EnumApiInfo.categoryDelete,
      requestModel: request,
      onError: onError ?? _defaultErrorHandler,
    );
    if (result != null) {
      _defaultSuccessHandler(EnumLocale.warehouseCategoryDelete.tr);
    }
    return result;
  }

  // MARK: - Log APIs

  Future<List<ItemRecord>?> apiReqReadRecord(
    WarehouseRecordReadRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final response = await ApiService.sendRequest<WarehouseRecordResponseModel>(
      EnumApiInfo.recordRead,
      requestModel: request,
      fromJson: WarehouseRecordResponseModel.fromJson,
      onError: onError ?? _defaultErrorHandler,
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
}
