import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_normal_edit/dialog_item_normal_edit_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
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

    // 獲取新值
    final newNameValue = nameController.text.trim();
    final newMinStockAlertValue = int.tryParse(minStockAlertController.text.trim()) ?? 0;
    final newDescriptionValue = descriptionController.text.trim();
    final newPhotoValue = imgBase64;
    final newCategoryIdValue =
        _model.selectedCategoryLevel3.value?.id ?? _model.selectedCategoryLevel2.value?.id ?? _model.selectedCategoryLevel1.value?.id;

    // 獲取原始值
    final originalName = _model.combineItem?.name;
    final originalMinStockAlert = _model.combineItem?.minStockAlert ?? 0;
    final originalDescription = _model.combineItem?.description ?? '';
    final originalPhoto = _model.combineItem?.photo;

    // 獲取原始分類 ID（找到最深的 category id）
    String? originalCategoryId;
    final catLv1 = _model.combineItem?.category;
    if (catLv1?.id?.isNotEmpty ?? false) {
      final catLv2 = catLv1?.child;
      if (catLv2?.id?.isNotEmpty ?? false) {
        final catLv3 = catLv2?.child;
        originalCategoryId = catLv3?.id?.isNotEmpty ?? false ? catLv3?.id : catLv2?.id;
      } else {
        originalCategoryId = catLv1?.id;
      }
    }

    // 比較並設置值，如果相同則為 null（name 和 minStockAlert 是必需的，所以即使相同也要傳值）
    final newName = newNameValue == originalName ? null : newNameValue;
    final newMinStockAlert = newMinStockAlertValue == originalMinStockAlert ? null : newMinStockAlertValue;
    final newDescription = newDescriptionValue == originalDescription ? null : newDescriptionValue;
    final newCategoryId = newCategoryIdValue == originalCategoryId ? null : newCategoryIdValue;

    String? newPhoto;
    if (newPhotoValue != null) {
      newPhoto = newPhotoValue;
    } else if (originalPhoto != null && _model.photoUrl.value == null) {
      newPhoto = '';
    }

    // 檢查所有字段是否都為 null（表示沒有變更）
    if (newName == null && newMinStockAlert == null && newDescription == null && newPhoto == null && newCategoryId == null) {
      _service.showSnackBar(
        title: EnumLocale.commonHint.tr,
        message: EnumLocale.warehouseItemNoChange.tr,
      );
      return null;
    }

    final result = DialogItemNormalEditOutputModel(
      name: newName,
      minStockAlert: newMinStockAlert,
      description: newDescription,
      photo: newPhoto,
      categoryId: newCategoryId,
    );

    return result;
  }

  Widget? get convertFileToImage {
    return _service.convertFileToImage(getFilePath, fitHeight: 200.0.scale);
  }

  Future<DialogItemNormalEditNormalOutputModel?> checkNormalOutputModel() async {
    final name = nameController.text.trim();
    final minStockAlert = int.tryParse(minStockAlertController.text.trim()) ?? 0;
    final description = descriptionController.text.trim();
    String? photo;
    String categoryId = '';

    if (getFilePath.isNotEmpty) {
      photo = await _convertFileToBase64(getFilePath);
    } else if (_model.photoUrl.value == null) {
      photo = '';
    }

    if (selectedCategoryLevel3Rx.value?.id?.isNotEmpty ?? false) {
      categoryId = selectedCategoryLevel3Rx.value!.id!;
    } else if (selectedCategoryLevel2Rx.value?.id?.isNotEmpty ?? false) {
      categoryId = selectedCategoryLevel2Rx.value!.id!;
    } else if (selectedCategoryLevel1Rx.value?.id?.isNotEmpty ?? false) {
      categoryId = selectedCategoryLevel1Rx.value!.id!;
    }

    return DialogItemNormalEditNormalOutputModel(
      name: name,
      minStockAlert: minStockAlert,
      description: description,
      photo: photo,
      categoryId: categoryId,
    );
  }

  void setLoadingStatus(bool isLoading) {
    _model.isLoading.value = isLoading;
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
      final catLv2 = catLv1?.child;

      if (catLv2?.id?.isNotEmpty ?? false) {
        _model.selectedCategoryLevel2.value = WarehouseNameIdModel(id: catLv2?.id ?? '', name: catLv2?.name ?? '');
        _genCategoryLevel3List();
        final catLv3 = catLv2?.child;

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
