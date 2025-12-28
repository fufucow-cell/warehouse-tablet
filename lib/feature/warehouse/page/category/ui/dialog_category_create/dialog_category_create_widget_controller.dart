import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/dialog_category_create/dialog_category_create_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_category_create_widget_interactive.dart';
part 'dialog_category_create_widget_route.dart';

class DialogCategoryCreateWidgetController extends GetxController {
  // MARK: - Properties

  final DialogCategoryCreateWidgetModel _model = DialogCategoryCreateWidgetModel();
  final _service = WarehouseService.instance;
  final nameController = TextEditingController();
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  RxReadonly<Category?> get selectedLevel1Rx => _model.selectedLevel1.readonly;
  RxReadonly<Category?> get selectedLevel2Rx => _model.selectedLevel2.readonly;
  RxReadonly<String> get hintTextRx => _model.hintText.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[DialogCategoryCreateWidgetController] onInit - $hashCode');
    _genHintText();
    nameController.addListener(_onNameChanged);
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[DialogCategoryCreateWidgetController] onClose - $hashCode');
    nameController.removeListener(_onNameChanged);
    nameController.dispose();
    super.onClose();
  }

  // MARK: - Public Method

  // 檢查輸出資料
  Future<DialogCategoryCreateOutputModel?> checkOutputModel() async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      return null;
    }

    return DialogCategoryCreateOutputModel(
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

  void _onNameChanged() {
    _model.name.value = nameController.text;
    _genHintText();
  }

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

  void _genHintText() {
    String result = EnumLocale.createCategoryParentQuestion.tr;

    if (nameController.text.trim().isNotEmpty && _model.selectedLevel1.value != null) {
      final level1Name = _model.selectedLevel1.value?.name;
      final level2Name = _model.selectedLevel2.value?.name;
      final parentName = level2Name != null ? '$level1Name > $level2Name' : level1Name;
      final newName = nameController.text.trim();
      result = '分類結果: $parentName > $newName';
    }

    _model.hintText.value = result;
  }
}
