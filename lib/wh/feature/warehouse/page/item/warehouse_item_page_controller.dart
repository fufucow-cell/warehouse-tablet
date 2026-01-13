import 'dart:async';

import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/ui/dialog_item_edit_normal/dialog_item_edit_normal_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/ui/dialog_item_edit_normal/dialog_item_edit_normal_widget_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/ui/dialog_item_edit_position/dialog_item_edit_position_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/ui/dialog_item_edit_position/dialog_item_edit_position_widget_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/ui/dialog_item_edit_quantity/dialog_item_edit_quantity_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/ui/dialog_item_edit_quantity/dialog_item_edit_quantity_widget_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/ui/dialog_item_info/dialog_item_info_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/warehouse_item_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/ui/dialog_item_search/dialog_item_search_widget_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_cabinet_read_request_model/warehouse_cabinet_read_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_item_delete_request_model/warehouse_item_delete_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_item_edit_normal_request_model/warehouse_item_edit_normal_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_item_edit_position_request_model/warehouse_item_edit_position_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_item_edit_quantity_request_model/warehouse_item_edit_quantity_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_item_request_model/warehouse_item_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/room.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'warehouse_item_page_interactive.dart';
part 'warehouse_item_page_route.dart';

class WarehouseItemPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseItemPageModel();
  final _service = WarehouseService.instance;
  String getItemCategoriesName(Item item) => _service.convertCategoriesName(item);
  RxReadonly<List<Item>> get visibleItemsRx => _model.visibleItems.readonly;
  RxReadonly<List<Room>?> get allItemsRx => _model.allRoomCabinetItems.readonly;
  RxReadonly<List<Room>?> get allCabinetsRx => _model.allRoomCabinets.readonly;
  RxReadonly<List<Category>?> get allCategoriesRx => _service.allCategoriesRx;
  RxReadonly<bool> get isFilterExpandedRx => _model.isFilterExpanded.readonly;
  RxReadonly<int> get filterIndexForRoomsRx => _model.filterIndexForRooms.readonly;
  RxReadonly<int> get cabinetFilterSelectedIndexRx => _model.filterIndexForCabinets.readonly;
  RxReadonly<Set<int>> get categoryFilterSelectedIndicesRx => _model.filterIndexForCategories.readonly;
  RxReadonly<DialogItemSearchOutputModel?> get searchConditionRx => _model.searchCondition.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogService.instance.i(EnumLogType.debug, '[WarehouseItemPageController] onInit - $hashCode');
    _addListeners();
    _genFilterRuleForRoom();
    _checkData();
  }

  @override
  void onClose() {
    LogService.instance.i(EnumLogType.debug, '[WarehouseItemPageController] onClose - $hashCode');
    _model.allRoomCabinetItemsWorker?.dispose();
    _model.allRoomCabinetsWorker?.dispose();
    _model.searchConditionWorker?.dispose();
    super.onClose();
  }

  // MARK: - Public Methods

  int getTotalItemCount() {
    return _model.allRoomCabinetItems.value?.fold<int>(0, (sum, room) => sum + (room.quantity ?? 0)) ?? 0;
  }

  int getTotalCabinetCount() {
    return _model.allRoomCabinets.value?.fold<int>(0, (sum, room) => sum + (room.cabinets?.length ?? 0)) ?? 0;
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

  void _checkData() {
    if (_service.allRoomCabinetItemsRx.value != null) {
      _model.allRoomCabinetItems.value = _service.getAllRoomCabinetItems;
    } else {
      _queryApiData();
    }

    if (_service.allRoomCabinetsRx.value != null) {
      _model.allRoomCabinets.value = _service.getAllRoomCabinets;
    } else {
      unawaited(
        _service.apiReqReadCabinets(
          WarehouseCabinetReadRequestModel(
            householdId: _service.getHouseholdId,
          ),
        ),
      );
    }

    if (_model.allRoomCabinetItems.value != null && _model.allRoomCabinets.value != null) {
      _initData();
    }
  }

  void _initData() {
    final searchCondition = _service.getSearchCondition;
    final searchCabinetId = _service.getSearchCabinetId;

    if (searchCondition != null) {
      _model.searchCondition.value = searchCondition;
      _genVisibleItemsBySearchCondition();
    } else if (searchCabinetId.isNotEmpty) {
      interactive(EnumWarehouseItemPageInteractive.tapRoomFilter, data: 0);
      final List<WarehouseNameIdModel> cabinets = _model.filterRuleForCabinets.value;
      final matchIndex = cabinets.indexWhere((cabinet) => cabinet.id == searchCabinetId);

      if (matchIndex != -1) {
        interactive(EnumWarehouseItemPageInteractive.tapCabinetFilter, data: matchIndex);
        _model.isFilterExpanded.value = true;
      }

      _service.clearSearchCabinetId();
    }

    _genFilterRuleForCabinet();

    if (searchCondition == null) {
      _genAllFilterRuleAndItemForCategory();
    }
  }

  Future<void> _queryApiData() async {
    // _model.allRoomCabinetItems.value = null;
    // _model.filterIndexForRooms.value = 0;
    // _model.filterIndexForCabinets.value = 0;
    // _model.filterIndexForCategories.value = {};
    unawaited(_service.apiReqReadItems(WarehouseItemRequestModel(householdId: _service.getHouseholdId)));
  }

  Future<bool> _updateItemNormal(Item item, DialogItemEditNormalOutputModel model) async {
    final requestModel = WarehouseItemEditNormalRequestModel(
      householdId: _service.getHouseholdId,
      itemId: item.id,
      photo: model.photo,
      name: model.name,
      description: model.description,
      categoryId: model.categoryId,
      minStockAlert: model.minStockAlert,
      userName: _service.userName,
    );

    final response = await _service.apiReqUpdateItemNormal(
      requestModel,
    );

    final isSuccess = response != null;

    if (isSuccess) {
      unawaited(_queryApiData());
    }

    return isSuccess;
  }

  Future<bool> _deleteItem(String itemId) async {
    final requestModel = WarehouseItemDeleteRequestModel(
      householdId: _service.getHouseholdId,
      id: itemId,
      userName: _service.userName,
    );

    final response = await _service.apiReqDeleteItem(
      requestModel,
    );

    final isSuccess = response != null;

    if (isSuccess) {
      unawaited(_queryApiData());
    }

    return isSuccess;
  }

  Future<bool> _updateItemQuantity(Item item, List<DialogItemEditQuantityOutputModel> models) async {
    final requestModel = WarehouseItemEditQuantityRequestModel(
      householdId: _service.getHouseholdId,
      itemId: item.id,
      cabinets: models.map((model) => QuantityCabinetRequestModel(cabinetId: model.cabinetId, quantity: model.quantity)).toList(),
      userName: _service.userName,
    );

    final response = await _service.apiReqUpdateItemQuantity(
      requestModel,
    );

    final isSuccess = response != null;

    if (isSuccess) {
      unawaited(_queryApiData());
    }

    return isSuccess;
  }

  Future<bool> _updateItemPosition(Item item, List<DialogItemEditPositionOutputModel> models) async {
    final requestModel = WarehouseItemEditPositionRequestModel(
      householdId: _service.getHouseholdId,
      itemId: item.id,
      cabinets: models
          .map(
            (model) => PositionCabinetRequestModel(
              oldCabinetId: model.oldCabinetId,
              newCabinetId: model.newCabinetId,
              quantity: model.moveQuantity,
              isDelete: model.isDelete,
            ),
          )
          .toList(),
      userName: _service.userName,
    );

    final response = await _service.apiReqUpdateItemPosition(
      requestModel,
    );

    final isSuccess = response != null;

    if (isSuccess) {
      unawaited(_queryApiData());
    }

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
    return _model.allRoomCabinets.value?.expand<Cabinet>((room) => room.cabinets ?? []).toList() ?? [];
  }

  // 扁平化所有櫥櫃包含物品
  List<Cabinet> _flattenAllCabinetsWithItems() {
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
    final allRoomsCabinets = _model.allRoomCabinets.value ?? [];
    final roomIdx = _model.filterIndexForRooms.value;
    final List<WarehouseNameIdModel> resultRules = [WarehouseNameIdModel(id: 'all', name: EnumLocale.all.tr)];

    if (roomIdx == 0) {
      final allCabinets = _flattenAllCabinets();
      resultRules.addAll(
        allCabinets
            .where((cabinet) => ((cabinet.id?.isNotEmpty ?? false) && (cabinet.name?.isNotEmpty ?? false)))
            .map((cabinet) => WarehouseNameIdModel(id: cabinet.id, name: cabinet.name)),
      );
    } else {
      final roomId = _model.filterRuleForRooms[roomIdx].id;
      final room = allRoomsCabinets.firstWhereOrNull((room) => room.roomId == roomId);
      final cabinets = room?.cabinets ?? <Cabinet>[];
      resultRules.addAll(
        cabinets
            .where((cabinet) => ((cabinet.id?.isNotEmpty ?? false) && (cabinet.name?.isNotEmpty ?? false)))
            .map((cabinet) => WarehouseNameIdModel(id: cabinet.id, name: cabinet.name)),
      );
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
      final allCabinets = _flattenAllCabinetsWithItems();
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
        matchItems.removeWhere((item) => item.category?.child?.id != lv2Id);

        if (lv3Id.isNotEmpty) {
          matchItems.removeWhere((item) => item.category?.child?.child?.id != lv3Id);
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
    _model.allRoomCabinetItemsWorker = ever(_service.allRoomCabinetItemsRx.rx, (rooms) {
      _model.allRoomCabinetItems.value = rooms;
      if (_model.allRoomCabinets.value != null) {
        _initData();
      }
    });
    _model.allRoomCabinetsWorker = ever(_service.allRoomCabinetsRx.rx, (rooms) {
      _model.allRoomCabinets.value = rooms;
      if (_model.allRoomCabinetItems.value != null) {
        _initData();
      }
    });
    _model.searchConditionWorker = ever(_service.searchConditionRx.rx, (searchCondition) {
      _model.searchCondition.value = searchCondition;
      if (searchCondition != null) {
        _genVisibleItemsBySearchCondition();
      }
    });
  }
}
