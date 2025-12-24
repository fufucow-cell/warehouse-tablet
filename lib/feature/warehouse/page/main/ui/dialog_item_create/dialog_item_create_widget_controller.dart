import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog_item_create/dialog_item_create_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
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
    LogUtil.i(EnumLogType.debug, '[DialogItemCreateWidgetController] onInit - $hashCode');
    _genCabinetList();
    _genCategoryLevel1List();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[DialogItemCreateWidgetController] onClose - $hashCode');
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

  // 設置加載狀態
  void setLoadingStatus(bool isLoading) {
    _model.isLoading.value = isLoading;
  }

  // 轉換文件為圖片
  Widget? convertFileToImage(String imagePath, {double? fitWidth, double? fitHeight}) {
    return _service.convertFileToImage(imagePath, fitWidth: fitWidth, fitHeight: fitHeight);
  }

  // MARK: - Private Method

  // 開啟相機
  Future<void> _openCamera() async {
    _model.filePath.value = await _service.openCamera();
  }

  // 開啟相冊
  Future<void> _openGallery() async {
    _model.filePath.value = await _service.openGallery();
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
    return _service.getAllRoomCabinetItems.expand<Cabinet>((room) => room.cabinets ?? []).toList();
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
      final room = _service.getAllRoomCabinetItems.firstWhereOrNull((room) => room.roomId == _model.selectedRoom.value?.id);
      cabinets = room?.cabinets ?? [];
    }

    _model.visibleCabinets.value = cabinets.map((cabinet) => WarehouseNameIdModel(id: cabinet.id ?? '', name: cabinet.name ?? '')).toList();
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

  // 釋放鍵盤
  void _dismissKeyboard() {
    final primaryFocus = FocusManager.instance.primaryFocus;
    if (primaryFocus != null) {
      // 檢查當前焦點是否對應到這些 controller 中的任何一個
      final focusContext = primaryFocus.context;
      if (focusContext != null) {
        // 檢查焦點是否在 TextField 上，並且該 TextField 使用的是我們的 controller
        final textField = focusContext.findAncestorWidgetOfExactType<TextField>();
        if (textField != null) {
          // 檢查這個 TextField 是否使用了我們的 controller
          if (textField.controller == nameController ||
              textField.controller == descriptionController ||
              textField.controller == quantityController ||
              textField.controller == minStockAlertController) {
            primaryFocus.unfocus();
          }
        } else {
          // 如果焦點不在 TextField 上，也移除焦點
          primaryFocus.unfocus();
        }
      } else {
        // 如果沒有 context，直接移除焦點
        primaryFocus.unfocus();
      }
    }
  }
}
