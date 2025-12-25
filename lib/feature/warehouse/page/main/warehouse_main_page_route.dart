part of 'warehouse_main_page.dart';

enum EnumWarehouseMainPageRoute {
  showCreateItemDialog,
  showSearchDialog,
}

extension WarehouseMainPageRouteExtension on WarehouseMainPageController {
  void routerHandle(
    EnumWarehouseMainPageRoute type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumWarehouseMainPageRoute.showCreateItemDialog:
        _service.showAlert(
          DialogItemCreateWidget(
            onConfirm: (outputModel) async {
              return await _createItem(outputModel);
            },
          ),
        );
      case EnumWarehouseMainPageRoute.showSearchDialog:
        _service.showAlert(
          DialogItemSearchWidget(
            onConfirm: _service.addSearchCondition,
          ),
        );
    }
  }

  Future<void> _showCreateItemDialog() async {
    try {
      // TODO: Implement if needed
    } on Exception catch (e) {
      // 错误处理
      final context = Get.context;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(EnumLocale.warehouseErrorFetchData.trArgs([e.toString()])),
          ),
        );
      }
    }
  }

  // void _showCreateCabinetDialog() {
  //   try {
  //     final service = WarehouseService.instance;

  //     // 构建房间数据
  //     final household = WarehouseHomeRouterData(
  //       id: service.house?.id ?? '',
  //       name: service.house?.name ?? '',
  //     );
  //     final rooms = service.rooms
  //         .map(
  //           (room) => WarehouseHomeRouterData(
  //             id: room.id ?? '',
  //             name: room.name ?? '',
  //           ),
  //         )
  //         .toList();

  //     // 显示创建橱柜 dialog
  //     DialogCreateCabinet.show(
  //       household: household,
  //       rooms: rooms,
  //       onConfirm: (name, roomId, description) {
  //         // `TODO`: 实现新增櫥櫃逻辑
  //         // 可以在这里调用 API 创建橱柜
  //       },
  //       onCancel: () {
  //         // 取消操作
  //       },
  //     );
  //   } catch (e) {
  //     // 错误处理
  //     final context = Get.context;
  //     if (context != null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content:
  //               Text(EnumLocale.warehouseErrorFetchData.trArgs([e.toString()])),
  //         ),
  //       );
  //     }
  //   }
  // }

  // Future<void> _showCreateCategoryDialog() async {
  //   try {
  //     // 获取分类数据
  //     final response =
  //         await ApiUtil.sendRequest<WarehouseCategoryResponseModel>(
  //       EnumApiInfo.categoryFetch,
  //       requestModel: WarehouseCategoryRequestModel(),
  //       fromJson: WarehouseCategoryResponseModel.fromJson,
  //     );

  //     final categories = response?.data ?? [];

  //     // 显示创建分类 dialog
  //   } catch (e) {
  //     // 错误处理
  //     final context = Get.context;
  //     if (context != null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content:
  //               Text(EnumLocale.warehouseErrorFetchData.trArgs([e.toString()])),
  //         ),
  //       );
  //     }
  //   }
  // }

  // void _showSearchLogDialog() {
  //   try {
  //     // 获取当前记录页面的 controller（如果存在）
  //     WarehouseRecordPageController? recordController;
  //     try {
  //       recordController = Get.find<WarehouseRecordPageController>();
  //     } catch (e) {
  //       // Controller 可能还未初始化
  //     }

  //     // 显示搜索日志对话框
  //     DialogSearchLog.show(
  //       // initialStartDate: recordController?.startDate,
  //       // initialEndDate: recordController?.endDate,
  //       // initialOperateType: recordController?.filterOperateType,
  //       // initialEntityType: recordController?.filterEntityType,
  //       onConfirm: ({
  //         DateTime? startDate,
  //         DateTime? endDate,
  //         EnumOperateType? operateType,
  //         EnumEntityType? entityType,
  //       }) {
  //         // 应用筛选条件
  //         if (recordController != null) {
  //           // recordController.applyFilters(
  //           //   startDate: startDate,
  //           //   endDate: endDate,
  //           //   operateType: operateType,
  //           //   entityType: entityType,
  //           // );
  //         }
  //       },
  //       onCancel: () {
  //         // 取消操作
  //       },
  //     );
  //   } catch (e) {
  //     // 错误处理
  //     final context = Get.context;
  //     if (context != null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //               EnumLocale.warehouseErrorOpenDialog.trArgs([e.toString()])),
  //         ),
  //       );
  //     }
  //   }
  // }

  // void _showSearchAlarmDialog() {
  //   try {
  //     // 获取当前告警页面的 controller（如果存在）
  //     WarehouseAlarmPageController? alarmController;
  //     try {
  //       alarmController = Get.find<WarehouseAlarmPageController>();
  //     } catch (e) {
  //       // Controller 可能还未初始化
  //     }

  //     // 显示搜索告警对话框
  //     DialogSearchAlarm.show(
  //       initialStartDate: null,
  //       initialEndDate: null,
  //       onConfirm: ({
  //         DateTime? startDate,
  //         DateTime? endDate,
  //       }) {
  //         // 应用筛选条件
  //         if (alarmController != null) {
  //           // alarmController.applyFilters(
  //           //   startDate: startDate,
  //           //   endDate: endDate,
  //           // );
  //         }
  //       },
  //       onCancel: () {
  //         // 取消操作
  //       },
  //     );
  //   } catch (e) {
  //     // 错误处理
  //     final context = Get.context;
  //     if (context != null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //               EnumLocale.warehouseErrorOpenDialog.trArgs([e.toString()])),
  //         ),
  //       );
  //     }
  //   }
  // }

  // void _showSearchCategoryDialog() {
  //   try {
  //     // 获取当前分类页面的 controller（如果存在）
  //     WarehouseCategoryPageController? categoryController;
  //     try {
  //       categoryController = Get.find<WarehouseCategoryPageController>();
  //     } catch (e) {
  //       // Controller 可能还未初始化
  //     }

  //     // 显示搜索分类对话框
  //     DialogSearchCategory.show(
  //       // initialName: categoryController?.filterName,
  //       // initialLevel: categoryController?.filterLevel,
  //       onConfirm: ({
  //         String? name,
  //         int? level,
  //       }) {
  //         // 应用筛选条件
  //         if (categoryController != null) {
  //           // categoryController.applyFilters(
  //           //   name: name,
  //           //   level: level,
  //           // );
  //         }
  //       },
  //       onCancel: () {
  //         // 取消操作
  //       },
  //     );
  //   } catch (e) {
  //     // 错误处理
  //     final context = Get.context;
  //     if (context != null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //               EnumLocale.warehouseErrorOpenDialog.trArgs([e.toString()])),
  //         ),
  //       );
  //     }
  //   }
  // }

  // void _showSearchCabinetDialog() {
  //   try {
  //     // 获取当前櫥櫃页面的 controller（如果存在）
  //     WarehouseCabinetPageController? cabinetController;
  //     try {
  //       cabinetController = Get.find<WarehouseCabinetPageController>();
  //     } catch (e) {
  //       // Controller 可能还未初始化
  //     }

  //     // 显示搜索櫥櫃对话框
  //     DialogSearchCabinet.show(
  //       initialName: 'cabinetController?.filterName',
  //       initialRoomId: 'cabinetController?.filterRoomId',
  //       onConfirm: ({
  //         String? name,
  //         String? roomId,
  //       }) {
  //         // 应用筛选条件
  //         if (cabinetController != null) {
  //           // cabinetController.applyFilters(
  //           //   name: name,
  //           //   roomId: roomId,
  //           // );
  //         }
  //       },
  //       onCancel: () {
  //         // 取消操作
  //       },
  //     );
  //   } catch (e) {
  //     // 错误处理
  //     final context = Get.context;
  //     if (context != null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //               EnumLocale.warehouseErrorOpenDialog.trArgs([e.toString()])),
  //         ),
  //       );
  //     }
  //   }
  // }

  // Future<void> _showSearchItemDialog() async {}
}
