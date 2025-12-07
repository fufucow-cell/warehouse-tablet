part of 'warehouse_main_page.dart';

enum EnumWarehouseMainPageRoute {
  showSomeDialog,
  showCreateItemDialog,
  showCreateCabinetDialog,
  showCreateCategoryDialog,
}

extension WarehouseMainPageRouteExtension
    on WarehouseMainPageController {
  void routerHandle(
    EnumWarehouseMainPageRoute type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumWarehouseMainPageRoute.showSomeDialog:
        break;
      case EnumWarehouseMainPageRoute.showCreateItemDialog:
        _showCreateItemDialog();
        break;
      case EnumWarehouseMainPageRoute
            .showCreateCabinetDialog:
        _showCreateCabinetDialog();
        break;
      case EnumWarehouseMainPageRoute
            .showCreateCategoryDialog:
        _showCreateCategoryDialog();
        break;
    }
  }

  void _showCreateItemDialog() {
    final context = Get.context;
    if (context == null) return;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: const Text('新增物品'),
        content: const Text('新增物品功能開發中...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: 实现新增物品逻辑
            },
            child: const Text('確認'),
          ),
        ],
      ),
    );
  }

  void _showCreateCabinetDialog() {
    final context = Get.context;
    if (context == null) return;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: const Text('新增櫥櫃'),
        content: const Text('新增櫥櫃功能開發中...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: 实现新增櫥櫃逻辑
            },
            child: const Text('確認'),
          ),
        ],
      ),
    );
  }

  Future<void> _showCreateCategoryDialog() async {
    try {
      // 获取分类数据
      final response = await ApiUtil.sendRequest<
          WarehouseCategoryResponseModel>(
        EnumApiInfo.categoryFetch,
        requestModel: WarehouseCategoryRequestModel(),
        fromJson: WarehouseCategoryResponseModel.fromJson,
      );

      final categories = response.data ?? [];

      // 显示创建分类 dialog
      DialogCreateCategory.show(
        categories: categories,
        onConfirm: (name, parentId) {
          // TODO: 实现新增分類逻辑
          // 可以在这里调用 API 创建分类
        },
        onCancel: () {
          // 取消操作
        },
      );
    } catch (e) {
      // 错误处理
      final context = Get.context;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('获取分类数据失败：$e'),
          ),
        );
      }
    }
  }
}
