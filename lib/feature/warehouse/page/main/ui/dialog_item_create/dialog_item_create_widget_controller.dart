import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog_item_create/dialog_item_create_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/util/category_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/log_service/log_service_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_create_smart_request_model/warehouse_item_create_smart_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';

import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_item_create_widget_interactive.dart';
part 'dialog_item_create_widget_route.dart';

class DialogItemCreateWidgetController extends GetxController {
  // MARK: - Properties

  final DialogItemCreateWidgetModel _model = DialogItemCreateWidgetModel();
  final _service = WarehouseService.instance;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController(text: '0');
  final minStockAlertController = TextEditingController(text: '0');
  RxReadonly<bool> get isLoadingRx => _model.isLoading.readonly;
  RxReadonly<bool> get isRecognizingRx => _model.isRecognizing.readonly;
  RxReadonly<int> get quantityRx => _model.quantity.readonly;
  RxReadonly<String?> get filePathRx => _model.filePath.readonly;
  RxReadonly<WarehouseNameIdModel?> get selectedRoomRx => _model.selectedRoom.readonly;
  RxReadonly<WarehouseNameIdModel?> get selectedCabinetRx => _model.selectedCabinet.readonly;
  RxReadonly<WarehouseNameIdModel?> get selectedCategoryLevel1Rx => _model.selectedCategoryLevel1.readonly;
  RxReadonly<WarehouseNameIdModel?> get selectedCategoryLevel2Rx => _model.selectedCategoryLevel2.readonly;
  RxReadonly<WarehouseNameIdModel?> get selectedCategoryLevel3Rx => _model.selectedCategoryLevel3.readonly;
  RxReadonly<List<WarehouseNameIdModel>> get visibleCabinetsRx => _model.visibleCabinets.readonly;
  RxReadonly<List<Category>> get visibleCategoryLevel1Rx => _model.visibleCategoryLevel1.readonly;
  RxReadonly<List<Category>> get visibleCategoryLevel2Rx => _model.visibleCategoryLevel2.readonly;
  RxReadonly<List<Category>> get visibleCategoryLevel3Rx => _model.visibleCategoryLevel3.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogService.i(
      EnumLogType.debug,
      '[DialogItemCreateWidgetController] onInit - $hashCode',
    );
    _genCabinetList();
    _genCategoryLevel1List();
  }

  @override
  void onClose() {
    LogService.i(
      EnumLogType.debug,
      '[DialogItemCreateWidgetController] onClose - $hashCode',
    );
    nameController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
    minStockAlertController.dispose();
    super.onClose();
  }

  // MARK: - Public Method

  // 獲取房間名稱列表
  List<String> getRoomNameList() {
    return _service.rooms.map((room) => room.name ?? '').toList();
  }

  // 獲取可見櫃位名稱列表
  List<String> getVisibleCabinetNameList() {
    return _model.visibleCabinets.value.map((cabinet) => cabinet.name ?? '').toList();
  }

  // 檢查輸出資料
  Future<DialogItemCreateOutputModel?> checkOutputModel() async {
    String? imgBase64;

    if (_model.filePath.value != null) {
      final compressedPath = await _compressImage(_model.filePath.value!);

      if (compressedPath != null) {
        imgBase64 = await _convertFileToBase64(compressedPath);
      }
    }

    return DialogItemCreateOutputModel(
      name: nameController.text.trim(),
      quantity: int.tryParse(quantityController.text.trim()) ?? 0,
      minStockAlert: int.tryParse(minStockAlertController.text.trim()) ?? 0,
      description: descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim(),
      photo: imgBase64,
      cabinetId: _model.selectedCabinet.value?.id,
      categoryId: _model.selectedCategoryLevel3.value?.id ?? _model.selectedCategoryLevel2.value?.id ?? _model.selectedCategoryLevel1.value?.id,
    );
  }

  // 轉換文件為圖片
  Widget? convertFileToImage(
    String imagePath, {
    double? fitWidth,
    double? fitHeight,
  }) {
    return _service.convertFileToImage(
      imagePath,
      fitWidth: fitWidth,
      fitHeight: fitHeight,
    );
  }

  // MARK: - Private Method

  // 設置加載狀態
  void _setLoadingStatus(bool isLoading) {
    _model.isLoading.value = isLoading;
  }

  // 開啟相機
  Future<void> _openCamera() async {
    // final filePath = await _service.openCamera();
    final filePath = await _service.openGallery();

    if (filePath != null) {
      _model.filePath.value = filePath;
      unawaited(_startRecognition());
    }
  }

  // 開啟相冊
  Future<void> _openGallery() async {
    final filePath = await _service.openGallery();

    if (filePath != null) {
      _model.filePath.value = filePath;
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

  // 扁平化所有櫥櫃
  List<Cabinet> _flattenAllCabinets() {
    return _service.getAllRoomCabinets.expand<Cabinet>((room) => room.cabinets ?? []).toList();
  }

  // 選擇房間
  void _changeSelectedRoom(String? roomName) {
    final room = _service.rooms.firstWhereOrNull((room) => room.name == roomName);
    _model.selectedRoom.value = room;
    _genCabinetList();
  }

  // 選擇櫃位
  void _changeSelectedCabinet(String? cabinetName) {
    final cabinet = _model.visibleCabinets.value.firstWhereOrNull((cabinet) => cabinet.name == cabinetName);
    _model.selectedCabinet.value = cabinet;
  }

  // 生成櫃位列表
  void _genCabinetList() {
    _model.selectedCabinet.value = null;
    List<Cabinet> cabinets = [];

    if (_model.selectedRoom.value == null) {
      cabinets = _flattenAllCabinets();
    } else {
      final room = _service.getAllRoomCabinets.firstWhereOrNull(
        (room) => room.roomId == _model.selectedRoom.value?.id,
      );
      cabinets = room?.cabinets ?? [];
    }

    _model.visibleCabinets.value = cabinets
        .map(
          (cabinet) => WarehouseNameIdModel(
            id: cabinet.id ?? '',
            name: cabinet.name ?? '',
          ),
        )
        .toList();
  }

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

  Future<void> _startRecognition() async {
    final imagePath = _model.filePath.value;
    _model.isRecognizing.value = true;

    if (imagePath == null) {
      _model.isRecognizing.value = false;
      return;
    }

    final compressedImagePath = await _service.compressImage(imagePath);

    if (compressedImagePath == null) {
      _model.isRecognizing.value = false;
      return;
    }

    final base64Image = await _service.convertFileToBase64(compressedImagePath);

    if (base64Image == null) {
      _model.isRecognizing.value = false;
      return;
    }

    final result = await _service.apiReqCreateItemSmart(
      WarehouseItemCreateSmartRequestModel(
        image: base64Image,
        householdId: _service.getHouseholdId,
        language: _service.getLocaleCode,
        userName: _service.userName,
      ),
    );

    if (result != null) {
      nameController.text = result.name ?? nameController.text;
      descriptionController.text = result.description ?? descriptionController.text;

      if ((result.categoryId?.isNotEmpty ?? false) && (result.category?.isNotEmpty ?? false)) {
        if (result.isNewCategory ?? false) {
          _service.addNewCategory(WarehouseNameIdModel(id: result.categoryId ?? '', name: result.category ?? ''));
          final newCategories = List<Category>.from(_model.visibleCategoryLevel1.value);
          newCategories.add(Category(id: result.categoryId ?? '', name: result.category ?? ''));
          _model.visibleCategoryLevel1.value = newCategories;
        }

        final categories = CategoryUtil.findCategoryLevelsById(result.categoryId ?? '');

        if (categories.isNotEmpty) {
          _model.selectedCategoryLevel1.value = categories.first;
          _genCategoryLevel2List();

          if (categories.length >= 2) {
            _model.selectedCategoryLevel2.value = categories[1];
            _genCategoryLevel3List();

            if (categories.length >= 3) {
              _model.selectedCategoryLevel3.value = categories[2];
            }
          }
        }
      }
    }

    _model.isRecognizing.value = false;
  }
}
