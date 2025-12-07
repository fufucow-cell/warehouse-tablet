part of 'warehouse_item_page.dart';

class WarehouseItemPageController
    extends BasePageController {
  // MARK: - Properties

  final _model = WarehouseItemPageModel();
  List<Item>? get items => _model.items;
  Rx<bool> get isEditModeRx => _model.isEditMode;
  String? get filterName => _model.filterName;
  String? get filterCategoryId => _model.filterCategoryId;
  String? get filterRoomId => _model.filterRoomId;
  String? get filterCabinetId => _model.filterCabinetId;

  // MARK: - Init

  WarehouseItemPageController() {
    super.init();
  }

  // MARK: - Methods

  @override
  Future<void> apiProcessing() async {
    final response = await ApiUtil.sendRequest<
        WarehouseItemResponseModel>(
      EnumApiInfo.itemFetch,
      requestModel: WarehouseItemRequestModel(),
      fromJson: WarehouseItemResponseModel.fromJson,
    );

    _model.allItems = response.data;
    _applyFilters();
    update();
  }

  // 应用筛选条件
  void applyFilters({
    String? name,
    String? categoryId,
    String? roomId,
    String? cabinetId,
  }) {
    _model.filterName = name;
    _model.filterCategoryId = categoryId;
    _model.filterRoomId = roomId;
    _model.filterCabinetId = cabinetId;
    _applyFilters();
    update();
  }

  // 内部筛选方法
  void _applyFilters() {
    if (_model.allItems == null) {
      _model.items = null;
      return;
    }

    List<Item> filteredItems = List.from(_model.allItems!);

    // 按名称筛选
    if (_model.filterName != null &&
        _model.filterName!.isNotEmpty) {
      final searchName = _model.filterName!.toLowerCase();
      filteredItems = filteredItems.where((item) {
        final itemName = item.name?.toLowerCase() ?? '';
        return itemName.contains(searchName);
      }).toList();
    }

    // 按分类筛选
    if (_model.filterCategoryId != null) {
      filteredItems = filteredItems.where((item) {
        // 检查 item 的分类 ID 是否匹配（需要遍历分类层级）
        return _matchesCategoryId(
            item.category, _model.filterCategoryId!);
      }).toList();
    }

    // 按房间筛选
    if (_model.filterRoomId != null) {
      if (_model.filterRoomId == '__UNSET__') {
        // 筛选未设定房间的物品
        filteredItems = filteredItems.where((item) {
          return item.rooms == null || item.rooms!.isEmpty;
        }).toList();
      } else {
        // 筛选特定房间的物品
        filteredItems = filteredItems.where((item) {
          if (item.rooms == null || item.rooms!.isEmpty)
            return false;
          return item.rooms!.any(
              (room) => room.roomId == _model.filterRoomId);
        }).toList();
      }
    }

    // 按橱柜筛选
    if (_model.filterCabinetId != null) {
      if (_model.filterCabinetId == '__UNSET__') {
        // 筛选未设定橱柜的物品
        filteredItems = filteredItems.where((item) {
          if (item.rooms == null || item.rooms!.isEmpty)
            return true;
          return item.rooms!.every(
            (room) =>
                room.cabinets == null ||
                room.cabinets!.isEmpty,
          );
        }).toList();
      } else {
        // 筛选特定橱柜的物品
        filteredItems = filteredItems.where((item) {
          if (item.rooms == null || item.rooms!.isEmpty)
            return false;
          return item.rooms!.any((room) {
            if (room.cabinets == null ||
                room.cabinets!.isEmpty) return false;
            return room.cabinets!.any(
              (cabinet) =>
                  cabinet.cabinetId ==
                  _model.filterCabinetId,
            );
          });
        }).toList();
      }
    }

    _model.items = filteredItems;
  }

  // 检查分类是否匹配（递归检查分类层级）
  bool _matchesCategoryId(
      dynamic category, String targetCategoryId) {
    if (category == null) return false;

    // 如果 category 是 Category 类型
    if (category is Category) {
      if (category.categoryId == targetCategoryId)
        return true;

      // 检查子分类
      if (category.children != null) {
        final child =
            _childrenToCategory(category.children);
        if (child != null &&
            _matchesCategoryId(child, targetCategoryId)) {
          return true;
        }
      }
    }

    return false;
  }

  // 将 Children 转换为 Category
  Category? _childrenToCategory(dynamic children) {
    if (children == null) return null;
    if (children is Children) {
      return Category(
        categoryId: children.categoryId,
        name: children.name,
        level: children.level,
        children: children.children is Map<String, dynamic>
            ? Children.fromJson(
                children.children as Map<String, dynamic>,
              )
            : null,
      );
    }
    return null;
  }

  // 切换编辑模式
  void toggleEditMode() {
    _model.isEditMode.value = !_model.isEditMode.value;
    update();
  }

  // 删除物品
  void deleteItem(Item item) {
    // TODO: 实现删除物品的逻辑
    print('删除物品: ${item.name} (${item.itemId})');
  }
}
