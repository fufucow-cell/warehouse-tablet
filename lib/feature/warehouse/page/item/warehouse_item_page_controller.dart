import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_position/dialog_item_edit_position_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_position/dialog_item_edit_position_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_quantity/dialog_item_edit_quantity_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_edit_quantity/dialog_item_edit_quantity_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_info/dialog_item_info_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_normal_edit/dialog_item_normal_edit_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_normal_edit/dialog_item_normal_edit_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/warehouse_item_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog_item_search/dialog_item_search_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_edit_normal_request_model/warehouse_item_edit_normal_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_edit_position_request_model/warehouse_item_edit_position_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_edit_quantity_request_model/warehouse_item_edit_quantity_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_request_model/warehouse_item_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/room.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'warehouse_item_page_interactive.dart';
part 'warehouse_item_page_route.dart';

class WarehouseItemPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseItemPageModel();
  final _service = WarehouseService.instance;
  List<WarehouseNameIdModel> get getfilterRuleForRooms => _model.filterRuleForRooms;
  String getItemCategoriesName(Item item) => _service.convertCategoriesName(item);
  RxReadonly<List<Item>> get visibleItemsRx => _model.visibleItems.readonly;
  RxReadonly<List<Room>?> get allItemsRx => _model.allRoomCabinetItems.readonly;
  RxReadonly<bool> get isFilterExpandedRx => _model.isFilterExpanded.readonly;
  RxReadonly<int> get filterIndexForRoomsRx => _model.filterIndexForRooms.readonly;
  RxReadonly<int> get cabinetFilterSelectedIndexRx => _model.filterIndexForCabinets.readonly;
  RxReadonly<Set<int>> get categoryFilterSelectedIndicesRx => _model.filterIndexForCategories.readonly;
  RxReadonly<DialogItemSearchOutputModel?> get searchConditionRx => _model.searchCondition.readonly;
  Worker? _searchConditionWorker;
  Worker? _searchCabinetIdWorker;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[WarehouseItemPageController] onInit - $hashCode');
    _genFilterRuleForRoom();
    _queryApiData();
    _addListeners();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[WarehouseItemPageController] onClose - $hashCode');
    _searchConditionWorker?.dispose();
    _searchCabinetIdWorker?.dispose();
    super.onClose();
  }

  // MARK: - Public Methods

  int getTotalItemCount() {
    return _model.allRoomCabinetItems.value?.fold<int>(0, (sum, room) => sum + (room.quantity ?? 0)) ?? 0;
  }

  int getTotalCategoryCount() {
    final allItems = _service.getAllCombineItems;
    final Set<String> allCategoryIds = {};

    void extractCategory(Category? category) {
      if (category?.id?.isEmpty ?? true) {
        return;
      }

      allCategoryIds.add(category!.id!);
      if (category.children != null) {
        extractCategory(category.children);
      }
    }

    for (var item in allItems) {
      extractCategory(item.category);
    }

    return allCategoryIds.length;
  }

  List<String> getFilterRoomNameList() {
    return _model.filterRuleForRooms.map((r) => r.name ?? '').toList();
  }

  List<String> getFilterCabinetNameList() {
    return _model.filterRuleForCabinets.value.map((c) => c.name ?? '').toList();
  }

  List<String> getFilterCategoryNameList() {
    return _model.filterRuleForCategories.value.map((c) => c.name ?? '').toList();
  }

  bool isShowStockWarningTag(Item item) {
    final minStockAlert = item.minStockAlert ?? 0;
    final quantity = item.quantity ?? 0;

    if (minStockAlert > 0) {
      return quantity < minStockAlert;
    }

    return false;
  }

  int get getTotalLowStockCount {
    return _service.getAllCombineItems.where(isShowStockWarningTag).length;
  }

  // MARK: - Private Methods

  Future<void> _queryApiData() async {
    final response = await _service.apiReqFetchItems(WarehouseItemRequestModel());

    if (response == null) {
      return;
    }

    _model.allRoomCabinetItems.value = response;

    // 恢復所有篩選條件索引值
    _model.filterIndexForRooms.value = 0;
    _model.filterIndexForCabinets.value = 0;
    _model.filterIndexForCategories.value = {};

    // 生成篩選條件
    _genFilterRuleForCabinet();
    _genAllFilterRuleAndItemForCategory();
    _genVisibleItems();
  }

  Future<bool> _updateItemNormal(Item item, DialogItemNormalEditOutputModel model) async {
    String errMsg = '';
    final requestModel = WarehouseItemEditNormalRequestModel(
      householdId: _service.getHouseholdId,
      itemId: item.id,
      photo: model.photo,
      name: model.name,
      description: model.description,
      categoryId: model.categoryId,
      minStockAlert: model.minStockAlert,
    );

    final response = await _service.apiReqUpdateItemNormal(
      requestModel,
      onError: (error) {
        errMsg = '[${error.code}] ${error.message ?? ''}';
      },
    );

    final isSuccess = response != null;
    _service.showSnackBar(
      title: isSuccess ? EnumLocale.warehouseItemUpdateSuccess.tr : EnumLocale.warehouseItemUpdateFailed.tr,
      message: errMsg,
    );
    return isSuccess;
  }

  Future<bool> _updateItemQuantity(Item item, List<DialogItemEditQuantityOutputModel> models) async {
    String errMsg = '';
    final requestModel = WarehouseItemEditQuantityRequestModel(
      householdId: _service.getHouseholdId,
      itemId: item.id,
      cabinets: models.map((model) => QuantityCabinetRequestModel(cabinetId: model.cabinetId, quantity: model.quantity)).toList(),
    );

    final response = await _service.apiReqUpdateItemQuantity(
      requestModel,
      onError: (error) {
        errMsg = '[${error.code}] ${error.message ?? ''}';
      },
    );

    final isSuccess = response != null;
    _service.showSnackBar(
      title: isSuccess ? EnumLocale.warehouseItemUpdateSuccess.tr : EnumLocale.warehouseItemUpdateFailed.tr,
      message: errMsg,
    );
    return isSuccess;
  }

  Future<bool> _updateItemPosition(Item item, List<DialogItemEditPositionOutputModel> models) async {
    String errMsg = '';
    final requestModel = WarehouseItemEditPositionRequestModel(
      householdId: _service.getHouseholdId,
      itemId: item.id,
      cabinets: models.map((model) => PositionCabinetRequestModel(oldCabinetId: model.oldCabinetId, newCabinetId: model.newCabinetId)).toList(),
    );

    final response = await _service.apiReqUpdateItemPosition(
      requestModel,
      onError: (error) {
        errMsg = '[${error.code}] ${error.message ?? ''}';
      },
    );

    final isSuccess = response != null;
    _service.showSnackBar(
      title: isSuccess ? EnumLocale.warehouseItemUpdateSuccess.tr : EnumLocale.warehouseItemUpdateFailed.tr,
      message: errMsg,
    );
    return isSuccess;
  }

  // 設定分類篩選條件為全部
  void _setFilterIndexForCategoryToAll() {
    _model.filterIndexForCategories.value = {for (int i = 0; i < _model.filterRuleForCategories.value.length; i++) i};
  }

  // 扁平化所有物品
  List<Item> _flattenAllItems() {
    return _model.allRoomCabinetItems.value?.expand<Cabinet>((room) => room.cabinets ?? []).expand<Item>((cabinet) => cabinet.items ?? []).toList() ??
        [];
  }

  // 扁平化所有櫥櫃
  List<Cabinet> _flattenAllCabinets() {
    return _model.allRoomCabinetItems.value?.expand<Cabinet>((room) => room.cabinets ?? []).toList() ?? [];
  }

  // 取得第一階分類
  List<WarehouseNameIdModel> _genFirstLevelCategory(List<Item> items) {
    final Set<String> matchCategoryIds = {};
    final List<WarehouseNameIdModel> resultCategory = [];

    for (var item in items) {
      if ((item.category?.id?.isNotEmpty ?? false) && !matchCategoryIds.contains(item.category!.id)) {
        matchCategoryIds.add(item.category!.id!);
        resultCategory.add(WarehouseNameIdModel(id: item.category!.id, name: item.category!.name ?? ''));
      }
    }

    return resultCategory;
  }

  // 生成房間篩選列表
  void _genFilterRuleForRoom() {
    _model.filterRuleForRooms.clear();
    _model.filterRuleForRooms.addAll([
      WarehouseNameIdModel(id: 'all', name: EnumLocale.all.tr),
      ..._service.rooms,
    ]);
  }

  // 生成櫥櫃篩選列表
  void _genFilterRuleForCabinet() {
    final allRoomsCabinets = _model.allRoomCabinetItems.value ?? [];
    final roomIdx = _model.filterIndexForRooms.value;
    final List<WarehouseNameIdModel> resultRules = [WarehouseNameIdModel(id: 'all', name: EnumLocale.all.tr)];

    if (roomIdx == 0) {
      final allCabinets = _flattenAllCabinets();
      resultRules.addAll(allCabinets.map((cabinet) => WarehouseNameIdModel(id: cabinet.id ?? '', name: cabinet.name ?? '')));
    } else {
      final roomId = _model.filterRuleForRooms[roomIdx].id;
      final room = allRoomsCabinets.firstWhereOrNull((room) => room.roomId == roomId);
      final cabinets = room?.cabinets ?? <Cabinet>[];
      resultRules.addAll(cabinets.map((cabinet) => WarehouseNameIdModel(id: cabinet.id ?? '', name: cabinet.name ?? '')));
    }

    _model.filterRuleForCabinets.value = resultRules;
  }

  // 生成所有分類篩選和物品列表
  void _genAllFilterRuleAndItemForCategory() {
    List<Item> allItems = [];
    final roomIndex = _model.filterIndexForRooms.value;
    final cabinetIndex = _model.filterIndexForCabinets.value;
    final roomId = _model.filterRuleForRooms[roomIndex].id;
    final cabinetId = _model.filterRuleForCabinets.value[cabinetIndex].id;
    final List<WarehouseNameIdModel> resultRules = [WarehouseNameIdModel(id: 'all', name: EnumLocale.all.tr)];

    if (roomIndex == 0 && cabinetIndex == 0) {
      allItems = _flattenAllItems();
    } else if (roomIndex != 0 && cabinetIndex == 0) {
      allItems = _model.allRoomCabinetItems.value
              ?.where((room) => room.roomId == roomId)
              .expand<Cabinet>((room) => room.cabinets ?? [])
              .expand<Item>((cabinet) => cabinet.items ?? [])
              .toList() ??
          [];
    } else {
      final allCabinets = _flattenAllCabinets();
      final matchCabinet = allCabinets.firstWhereOrNull((cabinet) => cabinet.id == cabinetId);
      allItems = matchCabinet?.items ?? [];
    }

    allItems = _service.combineItems(allItems);
    resultRules.addAll(_genFirstLevelCategory(allItems));
    _model.filterRuleForCategories.value = resultRules;
    _model.allItemsForCategory.clear();
    _model.allItemsForCategory.addAll(allItems);
    _setFilterIndexForCategoryToAll();
    _genVisibleItems();
  }

  // 生成篩選條件下可顯示的物品列表
  void _genVisibleItems() {
    final selectedIndexes = _model.filterIndexForCategories.value;
    final List<Item> resultItems = [];

    if (selectedIndexes.contains(0)) {
      resultItems.addAll(_model.allItemsForCategory);
    } else {
      // 從選中的索引中取得對應的分類 ID
      final categoryIds =
          selectedIndexes.map((index) => _model.filterRuleForCategories.value[index].id).where((id) => id != null && (id).isNotEmpty).toSet();
      // 篩選出分類 ID 在選中列表中的物品
      resultItems.addAll(_model.allItemsForCategory.where((item) => categoryIds.contains(item.category?.id ?? '')).toList());
    }

    _model.visibleItems.value = resultItems;
  }

  void _genVisibleItemsBySearchCondition() {
    List<Item> matchItems = [..._service.getAllCombineItems];
    final model = _model.searchCondition.value;
    final lv1Id = model?.categoryLevel1?.id ?? '';
    final lv2Id = model?.categoryLevel2?.id ?? '';
    final lv3Id = model?.categoryLevel3?.id ?? '';
    final str = model?.searchText ?? '';

    if (lv1Id.isEmpty && lv2Id.isEmpty && lv3Id.isEmpty && str.isEmpty) {
      _model.searchCondition.value = null;
      _service.clearSearchCondition();
      return;
    }

    if (lv1Id.isNotEmpty) {
      matchItems.removeWhere((item) => item.category?.id != lv1Id);

      if (lv2Id.isNotEmpty) {
        matchItems.removeWhere((item) => item.category?.children?.id != lv2Id);

        if (lv3Id.isNotEmpty) {
          matchItems.removeWhere((item) => item.category?.children?.children?.id != lv3Id);
        }
      }
    }

    if (str.isNotEmpty) {
      final searchText = str.toLowerCase();
      matchItems.removeWhere((item) {
        final name = (item.name ?? '').toLowerCase();
        final description = (item.description ?? '').toLowerCase();
        return !name.contains(searchText) && !description.contains(searchText);
      });
    }

    _model.visibleItems.value = matchItems;
  }

  // 用戶選擇分類多選框時，重新計算全選狀態
  void _changeCategoryMultiCheckbox(int index) {
    final currentSelectedIndices = Set<int>.from(_model.filterIndexForCategories.value);

    if (index == 0) {
      if (currentSelectedIndices.contains(index)) {
        _model.filterIndexForCategories.value = {};
      } else {
        _setFilterIndexForCategoryToAll();
      }
    } else {
      if (currentSelectedIndices.contains(index)) {
        currentSelectedIndices.remove(index);
      } else {
        currentSelectedIndices.add(index);
      }

      final totalCount = _model.filterRuleForCategories.value.length;
      final allOthersSelected = currentSelectedIndices.where((i) => i != 0).length == totalCount - 1;

      if (allOthersSelected && !currentSelectedIndices.contains(0)) {
        currentSelectedIndices.add(0);
      } else if (!allOthersSelected && currentSelectedIndices.contains(0)) {
        currentSelectedIndices.remove(0);
      }

      _model.filterIndexForCategories.value = Set<int>.from(currentSelectedIndices);
    }
  }

  // 監聽
  void _addListeners() {
    _searchConditionWorker = ever(_service.searchConditionRx.rx, (model) {
      if (model != null) {
        _model.searchCondition.value = model;
        _genVisibleItemsBySearchCondition();
      }
    });
    _searchCabinetIdWorker = ever(_service.searchCabinetIdRx.rx, (id) {
      if (id != null) {
        interactive(EnumWarehouseItemPageInteractive.tapRoomFilter, data: 0);
        final cabinets = _model.filterRuleForCabinets.value;
        final matchIndex = cabinets.indexWhere((cabinet) => cabinet.id == id);

        if (matchIndex != -1) {
          interactive(EnumWarehouseItemPageInteractive.tapCabinetFilter, data: matchIndex);
          _model.isFilterExpanded.value = true;
        }
      }
    });
  }
}
