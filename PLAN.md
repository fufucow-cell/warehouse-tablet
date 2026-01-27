# 项目计划

## 项目概述

本文档用于记录项目的开发计划、功能规划和待办事项。

## Feature 详细规划

### air_box - 空气盒功能

**功能描述：**
侦测并显示空气的温度、湿度、PM 2.5 等环境数据。

**Feature 信息：**
- Feature 名称：`air_box`
- 目录路径：`lib/wh/feature/air_box/`

**页面规划：**

#### 1. main 页面
- **路径**：`lib/wh/feature/air_box/page/main/`
- **功能**：
  - 显示当前实时空气数据（PM 2.5、温度、湿度、甲醛、VOC、CO2）
  - PM 2.5 大数字可视化展示（中心区域）
  - 数据卡片横向展示（底部）
  - 数据紀錄入口
  - 智能連動入口
- **UI 组件结构**（根据 Figma 设计）：

  **TopBar**：
  - 返回按钮（80x80，橙色）
    - 功能：调用 `RouterData.onBackButtonTap` callback
  - 标题"空氣盒"（40pt，粗体）
    - 日间：`#292929`
    - 夜间：`Colors.white`
  - 编辑按钮（50x50）
    - 功能：调用 `RouterData.onEditButtonTap` callback（参考 circuit_breaker）
    - 返回新名称用于更新标题
  - 设置按钮（62x62）
    - 功能：调用 `RouterData.onSettingButtonTap` callback（参考 circuit_breaker）

  **中心区域**（PM 2.5 显示）：
  - PM 2.5 大数字（180pt，粗体，颜色：`#96B7E3`，日间/夜间相同）
  - 状态文字"良好"（40pt，颜色：`#96B7E3`，日间/夜间相同）
  - 状态指示器：绿色圆点（33x33，颜色：`#40CE5F`，日间/夜间相同）
  - 圆形背景装饰（颜色根据主题变化）

  **数据卡片**（横向排列）：
  - 當前溫度：26.6°C（38pt，粗体，颜色：`#96B7E3`，日间/夜间相同）
  - 當前濕度：（26pt）
  - 甲醛測試值：（26pt）
  - VOC偵測值：（26pt）
  - CO2偵測值：（26pt）
  - 标签文字颜色：
    - 日间：`#292929`
    - 夜间：`Colors.white`
  - 使用分隔线分隔（75px 高度，旋转 90 度）
  - 背景：渐变效果（白色到橙色，透明度渐变，日间/夜间相同）
  - 边框：1px，圆角 12px
    - 日间：`#FB9B51`
    - 夜间：`#FDB874`

  **数据紀錄区域**：
  - 标题"數據紀錄"（32pt）
    - 日间：`#292929`
    - 夜间：`Colors.white`
  - 按钮图标（58x58）
  - 点击跳转到 record 页面
  - 分隔线颜色：
    - 日间：`#7C7C7C`
    - 夜间：`#DCDCDC`

  **智能連動区域**：
  - ❌ **已移除**（不需要此功能）

#### 2. record 页面
- **路径**：`lib/wh/feature/air_box/page/record/`
- **功能**：
  - 查看历史空气数据记录（温度、湿度、PM 2.5）
  - 时间筛选（日、月、年）
  - 数据类型切换（温度、湿度、PM 2.5）
  - 日期选择器
  - 图表展示（根据选择的数据类型和时间范围）
- **参考实现**：
  - 参考 `lib/wh/feature/circuit_breaker/page/data_record/circuit_breaker_data_record_page.dart` 的实现方式
  - 使用 `FirstBackgroundCard` 作为页面容器
  - 使用 `fl_chart` 库显示图表
- **UI 组件结构**（参考 circuit_breaker_data_record_page）：

  **TopBar**：
  - 返回按钮（80x80，橙色）
  - 标题"數據紀錄"（40pt，粗体，居中）
  - 设置按钮（62x62）

  **TimeFilter 区域**（年月日 TabBar）：
  - 三个 Tab：日、月、年
  - 选中状态：橙色背景（`EnumColor.engoBackgroundOrange400`），白色文字
  - 未选中状态：透明背景，次要文字颜色
  - 边框：1px，橙色（`EnumColor.engoButtonBorderReverse`），圆角 8px

  **StatisticsSection 区域**（中间部分）：
  - **左侧**：数据类型 TabBar（温度、湿度、PM 2.5）
    - 三个 Tab 可切换
    - 样式与 TimeFilter 相同
    - 移除电量信息显示
  - **右侧**：日期选择器
    - 宽度：426px
    - 高度：88px
    - 背景色：`EnumColor.engoBackgroundButton`
    - 显示当前选择的日期
    - 右侧有下拉箭头图标
    - 点击可打开日期选择器

  **ChartSection 区域**（图表展示）：
  - 使用 `LineChart`（曲线图，fl_chart 库）
  - 根据左侧选择的数据类型（温度/湿度/PM 2.5）显示对应数据
  - 根据上方选择的时间范围（日/月/年）调整 X 轴标签
  - 支持空状态和加载状态（Shimmer）
  - Y 轴根据数据自动调整最大值和间隔
  - **曲线样式**：
    - 所有数据类型使用**同一颜色**（因为单位不同不能同时显示）
    - 数据点使用**圆点**显示
    - **不显示**最大值/最小值标记

#### 3. reference 页面（级距参考表）
- **路径**：`lib/wh/feature/air_box/page/reference/`
- **功能**：
  - 显示各参数的级距参考标准
  - 支持切换不同参数（PM2.5、温度、湿度、甲醛、VOC、CO2）
  - 显示每个级距的范围、颜色指示器、状态文字
- **参考实现**：
  - 参考空气清净机的参考值页面格式
  - 使用 `FirstBackgroundCard` 作为页面容器
  - 使用 TabBar 或下拉菜单切换不同参数
- **UI 组件结构**（根据提供的 PM2.5 参考页面代码）：

  **TopBar**：
  - 返回按钮（80x80）
  - 标题"空氣盒"（40pt，粗体，白色）
  - 设置按钮（62x62）

  **设备名称区域**：
  - 显示设备位置名称（例如："中山區-臥室1"）
  - 通过 `RouterData` 传入设备名称
  - 32pt，白色，居中

  **参数选择区域**：
  - 使用 `CustTextDropdownButton` 下拉菜单（参考 `warehouse_record_page` 的 `FilterInfo`）
  - 参数选项：PM2.5、温度、湿度、甲醛、VOC、CO2
  - 宽度：280px，高度：70px
  - 样式参考 warehouse 的 filter dropdown

  **参数信息区域**：
  - **参数标题**：参数名称（32pt，粗体，白色，居中）
  - **参数描述**：参数说明文字（26pt，白色，居中）
  - **单位显示**：参数规格单位（32pt，白色）
    - PM2.5：µg/m³
    - 温度：°C
    - 湿度：%
    - 甲醛：mg/m³
    - VOC：mg/m³
    - CO2：%（或 ppm）

  **级距列表区域**：
  - 每个级距包含：
    - 颜色圆点指示器（33x33，圆形）
    - 数值范围（32pt，白色，letterSpacing: 10）
    - 状态文字（32pt，白色，右对齐）
    - 分隔线（1px，白色）
  - **PM2.5 级距**（参考代码，单位：µg/m³）：
    - 良好：0-35，绿色（#40CE5F）
    - 普通：36-53，黄色（#FFCF21）
    - 不良：54-70，橙色（#F88125）
    - 极不良：71-150，红色（#EF4425）
  
  - **温度级距**（单位：°C，参考 GB/T 18883-2022）：
    - 良好：22-26（夏季舒适范围）
    - 普通：18-22 或 26-28（可接受范围）
    - 不良：16-18 或 28-30（不舒适范围）
    - 极不良：<16 或 >30（极不舒适范围）
    - 注：冬季舒适范围为 16-24℃，可根据季节调整
  
  - **湿度级距**（单位：%，参考 GB/T 18883-2022）：
    - 良好：40-60（最舒适范围）
    - 普通：30-40 或 60-70（可接受范围）
    - 不良：20-30 或 70-80（不舒适范围）
    - 极不良：<20 或 >80（极不舒适范围）
    - 注：夏季标准 40-80%，冬季标准 30-60%
  
  - **甲醛级距**（单位：mg/m³，参考 GB/T 18883-2022）：
    - 良好：0-0.03（一级标准，最安全）
    - 普通：0.03-0.05（二级标准，可接受）
    - 不良：0.05-0.08（三级标准，超标）
    - 极不良：>0.08（严重超标，国家标准限值）
    - 注：GB/T 18883-2022 标准限值为 ≤0.08 mg/m³
  
  - **VOC 级距**（单位：mg/m³，参考 GB/T 18883-2002）：
    - 良好：0-0.3（低于标准值 50%）
    - 普通：0.3-0.5（接近标准值）
    - 不良：0.5-0.6（接近限值）
    - 极不良：>0.6（超标，国家标准限值）
    - 注：GB/T 18883 标准限值为 ≤0.6 mg/m³
  
  - **CO2 级距**（单位：%，参考 GB/T 18883-2022）：
    - 良好：0-0.05（<500 ppm，优秀）
    - 普通：0.05-0.08（500-800 ppm，可接受）
    - 不良：0.08-0.10（800-1000 ppm，不舒适）
    - 极不良：>0.10（>1000 ppm，超标，国家标准限值）
    - 注：GB/T 18883-2022 标准限值为 ≤0.10%（1000 ppm）

  **级距标准定义**：
  - 每个参数已定义 4 个级距（良好、普通、不良、极不良）
  - 每个级距包含：
    - 数值范围（根据国家标准和舒适度标准）
    - 颜色（用于圆点指示器）
    - 状态文字（良好、普通、不良、极不良）
  - 建议使用 enum 或数据模型来管理级距标准
  - 级距标准基于：
    - GB/T 18883-2022《室内空气质量标准》
    - GB/T 18883-2002《室内空气质量标准》（VOC）
    - GB/T 50785-2012《民用建筑室内热湿环境评价标准》
  - 级距标准可以通过配置文件或 API 动态更新（可选）
  - **级距颜色映射**：
    - 良好：绿色（#40CE5F）→ `EnumColor.accentGreen`
    - 普通：黄色（#FFCF21）→ `EnumColor.accentYellow`
    - 不良：橙色（#F88125）→ 可能需要新增或使用相近颜色
    - 极不良：红色（#EF4425）→ `EnumColor.accentRed`

**RouterData 参数**（参考 circuit_breaker_main_page_model.dart）：

**AirBoxMainPageRouterData**（main 页面）：
- `language` - 语言代码（从 SmartHomeService 获取）
- `theme` - 主题名称（从 SmartHomeService 获取）
- `isModuleMode` - 是否为模块模式（通常为 false）
- `deviceName` - 设备名称
- `visibleDataTypes` - 显示的数据类型列表（`List<EnumAirBoxDataType>`）
- 数据参数：`pm25`, `temperature`, `humidity`, `formaldehyde`, `voc`, `co2`
- `pm25Status` - PM2.5 状态（良好/普通/不良/极不良）
- `onBackButtonTap` - 返回按钮 callback
- `onSettingButtonTap` - 设置按钮 callback
- `onEditButtonTap` - 编辑按钮 callback（返回新名称）
- `onDataRecordItemTap` - 数据记录按钮 callback（返回 record 页面 RouterData）
- 数据更新 callback（由外部主动更新数据）

**AirBoxRecordPageRouterData**（record 页面）：
- ❌ **不需要** `language`, `theme`, `isModuleMode`
- `onDataFilterChanged` - 数据筛选变更 callback（时间筛选和日期选择）
- `onSettingButtonTap` - 设置按钮 callback
- `onBackButtonTap` - 返回按钮 callback（可选）

**AirBoxReferencePageRouterData**（reference 页面）：
- ❌ **不需要** `language`, `theme`, `isModuleMode`
- `deviceName` - 设备名称（用于显示位置）
- `onBackButtonTap` - 返回按钮 callback
- `onSettingButtonTap` - 设置按钮 callback（可选）

**数据结构：**
- **数据类型枚举**（`EnumAirBoxDataType`）：
  - `pm25` - PM 2.5（单纯数字，无单位）
  - `temperature` - 温度（摄氏度 °C）
  - `humidity` - 湿度（百分比 %，公定单位）
  - `formaldehyde` - 甲醛（数值类型）
  - `voc` - VOC（数值类型）
  - `co2` - CO2（数值类型）
- **数据显示控制**：
  - 由外部通过 `RouterData` 参数决定显示哪些数据类型
  - 使用 enum 包起来，支持灵活配置
- **PM 2.5 状态**：
  - 状态：良好/其他状态（后续在参考值页面定义判断标准）
  - 状态指示器：绿色圆点（#40CE5F）
- **数据更新方式**：
  - 在 `PageRouterData` 中建立 callback function
  - 由外部主动更新数据进来
  - 参考 `circuit_breaker_main_page_model.dart` 的实现方式

**UI 设计：**
- **Figma 设计稿**：
  - [日间设计稿](https://www.figma.com/design/IBa2ukUFweWBLGJLezUOSG/enGo_GUI?node-id=8311-33397&t=rKkfoweDuy18tqek-1)
  - [夜间设计稿](https://www.figma.com/design/IBa2ukUFweWBLGJLezUOSG/enGo_GUI?node-id=10762-39209&m=dev)
- **设计页面标题**：`1-2-1-1-17.空氣品質偵測器`（空气品质侦测器）
- **设计尺寸**：1641px × 1170px（FirstBackgroundCard 内部）
- **开发范围**：只需要开发 split view 右边的 content view
- **参考组件**：`FirstBackgroundCard`（位于 `lib/wh/feature/warehouse/ui/first_background_card.dart`）
- **参考实现**：可参考 `lib/wh/feature/gateway/page/main/gateway_main_page.dart` 的使用方式
- **UI 结构**：
  - 使用 `FirstBackgroundCard` 作为页面容器
  - 内部使用 `Stack` + `Positioned` 布局（根据 Figma 导出代码）
  - 主要布局：TopBar + 中心 PM2.5 显示 + 底部数据卡片 + 数据紀錄/智能連動区域
- **颜色规范**（从 Figma 代码提取）：

  **日间模式（Light Mode）：**
  - 背景色：`#F6F6F6`（function-surface-surface-secondary-bg-2）
  - 主要文字：`#292929`（function-typography-text-primary）
  - 次要文字：`#7C7C7C`（function-typography-text-secondary）
  - 蓝色主题：`#96B7E3`（base-color-blue-#blue-300）
  - 绿色指示器：`#40CE5F`
  - 橙色边框：`#FB9B51`（function-button-button-border-reverse）
  - 次要文字边框：`#7C7C7C`（function-typography-text-secondary）

  **夜间模式（Dark Mode）：**
  - 背景色：`#2F333F`（function-surface-surface-secondary-bg-2）
  - 主要文字：`Colors.white`（function-typography-text-primary）
  - 次要文字：`#DCDCDC`（function-typography-text-secondary）
  - 蓝色主题：`#96B7E3`（base-color-blue-#blue-300，与日间相同）
  - 绿色指示器：`#40CE5F`（与日间相同）
  - 橙色边框：`#FDB874`（function-button-button-border-reverse）
  - 次要文字边框：`#DCDCDC`（function-typography-text-secondary）
  - 装饰性圆形颜色：
    - color-block-05：`#2F333F`
    - color-block-04：`#66BA7E4C`（带透明度）
    - color-block-01：`#A35927`

**开发步骤：**
1. 使用 `dart script/mvcir_create.dart air_box main` 创建 main 页面
2. 使用 `dart script/mvcir_create.dart air_box record` 创建 record 页面
3. 使用 `dart script/mvcir_create.dart air_box reference` 创建 reference 页面
3. 参考 `FirstBackgroundCard` 和 `gateway_main_page` 实现 UI 结构
4. 实现数据类型枚举（`EnumAirBoxDataType`：PM2.5、温度、湿度、甲醛、VOC、CO2）
5. 实现数据模型（包含所有数据类型，由外部参数决定显示哪些）
6. 实现 RouterData callback 机制（参考 circuit_breaker_main_page_model.dart）
   - `onBackButtonTap` - 返回按钮
   - `onEditButtonTap` - 编辑按钮（返回新名称）
   - `onSettingButtonTap` - 设置按钮
   - `onDataRecordItemTap` - 数据记录按钮（返回 record 页面 RouterData）
   - 数据更新 callback（由外部主动更新数据）
6. 实现主题切换支持（日间/夜间模式）
7. 实现 TopBar（返回按钮、标题、编辑按钮、设置按钮，支持主题切换）
8. 实现中心 PM 2.5 显示区域（大数字、状态文字、指示器）
9. 实现底部数据卡片（温度、湿度、甲醛、VOC、CO2 横向排列，支持主题切换）
10. 实现数据紀錄区域（标题 + 按钮，支持主题切换）
11. 实现智能連動区域（标题 + 按钮，支持主题切换）
12. 实现 record 页面 UI 结构（参考 circuit_breaker_data_record_page）
13. 实现 TopBar（返回按钮、标题、设置按钮）
14. 实现 TimeFilter（年月日 TabBar）
15. 实现 StatisticsSection（左侧：温度/湿度/PM2.5 TabBar，右侧：日期选择器）
16. 实现 ChartSection（使用 LineChart 曲线图）
    - 所有数据类型使用同一颜色（因为单位不同不能同时显示）
    - 数据点使用圆点显示
    - 不显示最大值/最小值标记
    - 根据选择的数据类型和时间范围显示图表
17. 实现数据记录和历史查询功能（API 接口、数据模型）
18. 实现 reference 页面 UI 结构（参考空气清净机的参考值页面）
19. 实现参数选择功能（使用 `CustTextDropdownButton` 下拉菜单，切换不同参数）
20. 实现级距参考表显示（PM2.5、温度、湿度、甲醛、VOC、CO2）
21. 实现级距标准数据模型（包含数值范围、颜色、状态文字）
22. 实现级距参考表组件（可复用的级距列表组件）

## 功能规划

### 待开发功能

- [ ] **air_box** - 空气盒功能
  - 功能描述：侦测空气的 PM 2.5、温度、湿度、甲醛、VOC、CO2
  - Feature 名称：`air_box`
  - 页面规划：
    - `main` - 主页面（显示当前空气数据，PM 2.5 大数字展示）
    - `record` - 记录页面（查看历史数据）

### 进行中功能

- [ ] 功能 A
- [ ] 功能 B

### 已完成功能

- [x] 功能 X
- [x] 功能 Y

## 开发计划

### 短期目标（1-2 周）

- [ ] **air_box Feature 开发**
  - [ ] 创建 air_box feature 目录结构
  - [ ] 创建 main 页面（MVCIR 结构）
  - [ ] 创建 record 页面（MVCIR 结构）
  - [ ] 创建 reference 页面（MVCIR 结构）
  - [ ] 实现数据类型枚举（`EnumAirBoxDataType`）
  - [ ] 实现数据模型（由外部参数决定显示哪些数据类型）
  - [ ] 实现 RouterData callback 机制（参考 circuit_breaker）
  - [ ] 实现 UI 结构（使用 FirstBackgroundCard，参考 gateway_main_page）
  - [ ] 实现主题切换支持（日间/夜间模式，根据系统主题或用户设置）
  - [ ] 实现 TopBar（返回按钮、标题、编辑按钮、设置按钮，支持主题切换）
  - [ ] 实现中心 PM 2.5 显示区域（大数字 180pt、状态文字、绿色指示器）
  - [ ] 实现底部数据卡片（温度、湿度、甲醛、VOC、CO2 横向排列，带分隔线，支持主题切换）
  - [ ] 实现数据紀錄区域（标题 + 按钮，点击跳转到 record 页面，支持主题切换）
  - [ ] 移除智能連動区域（不需要此功能）
  - [ ] 根据 Figma 设计稿实现 main 页面 UI（日间模式，只开发 split view 右边的 content view）
  - [ ] 根据 Figma 设计稿实现 main 页面 UI（夜间模式，只开发 split view 右边的 content view）
  - [ ] 实现 record 页面 UI 结构（参考 circuit_breaker_data_record_page，使用 FirstBackgroundCard）
  - [ ] 实现 TopBar（返回按钮、标题、设置按钮）
  - [ ] 实现 TimeFilter（年月日 TabBar，样式参考 circuit_breaker）
  - [ ] 实现 StatisticsSection（左侧：温度/湿度/PM2.5 TabBar，右侧：日期选择器）
  - [ ] 实现 ChartSection（使用 fl_chart 的 LineChart 曲线图）
    - 所有数据类型使用同一颜色
    - 数据点使用圆点显示
    - 不显示最大值/最小值标记
  - [ ] 实现数据记录 API 接口（获取历史数据）
  - [ ] 实现数据模型（温度、湿度、PM2.5 历史数据）

### 中期目标（1-2 个月）

- 目标 A
- 目标 B

### 长期目标（3+ 个月）

- 目标 X
- 目标 Y

## 技术债务

- [ ] 技术债务 1
- [ ] 技术债务 2

## 待办事项

### 高优先级

- [ ] 使用 `mvcir_create.dart` 脚本创建 air_box/main 页面
- [ ] 使用 `mvcir_create.dart` 脚本创建 air_box/record 页面
- [ ] 使用 `mvcir_create.dart` 脚本创建 air_box/reference 页面

### 中优先级

- [ ] 任务 A
- [ ] 任务 B

### 低优先级

- [ ] 任务 X
- [ ] 任务 Y

## 资源准备清单

### air_box Feature 需要的多语系资源

**需要新增的多语系 Key（在 `zh_tw.dart` 等文件中添加）：**

1. **页面标题和主要文字**：
   - `airBoxTitle`
     - 繁体中文（zh_tw.dart）：'空氣盒'
     - 简体中文（zh_cn.dart）：'空气盒'
     - 英文（en_us.dart）：'Air Box'
     - 日文（ja_jp.dart）：'エアボックス'
     - 韩文（ko_kr.dart）：'에어박스'
   
   - `airBoxPm25`
     - 所有语言：'PM2.5'（统一）
   
   - `airBoxStatusGood`
     - 繁体中文：'良好'
     - 简体中文：'良好'
     - 英文：'Good'
     - 日文：'良好'
     - 韩文：'양호'
   
   - `airBoxStatusModerate`（可选，用于其他状态）
     - 繁体中文：'普通'
     - 简体中文：'普通'
     - 英文：'Moderate'
     - 日文：'普通'
     - 韩文：'보통'
   
   - `airBoxStatusBad`（可选，用于其他状态）
     - 繁体中文：'不良'
     - 简体中文：'不良'
     - 英文：'Bad'
     - 日文：'不良'
     - 韩文：'나쁨'

2. **数据标签**：
   - `airBoxCurrentTemperature`
     - 繁体中文：'當前溫度'
     - 简体中文：'当前温度'
     - 英文：'Current Temperature'
     - 日文：'現在の温度'
     - 韩文：'현재 온도'
   
   - `airBoxCurrentHumidity`
     - 繁体中文：'當前濕度'
     - 简体中文：'当前湿度'
     - 英文：'Current Humidity'
     - 日文：'現在の湿度'
     - 韩文：'현재 습도'
   
   - `airBoxFormaldehydeValue`
     - 繁体中文：'甲醛測試值'
     - 简体中文：'甲醛测试值'
     - 英文：'Formaldehyde Value'
     - 日文：'ホルムアルデヒド測定値'
     - 韩文：'포름알데히드 측정값'
   
   - `airBoxVocValue`
     - 繁体中文：'VOC偵測值'
     - 简体中文：'VOC 检测值'
     - 英文：'VOC Value'
     - 日文：'VOC検出値'
     - 韩文：'VOC 측정값'
   
   - `airBoxCo2Value`
     - 繁体中文：'CO2偵測值'
     - 简体中文：'CO2 检测值'
     - 英文：'CO2 Value'
     - 日文：'CO2検出値'
     - 韩文：'CO2 측정값'

3. **功能区域**：
   - `airBoxDataRecord`
     - 繁体中文：'數據紀錄'
     - 简体中文：'数据记录'
     - 英文：'Data Record'
     - 日文：'データ記録'
     - 韩文：'데이터 기록'
   
   - `airBoxSmartLinkage`
     - 繁体中文：'智能連動'
     - 简体中文：'智能联动'
     - 英文：'Smart Linkage'
     - 日文：'スマート連動'
     - 韩文：'스마트 연동'

4. **record 页面 TabBar**（用于数据类型切换）：
   - `airBoxRecordTabTemperature`
     - 繁体中文：'溫度'
     - 简体中文：'温度'
     - 英文：'Temperature'
     - 日文：'温度'
     - 韩文：'온도'
   
   - `airBoxRecordTabHumidity`
     - 繁体中文：'濕度'
     - 简体中文：'湿度'
     - 英文：'Humidity'
     - 日文：'湿度'
     - 韩文：'습도'
   
   - `airBoxRecordTabPm25`
     - 所有语言：'PM2.5'（统一）

5. **reference 页面**（级距参考表）：
   - `airBoxReferenceTitle`
     - 繁体中文：'級距參考'
     - 简体中文：'级距参考'
     - 英文：'Reference Standards'
     - 日文：'基準値'
     - 韩文：'기준값'
   
   - `airBoxReferencePm25Title`
     - 繁体中文：'微粒物質(PM2.5)'
     - 简体中文：'微粒物质(PM2.5)'
     - 英文：'Particulate Matter (PM2.5)'
     - 日文：'粒子状物質(PM2.5)'
     - 韩文：'미세먼지(PM2.5)'
   
   - `airBoxReferencePm25Description`
     - 繁体中文：'小於2.5微米的微粒，這包含煙霧、工業排放廢氣和燃燒的蠟燭。'
     - 简体中文：'小于2.5微米的微粒，这包含烟雾、工业排放废气和燃烧的蜡烛。'
     - 英文：'Particles smaller than 2.5 micrometers, including smoke, industrial emissions, and burning candles.'
     - 日文：'2.5マイクロメートル未満の粒子。煙、工業排出ガス、燃えるろうそくなどが含まれます。'
     - 韩文：'2.5마이크로미터 미만의 미세입자. 연기, 산업 배출 가스, 타는 양초 등이 포함됩니다.'
   
   - `airBoxReferenceTemperatureTitle`
     - 繁体中文：'溫度'
     - 简体中文：'温度'
     - 英文：'Temperature'
     - 日文：'温度'
     - 韩文：'온도'
   
   - `airBoxReferenceTemperatureDescription`
     - 繁体中文：'適宜的室內溫度有助於維持人體舒適度和健康。'
     - 简体中文：'适宜的室内温度有助于维持人体舒适度和健康。'
     - 英文：'Appropriate indoor temperature helps maintain human comfort and health.'
     - 日文：'適切な室内温度は、人体の快適さと健康を維持するのに役立ちます。'
     - 韩文：'적절한 실내 온도는 인체의 쾌적함과 건강을 유지하는 데 도움이 됩니다.'
   
   - `airBoxReferenceHumidityTitle`
     - 繁体中文：'濕度'
     - 简体中文：'湿度'
     - 英文：'Humidity'
     - 日文：'湿度'
     - 韩文：'습도'
   
   - `airBoxReferenceHumidityDescription`
     - 繁体中文：'適宜的室內濕度可以防止呼吸道疾病和皮膚問題。'
     - 简体中文：'适宜的室内湿度可以防止呼吸道疾病和皮肤问题。'
     - 英文：'Appropriate indoor humidity can prevent respiratory diseases and skin problems.'
     - 日文：'適切な室内湿度は、呼吸器疾患や皮膚の問題を防ぐことができます。'
     - 韩文：'적절한 실내 습도는 호흡기 질환과 피부 문제를 예방할 수 있습니다.'
   
   - `airBoxReferenceFormaldehydeTitle`
     - 繁体中文：'甲醛'
     - 简体中文：'甲醛'
     - 英文：'Formaldehyde'
     - 日文：'ホルムアルデヒド'
     - 韩文：'포름알데히드'
   
   - `airBoxReferenceFormaldehydeDescription`
     - 繁体中文：'甲醛是一種常見的室內空氣污染物，主要來自裝修材料和家具。'
     - 简体中文：'甲醛是一种常见的室内空气污染物，主要来自装修材料和家具。'
     - 英文：'Formaldehyde is a common indoor air pollutant, mainly from decoration materials and furniture.'
     - 日文：'ホルムアルデヒドは、主に装飾材料や家具から発生する一般的な室内空気汚染物質です。'
     - 韩文：'포름알데히드는 주로 인테리어 재료와 가구에서 발생하는 일반적인 실내 공기 오염물질입니다.'
   
   - `airBoxReferenceVocTitle`
     - 繁体中文：'揮發性有機化合物(VOC)'
     - 简体中文：'挥发性有机化合物(VOC)'
     - 英文：'Volatile Organic Compounds (VOC)'
     - 日文：'揮発性有機化合物(VOC)'
     - 韩文：'휘발성 유기 화합물(VOC)'
   
   - `airBoxReferenceVocDescription`
     - 繁体中文：'VOC 包括多種化學物質，可能對健康造成影響。'
     - 简体中文：'VOC 包括多种化学物质，可能对健康造成影响。'
     - 英文：'VOC includes various chemical substances that may affect health.'
     - 日文：'VOCには、健康に影響を与える可能性のあるさまざまな化学物質が含まれています。'
     - 韩文：'VOC에는 건강에 영향을 줄 수 있는 다양한 화학 물질이 포함되어 있습니다.'
   - `airBoxReferenceCo2Title`
     - 繁体中文：'二氧化碳(CO2)'
     - 简体中文：'二氧化碳(CO2)'
     - 英文：'Carbon Dioxide (CO2)'
     - 日文：'二酸化炭素(CO2)'
     - 韩文：'이산화탄소(CO2)'
   
   - `airBoxReferenceCo2Description`
     - 繁体中文：'室內二氧化碳濃度過高會導致頭痛、嗜睡、注意力不集中等症狀。'
     - 简体中文：'室内二氧化碳浓度过高会导致头痛、嗜睡、注意力不集中等症状。'
     - 英文：'High indoor CO2 concentration can cause headaches, drowsiness, and difficulty concentrating.'
     - 日文：'室内の二酸化炭素濃度が高いと、頭痛、眠気、集中力の低下などの症状が現れます。'
     - 韩文：'실내 이산화탄소 농도가 높으면 두통, 졸음, 집중력 저하 등의 증상이 나타납니다.'
   
   - `airBoxReferenceUnitFormaldehyde`
     - 所有语言：'mg/m³'（统一）
   
   - `airBoxReferenceUnitVoc`
     - 所有语言：'mg/m³'（统一）
   
   - `airBoxReferenceUnitCo2`
     - 所有语言：'%'（统一，或使用 ppm）
   
   - `airBoxReferenceUnitPm25`
     - 所有语言：'µg/m³'（统一）
   
   - `airBoxReferenceUnitTemperature`
     - 所有语言：'°C'（统一）
   
   - `airBoxReferenceUnitHumidity`
     - 所有语言：'%'（统一）
   
   - `airBoxReferenceStatusGood`
     - 繁体中文：'良好'
     - 简体中文：'良好'
     - 英文：'Good'
     - 日文：'良好'
     - 韩文：'양호'
   
   - `airBoxReferenceStatusModerate`
     - 繁体中文：'普通'
     - 简体中文：'普通'
     - 英文：'Moderate'
     - 日文：'普通'
     - 韩文：'보통'
   
   - `airBoxReferenceStatusBad`
     - 繁体中文：'不良'
     - 简体中文：'不良'
     - 英文：'Bad'
     - 日文：'不良'
     - 韩文：'나쁨'
   
   - `airBoxReferenceStatusVeryBad`
     - 繁体中文：'極不良'
     - 简体中文：'极不良'
     - 英文：'Very Bad'
     - 日文：'極不良'
     - 韩文：'매우 나쁨'

**比对结果**：

✅ **颜色资源（已存在，可直接使用）**：
- 所有 Figma 设计中的颜色都已存在于 `color_data.dart` 中
- 可以通过 `EnumColor` enum 直接使用，无需新增

❌ **多语系资源（需要新增）**：
- 所有文字都需要新增多语系 Key
- 需要在 5 个语言文件中添加：`zh_tw.dart`, `zh_cn.dart`, `en_us.dart`, `ja_jp.dart`, `ko_kr.dart`
- **main 页面**：需要新增 **10 个多语系 Key**（包含 3 个可选的状态 Key）
- **record 页面**：需要新增 **3 个多语系 Key**（温度、湿度、PM2.5，用于 TabBar）
- **reference 页面**：需要新增多个多语系 Key（参数名称、描述、单位、状态文字等）
- **总计**：需要新增 **13+ 个多语系 Key**（10 个 main + 3 个 record + reference 页面相关）
- **接口集成**：需要新增 **1 个多语系 Key**（`smartHomeTabAirBox`，用于 app_main_page 的 TabItem）

**颜色映射（已存在，可直接使用）**：
- `#292929` → `EnumColor.textPrimary`（日间主要文字）
- `Colors.white` → `EnumColor.textWhite`（夜间主要文字）
- `#96B7E3` → `EnumColor.accentBlue`（PM2.5 数字、温度值，使用 dark 模式）
- `#40CE5F` → `EnumColor.accentGreen`（状态指示器）
- `#FB9B51` → `EnumColor.engoButtonBorderReverse`（日间边框，使用 light 模式）
- `#FDB874` → `EnumColor.engoButtonBorderReverse`（夜间边框，使用 dark 模式）
- `#7C7C7C` → `EnumColor.textSecondary`（日间次要文字，使用 light 模式）
- `#DCDCDC` → `EnumColor.textSecondary`（夜间次要文字，使用 dark 模式）
- `#F6F6F6` → `EnumColor.backgroundSecondary`（日间背景，使用 light 模式）
- `#2F333F` → `EnumColor.backgroundSecondary`（夜间背景，使用 dark 模式）

**需要执行的步骤**：

1. **添加多语系 Key**：
   ```bash
   # 在 zh_tw.dart, zh_cn.dart, en_us.dart, ja_jp.dart, ko_kr.dart 中添加上述 Key
   ```

2. **运行多语系更新脚本**：
   ```bash
   dart script/locale_update.dart
   ```

3. **验证**：
   - 确认 `EnumLocale` enum 中已包含所有新增的 Key
   - 确认所有语言文件都已更新

**代码使用示例**：

```dart
// 多语系使用
Text(EnumLocale.airBoxTitle.tr)  // 显示"空氣盒"（根据当前语言）
Text(EnumLocale.airBoxCurrentTemperature.tr)  // 显示"當前溫度"
Text(EnumLocale.airBoxDataRecord.tr)  // 显示"數據紀錄"

// 颜色使用
EnumColor.textPrimary.color  // 主要文字颜色（自动根据主题切换）
EnumColor.accentBlue.color  // PM2.5 数字颜色（使用 dark 模式的值 #96B7E3）
EnumColor.accentGreen.color  // 绿色指示器（#40CE5F）
EnumColor.engoButtonBorderReverse.color  // 边框颜色（自动根据主题切换）
EnumColor.backgroundSecondary.color  // 背景颜色（自动根据主题切换）
```

## 接口集成规划

### feature/app 接口

**需要修改的文件：**
- `lib/feature/app/page/main/app_main_page_model.dart`
  - 在 `EnumAppMainRouter` 中添加 `airBox`
  - 在 `EnumAppMainTabItem` 中添加 `airBox`（需要图标和标题）
  - 在 `page` getter 中添加对应的页面
- `lib/feature/app/page/main/app_main_page.dart`
  - 导入 `SmartHomeAirBoxPage`

**需要新增的多语系 Key：**
- `smartHomeTabAirBox`
  - 繁体中文：'空氣盒'
  - 简体中文：'空气盒'
  - 英文：'Air Box'
  - 日文：'エアボックス'
  - 韩文：'에어박스'

**需要添加的内容：**
```dart
// app_main_page_model.dart
enum EnumAppMainRouter {
  household,
  gateway,
  warehouse,
  circuitBreaker,
  waterValue,
  airBox,  // 新增
  setting;
  
  Widget Function() get page => () => switch (this) {
    // ... 其他页面
    airBox => const SmartHomeAirBoxPage(),  // 新增
  };
}

enum EnumAppMainTabItem {
  // ... 其他项目
  airBox(Icons.air),  // 新增，需要合适的图标
  
  EnumLocale get titleLocale => switch (this) {
    // ... 其他项目
    airBox => EnumLocale.smartHomeTabAirBox,  // 新增
  };
}
```

### feature/smart_home 接口

**需要创建的文件：**
- `lib/feature/smart_home/page/air_box/smart_home_air_box_page.dart`
- `lib/feature/smart_home/page/air_box/smart_home_air_box_page_controller.dart`
- `lib/feature/smart_home/page/air_box/smart_home_air_box_page_model.dart`
- `lib/feature/smart_home/page/air_box/smart_home_air_box_page_route.dart`
- `lib/feature/smart_home/page/air_box/smart_home_air_box_page_interactive.dart`

**接口页面结构**（参考 `smart_home_circuit_breaker_page`）：
- **smart_home_air_box_page.dart**：
  - 继承 `GetView<SmartHomeAirBoxPageController>`
  - 使用 `GetBuilder` 包装
  - 调用 `AirBoxMainPage(routerData: controller.getAirBoxMainPageRouterData)`

- **smart_home_air_box_page_controller.dart**：
  - 实现 `getAirBoxMainPageRouterData` getter
  - 构建 `AirBoxMainPageRouterData`，包含所有 callback
  - 实现 `getAirBoxRecordPageRouterData` getter（用于 record 页面）
  - 实现 `getAirBoxReferencePageRouterData` getter（用于 reference 页面）
  - 实现数据更新逻辑（模拟或真实 API 调用）

- **smart_home_air_box_page_model.dart**：
  - 包含 `BuildContext? context`
  - 可选的 `SnackBarData` 类（用于显示提示）

- **smart_home_air_box_page_route.dart**：
  - 定义路由枚举（如 `showSnackBar`）
  - 实现路由处理逻辑

- **smart_home_air_box_page_interactive.dart**：
  - 定义交互枚举
  - 实现交互处理逻辑

**RouterData 构建示例**（参考 circuit_breaker）：

**main 页面 RouterData**：
```dart
AirBoxMainPageRouterData get getAirBoxMainPageRouterData {
  return AirBoxMainPageRouterData(
    language: _service.getCurrentLocaleCode,  // ✅ 需要
    theme: _service.getCurrentThemeName,      // ✅ 需要
    isModuleMode: false,                      // ✅ 需要
    deviceName: '空氣盒',
    visibleDataTypes: [EnumAirBoxDataType.pm25, EnumAirBoxDataType.temperature, EnumAirBoxDataType.humidity],
    pm25: '5',
    pm25Status: '良好',
    temperature: '26.6',
    humidity: '60',
    formaldehyde: '0.02',
    voc: '0.3',
    co2: '0.05',
    onBackButtonTap: () {
      routerHandle(EnumSmartHomeAirBoxPageRoute.showSnackBar, data: '點擊返回');
    },
    onEditButtonTap: (String oldName) async {
      routerHandle(EnumSmartHomeAirBoxPageRoute.showSnackBar, data: '編輯空氣盒名稱');
      return Future.value('新空氣盒名稱');
    },
    onSettingButtonTap: () {
      routerHandle(EnumSmartHomeAirBoxPageRoute.showSnackBar, data: '點擊設定');
    },
    onDataRecordItemTap: () async {
      return Future.value(getAirBoxRecordPageRouterData);
    },
    // 数据更新 callback
    onDataUpdate: (AirBoxDataModel data) {
      // 更新数据
    },
  );
}
```

**record 页面 RouterData**：
```dart
AirBoxRecordPageRouterData get getAirBoxRecordPageRouterData {
  return AirBoxRecordPageRouterData(
    // ❌ 不需要 language, theme, isModuleMode
    onDataFilterChanged: (EnumTimeFilter timeFilter, DateTime selectedDate) async {
      return switch (timeFilter) {
        EnumTimeFilter.day => (chartData: _getDayChartData),
        EnumTimeFilter.month => (chartData: _getMonthChartData),
        EnumTimeFilter.year => (chartData: _getYearChartData),
      };
    },
    onSettingButtonTap: () {
      routerHandle(EnumSmartHomeAirBoxPageRoute.showSnackBar, data: '點擊數據記錄設定');
    },
    onBackButtonTap: () {
      // 返回上一页
    },
  );
}
```

**reference 页面 RouterData**：
```dart
AirBoxReferencePageRouterData get getAirBoxReferencePageRouterData {
  return AirBoxReferencePageRouterData(
    // ❌ 不需要 language, theme, isModuleMode
    deviceName: '中山區-臥室1',  // 设备位置名称
    onBackButtonTap: () {
      // 返回上一页
    },
    onSettingButtonTap: () {
      // 设置按钮（可选）
    },
  );
}
```

**开发步骤：**
1. 在 `app_main_page_model.dart` 中添加 airBox 路由和 TabItem
2. 在 `app_main_page.dart` 中导入 SmartHomeAirBoxPage
3. 创建 `feature/smart_home/page/air_box/` 目录
4. 创建所有接口页面文件（参考 circuit_breaker 的结构）
5. 实现 RouterData 构建逻辑
   - main 页面 RouterData（包含 language, theme, isModuleMode）
   - record 页面 RouterData（不包含 language, theme, isModuleMode）
   - reference 页面 RouterData（不包含 language, theme, isModuleMode）
6. 实现数据更新 callback
7. 添加多语系 Key `smartHomeTabAirBox`
8. 运行 `dart script/locale_update.dart` 更新多语系

## 备注

- 备注 1
- 备注 2
