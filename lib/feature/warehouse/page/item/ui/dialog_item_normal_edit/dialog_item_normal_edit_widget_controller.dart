import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_normal_edit/dialog_item_normal_edit_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_item_normal_edit_widget_interactive.dart';
part 'dialog_item_normal_edit_widget_route.dart';

class DialogItemNormalEditWidgetController extends GetxController {
  // MARK: - Properties

  final DialogItemNormalEditWidgetModel _model = DialogItemNormalEditWidgetModel();
  final _service = WarehouseService.instance;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final minStockAlertController = TextEditingController(text: '0');
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  RxReadonly<String?> get filePathRx => _model.filePath.readonly;
  RxReadonly<String?> get photoUrlRx => _model.photoUrl.readonly;
  String get getFilePath => _model.filePath.value ?? '';
  RxReadonly<WarehouseNameIdModel?> get selectedCategoryLevel1Rx => _model.selectedCategoryLevel1.readonly;
  RxReadonly<WarehouseNameIdModel?> get selectedCategoryLevel2Rx => _model.selectedCategoryLevel2.readonly;
  RxReadonly<WarehouseNameIdModel?> get selectedCategoryLevel3Rx => _model.selectedCategoryLevel3.readonly;
  RxReadonly<List<Category>> get visibleCategoryLevel1Rx => _model.visibleCategoryLevel1.readonly;
  RxReadonly<List<Category>> get visibleCategoryLevel2Rx => _model.visibleCategoryLevel2.readonly;
  RxReadonly<List<Category>> get visibleCategoryLevel3Rx => _model.visibleCategoryLevel3.readonly;

  // MARK: - Init

  DialogItemNormalEditWidgetController(String itemId) {
    _model.itemId = itemId;
  }

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[DialogItemNormalEditWidgetController] onInit - $hashCode');
    _loadData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[DialogItemNormalEditWidgetController] onClose - $hashCode');
    nameController.dispose();
    descriptionController.dispose();
    minStockAlertController.dispose();
    super.onClose();
  }

  // MARK: - Public Method

  // 檢查輸出資料
  Future<DialogItemNormalEditOutputModel?> checkOutputModel() async {
    String? imgBase64;

    if (_model.filePath.value != null) {
      final compressedPath = await _compressImage(_model.filePath.value!);

      if (compressedPath != null) {
        imgBase64 = await _convertFileToBase64(compressedPath);
      }
    }

    return DialogItemNormalEditOutputModel(
      name: nameController.text.trim(),
      minStockAlert: int.tryParse(minStockAlertController.text.trim()) ?? 0,
      description: descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim(),
      photo: imgBase64,
      categoryId: _model.selectedCategoryLevel3.value?.id ?? _model.selectedCategoryLevel2.value?.id ?? _model.selectedCategoryLevel1.value?.id,
    );
  }

  Widget? get convertFileToImage {
    return _service.convertFileToImage(getFilePath, fitHeight: 200.0.scale);
  }

  // MARK: - Private Method

  // 設置加載狀態
  void _setLoadingStatus(bool isLoading) {
    _model.isLoading.value = isLoading;
  }

  // 開啟相機
  Future<void> _openCamera() async {
    final path = await _service.openCamera();

    if (path != null) {
      _model.filePath.value = path;
      _model.photoUrl.value = null;
    }
  }

  // 開啟相冊
  Future<void> _openGallery() async {
    final path = await _service.openGallery();

    if (path != null) {
      _model.filePath.value = path;
      _model.photoUrl.value = null;
    }
  }

  // 壓縮圖片
  Future<String?> _compressImage(String imagePath, {int maxSide = 100}) async {
    return await _service.compressImage(imagePath, maxSide: maxSide);
  }

  // 轉換文件為 Base64
  Future<String?> _convertFileToBase64(String imagePath) async {
    return await _service.convertFileToBase64(imagePath);
  }

  void _loadData() {
    final item = _service.getAllCombineItems.firstWhereOrNull((item) => item.id == _model.itemId);

    if (item == null) {
      return;
    }

    nameController.text = item.name ?? '';
    descriptionController.text = item.description ?? '';
    minStockAlertController.text = item.minStockAlert?.toString() ?? '0';
    _model.photoUrl.value = item.photo;
    _model.combineItem = item;
    _genCategoryLevel1List();
  }

  void _genCategoryLevel1List() {
    final allCategories = _service.getAllCategories;
    _model.visibleCategoryLevel1.value = allCategories;
    final catLv1 = _model.combineItem?.category;

    if (catLv1?.id?.isNotEmpty ?? false) {
      _model.selectedCategoryLevel1.value = WarehouseNameIdModel(id: catLv1?.id ?? '', name: catLv1?.name ?? '');
      _genCategoryLevel2List();
      final catLv2 = catLv1?.children;

      if (catLv2?.id?.isNotEmpty ?? false) {
        _model.selectedCategoryLevel2.value = WarehouseNameIdModel(id: catLv2?.id ?? '', name: catLv2?.name ?? '');
        _genCategoryLevel3List();
        final catLv3 = catLv2?.children;

        if (catLv3?.id?.isNotEmpty ?? false) {
          _model.selectedCategoryLevel3.value = WarehouseNameIdModel(id: catLv3?.id ?? '', name: catLv3?.name ?? '');
        }
      }
    }
  }

  void _genCategoryLevel2List() {
    final level1Id = _model.selectedCategoryLevel1.value?.id;
    _model.selectedCategoryLevel2.value = null;
    _model.selectedCategoryLevel3.value = null;
    _model.visibleCategoryLevel2.value = _model.visibleCategoryLevel1.value.firstWhereOrNull((cat) => cat.id == level1Id)?.children ?? [];
    _model.visibleCategoryLevel3.value = [];
  }

  // 生成三階分類列表
  void _genCategoryLevel3List() {
    final level2Id = _model.selectedCategoryLevel2.value?.id;
    _model.selectedCategoryLevel3.value = null;
    _model.visibleCategoryLevel3.value = _model.visibleCategoryLevel2.value.firstWhereOrNull((cat) => cat.id == level2Id)?.children ?? [];
  }

  void _changeSelectedCategoryLevel1(String? categoryName) {
    final category = _model.visibleCategoryLevel1.value.firstWhereOrNull((cat) => cat.name == categoryName);
    _model.selectedCategoryLevel1.value = category != null ? WarehouseNameIdModel(id: category.id ?? '', name: category.name ?? '') : null;
    _genCategoryLevel2List();
  }

  void _changeSelectedCategoryLevel2(String? categoryName) {
    final category = _model.visibleCategoryLevel2.value.firstWhereOrNull((cat) => cat.name == categoryName);
    _model.selectedCategoryLevel2.value = category != null ? WarehouseNameIdModel(id: category.id ?? '', name: category.name ?? '') : null;
    _genCategoryLevel3List();
  }

  void _changeSelectedCategoryLevel3(String? categoryName) {
    final category = _model.visibleCategoryLevel3.value.firstWhereOrNull((cat) => cat.name == categoryName);
    _model.selectedCategoryLevel3.value = category != null ? WarehouseNameIdModel(id: category.id ?? '', name: category.name ?? '') : null;
  }
}
