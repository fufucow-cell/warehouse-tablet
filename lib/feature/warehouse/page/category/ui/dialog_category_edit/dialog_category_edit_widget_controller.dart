import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/dialog_category_edit/dialog_category_edit_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_category_edit_widget_interactive.dart';
part 'dialog_category_edit_widget_route.dart';

class DialogCategoryEditWidgetController extends GetxController {
  // MARK: - Properties

  final DialogCategoryEditWidgetModel _model = DialogCategoryEditWidgetModel();
  final _service = WarehouseService.instance;
  final nameController = TextEditingController();
  String get getHintText => _model.hintText;
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  RxReadonly<Category?> get selectedLevel1Rx => _model.selectedLevel1.readonly;
  RxReadonly<Category?> get selectedLevel2Rx => _model.selectedLevel2.readonly;
  RxReadonly<bool> get level1IsMaxRx => _model.level1IsMax.readonly;
  RxReadonly<bool> get level2IsMaxRx => _model.level2IsMax.readonly;

  // MARK: - Init

  DialogCategoryEditWidgetController(Category category) {
    _model.category = category;
  }

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[DialogCategoryEditWidgetController] onInit - $hashCode');
    _checkData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[DialogCategoryEditWidgetController] onClose - $hashCode');
    nameController.dispose();
    super.onClose();
  }

  // MARK: - Public Method

  // 檢查輸出資料
  Future<DialogCategoryEditOutputModel?> checkOutputModel() async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      return null;
    }

    return DialogCategoryEditOutputModel(
      name: name,
      parentId: _model.selectedLevel2.value?.id ?? _model.selectedLevel1.value?.id,
    );
  }

  List<String> getLevel1NameList() {
    return _service.getAllCategories.map((cat) => cat.name ?? '').toList();
  }

  List<String> getLevel2NameList() {
    if (_model.selectedLevel1.value == null) {
      return [];
    }

    return _service.getAllCategories
            .firstWhereOrNull((cat) => cat.id == _model.selectedLevel1.value?.id)
            ?.children
            ?.map((cat) => cat.name ?? '')
            .toList() ??
        [];
  }

  // MARK: - Private Method

  void _setLoadingStatus(bool isLoading) {
    _model.isLoading.value = isLoading;
  }

  Category? _getLevel1CategoryByName(String name) {
    return _service.getAllCategories.firstWhereOrNull((cat) => cat.name == name);
  }

  Category? _getLevel2CategoryByName(String name) {
    if (_model.selectedLevel1.value == null) {
      return null;
    }

    return _service.getAllCategories
        .firstWhereOrNull((cat) => cat.id == _model.selectedLevel1.value?.id)
        ?.children
        ?.firstWhereOrNull((cat) => cat.name == name);
  }

  int _checkChildrenLevel() {
    final cat = _model.category;
    int resultLevel = 0;

    for (Category childCat in cat?.children ?? []) {
      if (resultLevel == 2) {
        break;
      }

      resultLevel = 1;

      for (Category _ in childCat.children ?? []) {
        resultLevel = 2;
        break;
      }
    }

    return resultLevel;
  }

  void _checkData() {
    final cat = _model.category;

    if (cat == null) {
      return;
    }

    final childLevel = _checkChildrenLevel();
    nameController.text = cat.name ?? '';

    if (childLevel == 0) {
      _model.hintText = EnumLocale.editCategoryNoSubcategory.tr;
    } else if (childLevel == 1) {
      _model.hintText = EnumLocale.editCategoryHasLevel1Subcategory.tr;
      _model.level2IsMax.value = true;
    } else if (childLevel == 2) {
      _model.hintText = EnumLocale.editCategoryHasLevel2Subcategory.tr;
      _model.level1IsMax.value = true;
      _model.level2IsMax.value = true;
    }

    if (cat.parentId == null) {
      return;
    }

    final level2Cat = _service.flattenAllLevel2Categories().firstWhereOrNull((lv2Cat) => lv2Cat.id == cat.parentId);

    if (level2Cat != null) {
      _model.selectedLevel2.value = level2Cat;

      final level1Cat = _service.getAllCategories.firstWhereOrNull((lv1Cat) => lv1Cat.id == level2Cat.parentId);

      if (level1Cat != null) {
        _model.selectedLevel1.value = level1Cat;
      }
    } else {
      final level1Cat = _service.getAllCategories.firstWhereOrNull((lv1Cat) => lv1Cat.id == cat.parentId);

      if (level1Cat != null) {
        _model.selectedLevel1.value = level1Cat;
      }
    }
  }
}
