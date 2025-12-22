part of 'warehouse_main_page.dart';

enum EnumWarehouseMainPageRoute {
  showSomeDialog,
  showCreateItemDialog,
  showCreateCabinetDialog,
  showCreateCategoryDialog,
  showSearchLogDialog,
  showSearchAlarmDialog,
  showSearchCategoryDialog,
  showSearchCabinetDialog,
  showSearchItemDialog,
}

extension WarehouseMainPageRouteExtension on WarehouseMainPageController {
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
      case EnumWarehouseMainPageRoute.showCreateCabinetDialog:
        _showCreateCabinetDialog();
        break;
      case EnumWarehouseMainPageRoute.showCreateCategoryDialog:
        _showCreateCategoryDialog();
        break;
      case EnumWarehouseMainPageRoute.showSearchLogDialog:
        _showSearchLogDialog();
        break;
      case EnumWarehouseMainPageRoute.showSearchAlarmDialog:
        _showSearchAlarmDialog();
        break;
      case EnumWarehouseMainPageRoute.showSearchCategoryDialog:
        _showSearchCategoryDialog();
        break;
      case EnumWarehouseMainPageRoute.showSearchCabinetDialog:
        _showSearchCabinetDialog();
        break;
      case EnumWarehouseMainPageRoute.showSearchItemDialog:
        _showSearchItemDialog();
        break;
    }
  }

  Future<void> _showCreateItemDialog() async {
    try {
      // 获取分类数据和橱柜数据
      final categoryResponse = await ApiUtil.sendRequest<WarehouseCategoryResponseModel>(
        EnumApiInfo.categoryFetch,
        requestModel: WarehouseCategoryRequestModel(),
        fromJson: WarehouseCategoryResponseModel.fromJson,
      );

      final categories = categoryResponse?.data ?? [];
      // final cabinets = cabinetResponse?.data ?? [];
    } on Exception catch (e) {
      // 错误处理
      final context = Get.context;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(EnumLocale.warehouseErrorFetchData.tr.replaceAll('{error}', e.toString())),
          ),
        );
      }
    }
  }

  void _showCreateCabinetDialog() {
    try {
      final service = WarehouseService.instance;

      // 构建房间数据
      final household = WarehouseHomeRouterData(
        id: service.house?.id ?? '',
        name: service.house?.name ?? '',
      );
      final rooms = service.rooms
          .map(
            (room) => WarehouseHomeRouterData(
              id: room.id ?? '',
              name: room.name ?? '',
            ),
          )
          .toList();

      // 显示创建橱柜 dialog
      DialogCreateCabinet.show(
        household: household,
        rooms: rooms,
        onConfirm: (name, roomId, description) {
          // TODO: 实现新增櫥櫃逻辑
          // 可以在这里调用 API 创建橱柜
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
            content: Text(EnumLocale.warehouseErrorFetchData.tr.replaceAll('{error}', e.toString())),
          ),
        );
      }
    }
  }

  Future<void> _showCreateCategoryDialog() async {
    try {
      // 获取分类数据
      final response = await ApiUtil.sendRequest<WarehouseCategoryResponseModel>(
        EnumApiInfo.categoryFetch,
        requestModel: WarehouseCategoryRequestModel(),
        fromJson: WarehouseCategoryResponseModel.fromJson,
      );

      final categories = response?.data ?? [];

      // 显示创建分类 dialog
    } catch (e) {
      // 错误处理
      final context = Get.context;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(EnumLocale.warehouseErrorFetchData.tr.replaceAll('{error}', e.toString())),
          ),
        );
      }
    }
  }

  void _showSearchLogDialog() {
    try {
      // 获取当前记录页面的 controller（如果存在）
      WarehouseRecordPageController? recordController;
      try {
        recordController = Get.find<WarehouseRecordPageController>();
      } catch (e) {
        // Controller 可能还未初始化
      }

      // 显示搜索日志对话框
      DialogSearchLog.show(
        // initialStartDate: recordController?.startDate,
        // initialEndDate: recordController?.endDate,
        // initialOperateType: recordController?.filterOperateType,
        // initialEntityType: recordController?.filterEntityType,
        onConfirm: ({
          DateTime? startDate,
          DateTime? endDate,
          EnumOperateType? operateType,
          EnumEntityType? entityType,
        }) {
          // 应用筛选条件
          if (recordController != null) {
            // recordController.applyFilters(
            //   startDate: startDate,
            //   endDate: endDate,
            //   operateType: operateType,
            //   entityType: entityType,
            // );
          }
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
            content: Text(EnumLocale.warehouseErrorOpenDialog.tr.replaceAll('{error}', e.toString())),
          ),
        );
      }
    }
  }

  void _showSearchAlarmDialog() {
    try {
      // 获取当前告警页面的 controller（如果存在）
      WarehouseAlarmPageController? alarmController;
      try {
        alarmController = Get.find<WarehouseAlarmPageController>();
      } catch (e) {
        // Controller 可能还未初始化
      }

      // 显示搜索告警对话框
      DialogSearchAlarm.show(
        initialStartDate: alarmController?.startDate,
        initialEndDate: alarmController?.endDate,
        onConfirm: ({
          DateTime? startDate,
          DateTime? endDate,
        }) {
          // 应用筛选条件
          if (alarmController != null) {
            alarmController.applyFilters(
              startDate: startDate,
              endDate: endDate,
            );
          }
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
            content: Text(EnumLocale.warehouseErrorOpenDialog.tr.replaceAll('{error}', e.toString())),
          ),
        );
      }
    }
  }

  void _showSearchCategoryDialog() {
    try {
      // 获取当前分类页面的 controller（如果存在）
      WarehouseCategoryPageController? categoryController;
      try {
        categoryController = Get.find<WarehouseCategoryPageController>();
      } catch (e) {
        // Controller 可能还未初始化
      }

      // 显示搜索分类对话框
      DialogSearchCategory.show(
        initialName: categoryController?.filterName,
        initialLevel: categoryController?.filterLevel,
        onConfirm: ({
          String? name,
          int? level,
        }) {
          // 应用筛选条件
          if (categoryController != null) {
            categoryController.applyFilters(
              name: name,
              level: level,
            );
          }
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
            content: Text(EnumLocale.warehouseErrorOpenDialog.tr.replaceAll('{error}', e.toString())),
          ),
        );
      }
    }
  }

  void _showSearchCabinetDialog() {
    try {
      // 获取当前櫥櫃页面的 controller（如果存在）
      WarehouseCabinetPageController? cabinetController;
      try {
        cabinetController = Get.find<WarehouseCabinetPageController>();
      } catch (e) {
        // Controller 可能还未初始化
      }

      // 显示搜索櫥櫃对话框
      DialogSearchCabinet.show(
        initialName: 'cabinetController?.filterName',
        initialRoomId: 'cabinetController?.filterRoomId',
        onConfirm: ({
          String? name,
          String? roomId,
        }) {
          // 应用筛选条件
          if (cabinetController != null) {
            // cabinetController.applyFilters(
            //   name: name,
            //   roomId: roomId,
            // );
          }
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
            content: Text(EnumLocale.warehouseErrorOpenDialog.tr.replaceAll('{error}', e.toString())),
          ),
        );
      }
    }
  }

  Future<void> _showSearchItemDialog() async {}
}
