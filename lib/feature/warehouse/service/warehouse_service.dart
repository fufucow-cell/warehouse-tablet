import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_api_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_request_model/warehouse_cabinet_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_category_request_model/warehouse_category_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_request_model/warehouse_item_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_log_request_model/warehouse_log_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/warehouse_category_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/room.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/warehouse_item_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_record.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/warehouse_record_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/api_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/locale_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/theme_util.dart';
import 'package:get/get.dart';

part 'warehouse_service_model.dart';

typedef ApiErrorHandler = void Function(BaseApiResponseModel<void> error);

class WarehouseService {
  // MARK: - Properties

  final _model = WarehouseServiceModel();
  String? get userId => _model.userId;
  String? get userName => _model.userName;
  String? get accessToken => _model.accessToken;
  String? get refreshToken => _model.refreshToken;
  WarehouseNameIdModel? get house => _model.house;
  List<WarehouseNameIdModel> get rooms => _model.rooms;
  int? get userRoleType => _model.userRoleType;
  List<Room>? get getAllRoomCabinetItems => _model.allRoomCabinetItems;
  List<ItemRecord>? get getAllRecords => _model.allRecords;
  List<Category>? get getAllCategories => _model.allCategories;

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

  void updateData(WarehouseMainPageRouterData data) {
    _model.userName = data.userName;
    _model.accessToken = data.accessToken;
    _model.refreshToken = data.refreshToken;
    _model.userRoleType = data.userRoleType;
    _model.house = WarehouseNameIdModel(
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

  // MARK: - Item APIs

  Future<List<Room>?> apiReqFetchItems(
    WarehouseItemRequestModel request, {
    ApiErrorHandler? onError,
  }) async {
    final response = await ApiUtil.sendRequest<WarehouseItemResponseModel>(
      EnumApiInfo.itemFetch,
      requestModel: request,
      fromJson: WarehouseItemResponseModel.fromJson,
      onError: onError,
    );
    _model.allRoomCabinetItems = response?.data;
    return response?.data;
  }

  Future<ApiEmptyResponse?> apiReqCreateItem(
    WarehouseItemRequestModel request, {
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
      onError: ((e) {
        print(e);
      }),
    );
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
}
