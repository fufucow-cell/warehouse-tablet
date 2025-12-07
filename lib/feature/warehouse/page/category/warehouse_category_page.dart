import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_api_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_category_request_model/warehouse_category_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/children.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/warehouse_category_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/api_util.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'warehouse_category_page_controller.dart';
part 'warehouse_category_page_interactive.dart';
part 'warehouse_category_page_model.dart';
part 'warehouse_category_page_route.dart';

class WarehouseCategoryPage
    extends GetView<WarehouseCategoryPageController> {
  const WarehouseCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseCategoryPageController>(
      init: WarehouseCategoryPageController(),
      builder: (controller) {
        return Obx(
          () {
            return Skeletonizer(
              enabled: controller.isLoadingRx.value,
              child: _Body(),
            );
          },
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseCategoryPageController>(
      builder: (controller) {
        final categories =
            controller.getFlattenedCategories();

        if (categories.isEmpty) {
          return const Center(
            child: Text('暂无分类'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final level = category.level ?? 0;
            return _CategoryItem(
              category: category,
              level: level,
            );
          },
        );
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  final int level;

  const _CategoryItem({
    required this.category,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.find<WarehouseCategoryPageController>();

    return Padding(
      padding: EdgeInsets.only(left: level * 24.0),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: Obx(
          () {
            final isEditMode =
                controller.isEditModeRx.value;
            final hasChildren = category.children != null;
            final isLevel1Or2 = level == 1 || level == 2;
            final isExpanded = isLevel1Or2 && hasChildren
                ? controller.isCategoryExpanded(category)
                : false;

            return ListTile(
              leading: Icon(
                _getIconForLevel(level),
                color: _getColorForLevel(level),
              ),
              title: Text(
                category.name ?? '未命名分类',
                style: TextStyle(
                  fontWeight: level == 0
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              subtitle: category.categoryId != null
                  ? Text('ID: ${category.categoryId}')
                  : null,
              trailing: _buildTrailing(
                isEditMode: isEditMode,
                hasChildren: hasChildren,
                isLevel1Or2: isLevel1Or2,
                isExpanded: isExpanded,
                controller: controller,
                category: category,
              ),
            );
          },
        ),
      ),
    );
  }

  // 构建 trailing widget（可以同时显示多个按钮）
  Widget? _buildTrailing({
    required bool isEditMode,
    required bool hasChildren,
    required bool isLevel1Or2,
    required bool isExpanded,
    required WarehouseCategoryPageController controller,
    required Category category,
  }) {
    final List<Widget> buttons = [];

    // 如果有子分类且是 level 1 或 2，显示展开/收合按钮
    if (hasChildren && isLevel1Or2) {
      buttons.add(
        IconButton(
          icon: Icon(
            isExpanded
                ? Icons.keyboard_arrow_down
                : Icons.keyboard_arrow_right,
            size: 24,
            color: Colors.grey,
          ),
          onPressed: () {
            controller.toggleCategoryExpansion(category);
          },
        ),
      );
    }

    // 如果是编辑模式，显示删除按钮
    if (isEditMode) {
      buttons.add(
        IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            controller.deleteCategory(category);
          },
        ),
      );
    }

    // 如果没有任何按钮，返回 null
    if (buttons.isEmpty) {
      return null;
    }

    // 如果只有一个按钮，直接返回
    if (buttons.length == 1) {
      return buttons.first;
    }

    // 如果有多个按钮，使用 Row 包裹
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: buttons,
    );
  }

  IconData _getIconForLevel(int level) {
    switch (level) {
      case 0:
        return Icons.category;
      case 1:
        return Icons.folder;
      case 2:
        return Icons.folder_open;
      default:
        return Icons.label;
    }
  }

  Color _getColorForLevel(int level) {
    switch (level) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
