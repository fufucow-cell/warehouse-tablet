# 项目开发计划 2 (Project Plan 2)

## 📋 项目概述

这是 PLAN.md 的补充文档，记录 PLAN.md 中未完成或遗漏的任务。

---

## 📝 PLAN.md 中未完成的任务

### Circuit Breaker 功能入口集成

#### 1. `lib/feature/app/page/main` 功能入口

**问题描述**：
- 虽然 `app_main_page_model.dart` 中已经定义了 `EnumAppMainTabItem.circuitBreaker` 和 `EnumAppMainRouter.circuitBreaker`
- 但需要确认左侧菜单（`_TabListWidget`）是否正确显示 Circuit Breaker 选项

**待完成任务**：
- [ ] 确认 `app_main_page.dart` 中的 `_TabListWidget` 是否正确遍历所有 `EnumAppMainTabItem.values`（应该已经包含 circuitBreaker）
- [ ] 确认左侧菜单中 Circuit Breaker 选项可以正常点击和跳转
- [ ] 确认图标和文字显示正确（图标：`Icons.power_settings_new`，文字：`EnumLocale.smartHomeTabCircuitBreaker.tr`）

**相关文件**：
- `lib/feature/app/page/main/app_main_page.dart`
- `lib/feature/app/page/main/app_main_page_model.dart`
- `lib/feature/app/page/main/app_main_page_controller.dart`

---

#### 2. `lib/feature/smart_home/page` 功能入口

**问题描述**：
- 需要在 smart_home 相关页面中添加 Circuit Breaker 功能的入口
- 可能需要在以下页面中显示功能列表或入口：
  - `smart_home_household_page.dart` - 家庭页面可能需要显示可用功能模块
  - `smart_home_gateway_page.dart` - 网关页面可能需要显示相关设备/功能
  - 或其他需要显示功能选择列表的页面

**待完成任务**：
- [ ] 确定需要在哪个 smart_home 页面中添加 Circuit Breaker 入口
- [ ] 如果需要在 household 页面显示功能列表：
  - [ ] 添加功能模块列表（Gateway、Warehouse、Circuit Breaker 等）
  - [ ] 每个功能项可点击跳转到对应页面
  - [ ] 参考 gateway children page 的设备列表样式
- [ ] 如果需要在 gateway 页面显示相关功能：
  - [ ] 添加 Circuit Breaker 相关入口或设备列表项
- [ ] 实现功能列表的 UI 组件
- [ ] 实现点击跳转逻辑

**参考实现**：
- `lib/wh/feature/gateway/page/children/gateway_children_page.dart` - 设备列表实现
- `lib/wh/feature/warehouse/page/item/ui/item_list.dart` - 物品列表实现

**相关文件**：
- `lib/feature/smart_home/page/household/smart_home_household_page.dart`
- `lib/feature/smart_home/page/gateway/smart_home_gateway_page.dart`
- `lib/feature/smart_home/page/circuit_breaker/smart_home_circuit_breaker_page.dart`

---

## 🔍 需要确认的问题

1. **功能入口位置**：
   - Circuit Breaker 功能是否只需要通过左侧主菜单访问？
   - 还是需要在 smart_home 的某个页面中显示功能列表？

2. **UI 设计**：
   - 如果需要在页面中显示功能列表，UI 设计是什么样的？
   - 是否需要参考 gateway children page 的卡片列表样式？
   - 还是使用其他样式（如 GridView、ListView 等）？

3. **数据来源**：
   - 功能列表的数据是从哪里来的？
   - 是否需要通过 API 获取？
   - 还是硬编码在代码中？

---

**最后更新**: 2025-01-20
**维护者**: 开发团队
