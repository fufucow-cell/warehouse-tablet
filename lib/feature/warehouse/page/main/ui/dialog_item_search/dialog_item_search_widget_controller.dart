import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog_item_search/dialog_item_search_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_item_search_widget_interactive.dart';

class DialogItemSearchWidgetController extends GetxController {
  // MARK: - Properties

  final DialogItemSearchWidgetModel _model = DialogItemSearchWidgetModel();
  final _service = WarehouseService.instance;
  final searchController = TextEditingController();

  DialogItemSearchWidgetModel get model => _model;

  RxReadonly<String> get searchTextRx => _model.searchText.readonly;
  RxReadonly<Category?> get selectedCategoryLevel1Rx =>
      _model.selectedCategoryLevel1.readonly;
  RxReadonly<Category?> get selectedCategoryLevel2Rx =>
      _model.selectedCategoryLevel2.readonly;
  RxReadonly<Category?> get selectedCategoryLevel3Rx =>
      _model.selectedCategoryLevel3.readonly;
  RxReadonly<List<Category>> get visibleCategoryLevel1Rx =>
      _model.visibleCategoryLevel1.readonly;
  RxReadonly<List<Category>> get visibleCategoryLevel2Rx =>
      _model.visibleCategoryLevel2.readonly;
  RxReadonly<List<Category>> get visibleCategoryLevel3Rx =>
      _model.visibleCategoryLevel3.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug,
        '[DialogItemSearchWidgetController] onInit - $hashCode');
    _genCategoryLevel1List();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug,
        '[DialogItemSearchWidgetController] onClose - $hashCode');
    searchController.dispose();
    super.onClose();
  }

  // MARK: - Public Method

  // 獲取房間名稱列表
  List<String> getRoomNameList() {
    return _service.rooms.map((room) => room.name ?? '').toList();
  }

  // 產出輸出資料
  DialogItemSearchOutputModel genOutputModel() {
    return DialogItemSearchOutputModel(
      searchText: searchController.text.trim(),
      categoryLevel1: _model.selectedCategoryLevel1.value != null
          ? WarehouseNameIdModel(
              id: _model.selectedCategoryLevel1.value!.id,
              name: _model.selectedCategoryLevel1.value!.name ?? '')
          : null,
      categoryLevel2: _model.selectedCategoryLevel2.value != null
          ? WarehouseNameIdModel(
              id: _model.selectedCategoryLevel2.value!.id,
              name: _model.selectedCategoryLevel2.value!.name ?? '')
          : null,
      categoryLevel3: _model.selectedCategoryLevel3.value != null
          ? WarehouseNameIdModel(
              id: _model.selectedCategoryLevel3.value!.id,
              name: _model.selectedCategoryLevel3.value!.name ?? '')
          : null,
    );
  }

  // MARK: - Private Method

  void _genCategoryLevel1List() {
    _model.selectedCategoryLevel1.value = null;
    _model.selectedCategoryLevel2.value = null;
    _model.selectedCategoryLevel3.value = null;
    _model.visibleCategoryLevel1.value = _service.getAllCategories;
    _model.visibleCategoryLevel2.value = [];
    _model.visibleCategoryLevel3.value = [];
  }

  void _genCategoryLevel2List() {
    final level1Id = _model.selectedCategoryLevel1.value?.id;
    _model.selectedCategoryLevel2.value = null;
    _model.selectedCategoryLevel3.value = null;
    _model.visibleCategoryLevel2.value = _model.visibleCategoryLevel1.value
            .firstWhereOrNull((cat) => cat.id == level1Id)
            ?.children ??
        [];
    _model.visibleCategoryLevel3.value = [];
  }

  void _genCategoryLevel3List() {
    final level2Id = _model.selectedCategoryLevel2.value?.id;
    _model.selectedCategoryLevel3.value = null;
    _model.visibleCategoryLevel3.value = _model.visibleCategoryLevel2.value
            .firstWhereOrNull((cat) => cat.id == level2Id)
            ?.children ??
        [];
  }

  void _changeSelectedCategoryLevel1(Category? category) {
    _model.selectedCategoryLevel1.value = category;
    _genCategoryLevel2List();
  }

  void _changeSelectedCategoryLevel2(Category? category) {
    _model.selectedCategoryLevel2.value = category;
    _genCategoryLevel3List();
  }

  void _changeSelectedCategoryLevel3(Category? category) {
    _model.selectedCategoryLevel3.value = category;
  }
}
