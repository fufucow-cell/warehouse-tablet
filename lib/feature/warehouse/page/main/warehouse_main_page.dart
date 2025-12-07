import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog/dialog_create_category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/page_reference.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_category_request_model/warehouse_category_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/warehouse_category_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/api_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:flutter_smart_home_tablet/util/environment_util.dart';
import 'package:get/get.dart';

part 'warehouse_main_page_controller.dart';
part 'warehouse_main_page_interactive.dart';
part 'warehouse_main_page_model.dart';
part 'warehouse_main_page_route.dart';

class WarehouseMainPage extends StatefulWidget {
  final WarehouseMainPageRouterData routerData;

  const WarehouseMainPage({
    super.key,
    required this.routerData,
  });

  @override
  State<WarehouseMainPage> createState() =>
      _WarehouseMainPageState();
}

class _WarehouseMainPageState
    extends State<WarehouseMainPage>
    with SingleTickerProviderStateMixin {
  late final WarehouseMainPageController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        WarehouseMainPageController(widget.routerData);
    _controller.initTabController(this);
  }

  @override
  void dispose() {
    _controller.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseMainPageController>(
      init: _controller,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor:
                Theme.of(context).colorScheme.primary,
            centerTitle: true,
            title: const Text(
              '智能倉庫',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              // 搜索图标（所有页面都显示）
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  controller.interactive(
                    EnumWarehouseMainPageInteractive
                        .tapSearch,
                  );
                },
              ),
              // 根据当前 tab 显示新增或编辑图标
              Obx(() {
                final selectedItem =
                    controller.selectedItemRx.value;
                final isCreatePage = selectedItem ==
                        EnumWarehouseTabItem.item ||
                    selectedItem ==
                        EnumWarehouseTabItem.cabinet ||
                    selectedItem ==
                        EnumWarehouseTabItem.category;
                final isCategoryPage = selectedItem ==
                    EnumWarehouseTabItem.category;

                if (isCreatePage) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 新增图标
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          controller.interactive(
                            EnumWarehouseMainPageInteractive
                                .tapCreate,
                          );
                          if (selectedItem ==
                              EnumWarehouseTabItem.item) {
                            controller.routerHandle(
                              EnumWarehouseMainPageRoute
                                  .showCreateItemDialog,
                            );
                          } else if (selectedItem ==
                              EnumWarehouseTabItem
                                  .cabinet) {
                            controller.routerHandle(
                              EnumWarehouseMainPageRoute
                                  .showCreateCabinetDialog,
                            );
                          } else if (selectedItem ==
                              EnumWarehouseTabItem
                                  .category) {
                            controller.routerHandle(
                              EnumWarehouseMainPageRoute
                                  .showCreateCategoryDialog,
                            );
                          }
                        },
                      ),
                      // Category 页面额外显示编辑图标
                      if (isCategoryPage)
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            controller.interactive(
                              EnumWarehouseMainPageInteractive
                                  .tapEdit,
                            );
                            // 切换分类页面的编辑模式
                            try {
                              final categoryController =
                                  Get.find<
                                      WarehouseCategoryPageController>();
                              categoryController
                                  .toggleEditMode();
                            } catch (e) {
                              // Controller 可能还未初始化，忽略错误
                            }
                          },
                        ),
                    ],
                  );
                } else {
                  return IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      controller.interactive(
                        EnumWarehouseMainPageInteractive
                            .tapEdit,
                      );
                      // TODO: 实现编辑功能
                    },
                  );
                }
              }),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Container(
                color: Colors.white,
                child: TabBar(
                  controller: controller.tabController,
                  tabs: controller.tabs,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black54,
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 18,
                  ),
                  indicatorColor: Colors.black,
                ),
              ),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: TabBarView(
              controller: controller.tabController,
              children: controller.tabViews,
            ),
          ),
        );
      },
    );
  }
}
