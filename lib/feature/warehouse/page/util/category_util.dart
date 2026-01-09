import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item_category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';

class CategoryUtil {
  static final _service = WarehouseService.instance;
  static List<Category> get getAllLevel1Categories => _service.getAllCategories;

  static List<Category> get getAllLevel2Categories {
    final result = <Category>[];

    for (final cat in _service.getAllCategories) {
      if (cat.children?.isNotEmpty ?? false) {
        result.addAll(cat.children!);
      }
    }

    return result;
  }

  static List<Category> get getAllLevel3Categories {
    final result = <Category>[];

    for (final cat in getAllLevel2Categories) {
      if (cat.children?.isNotEmpty ?? false) {
        result.addAll(cat.children!);
      }
    }

    return result;
  }

  static int getTotalCategoryCount() {
    final lv1Count = getAllLevel1Categories.length;
    final lv2Count = getAllLevel2Categories.length;
    final lv3Count = getAllLevel3Categories.length;
    return lv1Count + lv2Count + lv3Count;
  }

  static int getTotalCategoryCountOnItemsUse() {
    final allItems = _service.getAllCombineItems;
    final Set<String> allCategoryIds = {};

    void extractCategory(ItemCategory? category) {
      if (category?.id?.isEmpty ?? true) {
        return;
      }

      allCategoryIds.add(category!.id!);
      if (category.child != null) {
        extractCategory(category.child);
      }
    }

    for (var item in allItems) {
      extractCategory(item.category);
    }

    return allCategoryIds.length;
  }

  static List<WarehouseNameIdModel> findCategoryLevelsById(String categoryId) {
    final level1Cats = _service.getAllCategories;
    final level2Cats = getAllLevel2Categories;
    final level3Cats = getAllLevel3Categories;

    // 在所有分类中查找指定ID的分类
    Category? findCategoryById(List<Category> categories, String targetId) {
      for (final category in categories) {
        if (category.id == targetId) {
          return category;
        }
      }
      return null;
    }

    // 递归向上追溯 parent 并构建路径
    void buildParentPath(
      Category category,
      List<Category> parentLevel,
      List<WarehouseNameIdModel> result,
    ) {
      // 添加当前分类到结果的开头（保持从根到目标的顺序）
      result.insert(
        0,
        WarehouseNameIdModel(
          id: category.id ?? '',
          name: category.name ?? '',
        ),
      );

      // 如果有 parentId 且还有父级层级可查，继续向上递归查找
      final parentId = category.parentId;
      if (parentId != null && parentId.isNotEmpty && parentLevel.isNotEmpty) {
        final parent = findCategoryById(parentLevel, parentId);
        if (parent != null) {
          // 确定下一个父级层级：level2 的父级是 level1，level1 没有父级
          final nextParentLevel = parentLevel == level2Cats ? level1Cats : <Category>[];
          buildParentPath(parent, nextParentLevel, result);
        }
      }
    }

    // 从最深层（level3）开始查找，然后 level2，最后 level1
    final searchLevels = [
      (level3Cats, level2Cats), // level3 的父级是 level2
      (level2Cats, level1Cats), // level2 的父级是 level1
      (level1Cats, <Category>[]), // level1 没有父级
    ];

    for (final (searchLevel, parentLevel) in searchLevels) {
      final targetCategory = findCategoryById(searchLevel, categoryId);
      if (targetCategory != null) {
        final result = <WarehouseNameIdModel>[];
        buildParentPath(targetCategory, parentLevel, result);
        return result;
      }
    }

    // 没找到，返回空列表
    return <WarehouseNameIdModel>[];
  }
}
