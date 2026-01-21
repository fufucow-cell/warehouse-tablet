# 项目开发计划 (Project Plan)

## 📋 项目概述

这是一个 Flutter 平板应用，用于智能家居和仓库管理系统。项目采用模块化架构，使用 GetX 进行状态管理。

### 主要功能模块

1. **Smart Home 主应用**
   - Household（家庭）
   - Gateway（网关）
   - Warehouse（仓库）- 子模块
   - Setting（设置）

2. **Warehouse 仓库管理模块**
   - Item（物品管理）
   - Cabinet（橱柜管理）
   - Category（分类管理）
   - Record（记录）
   - Alarm（警报）

## ✅ 已完成功能

### 基础设施
- [O] GetX 状态管理集成
- [O] 模块化路由系统
- [O] 环境变量管理（DEV, STG, UAT, PRD）
- [O] API 服务层（Dio 配置、拦截器、缓存）
- [O] 多语言支持（中文、英文等）
- [O] 主题切换（明暗主题）
- [O] 设备检测服务（平板/手机识别）
- [O] 存储服务
- [O] 日志服务

### UI/UX
- [O] 横屏模式支持（Android 强制横屏）
- [O] 响应式布局（基于屏幕尺寸的缩放）
- [O] 自定义 GridView 组件
- [O] Shimmer 加载动画
- [O] 空状态组件
- [O] 自定义 SnackBar
- [O] FirstBackgroundCard 统一页面背景样式
- [O] 页面布局规范（第一层使用 FirstBackgroundCard 包裹）

### Warehouse 模块
- [O] 物品列表展示
- [O] 物品创建/编辑功能
- [O] 橱柜管理
- [O] 分类管理
- [O] 图片上传（相机/相册）
- [O] 图片压缩和 Base64 转换

### 构建与部署
- [O] Android APK 构建配置
- [O] Debug 和 Release 构建支持
- [O] 环境变量构建参数
- [O] VS Code 任务配置

## 🔄 进行中的任务

### 功能开发

#### Circuit Breaker 熔断器模块（参考 gateway 模块模式，遵循 STRUCTURE.md 规范）

**基础设施**
- [O] 创建 circuit_breaker_service.dart
- [O] 创建 circuit_breaker_service_model.dart
- [O] 所有页面共享 CircuitBreakerService（在 Controller 构造函数中注册，参考 gateway 模式）
- [O] 添加 fl_chart 依赖到 pubspec.yaml
- [O] **重要**：此项目不使用 API，所有数据通过 RouterData 传入（供其他 RD 串接）

**RouterData 设计**
- [O] 创建 RouterData 类（包含所有 callback 函数，参考 GatewayMainPageRouterData）
  - [O] 主页面 RouterData（见下方页面 1）
  - [O] 数据记录页面 RouterData（见下方页面 2）
  - [O] 通知记录页面 RouterData（见下方页面 3）
  - [O] 警示設定页面 RouterData（见下方页面 4）

---

#### 📄 页面 1：主页面（Circuit Breaker Main）

**设计分析**（已完成 Figma 代码解析）
- [O] 顶部栏：标题"斷電器"、编辑按钮、设置按钮
- [O] 中间区域：开关控制（滑动开关 + "開關"文字）
- [O] 底部区域：统计信息卡片（當前溫度、累積用電量、今日用電量、功率、電壓、電流）
- [O] 数据记录区域：可滚动列表，包含3项（數據記錄、通知紀錄、警示設定），每项有标题和右侧操作图标

**RouterData**
- [O] 必需参数：断电器名称（circuitBreakerName: String）
- [O] 必需参数：开关初始状态（initialSwitchState: bool）
- [O] 必需参数：统计数据（全部 String 类型）：
  - currentTemperature: String?（当前温度，如 "34°C" 或 null）
  - cumulativePowerConsumption: String?（累积用电量）
  - todayPowerConsumption: String?（今日用电量）
  - power: String?（功率）
  - voltage: String?（电压）
  - current: String?（电流）
- [O] 可选参数：language, theme, isModuleMode（参考 gateway）
- [O] Callback：onSwitchToggle, onBackButtonTap, onEditButtonTap, onSettingButtonTap
- [O] 列表项点击通过 Route Handler 处理，不需要 callback
- [O] 所有页面文本使用多语系（hard code），不需要从外部传入

**MVCIR 结构实现**
- [x] 创建页面 MVCIR 结构
- [O] 使用 FirstBackgroundCard 包裹（参考 gateway_main_page）
- [O] 实现页面布局组件：
  - [O] _TopBar（顶部栏：返回按钮、标题、编辑按钮、设置按钮）
    - [O] 左侧返回按钮：`EnumImage.cArrowLeft`，大小 80.0.scale，颜色 `EnumColor.engoIconBackButton.color`
    - [O] 中间标题："斷電器"（40px 粗体）+ 编辑按钮：`EnumImage.cPencilLine`，大小 50.0.scale，颜色 `EnumColor.engoTextPrimary.color`
    - [O] 右侧设置按钮：`EnumImage.cSetting`，大小 62.0.scale，颜色 `EnumColor.engoTextPrimary.color`
    - [O] 使用 `CustIconButton` 组件（参考 gateway_main_page.dart）
  - [O] _SwitchControl（中间开关控制区域）
    - [O] 垂直滑动开关（Stack 容器 166x473）
    - [O] 开关滑块（133x216）：
      - [O] 关闭状态：位置 top: 239，颜色灰色（0xFFDCDCDC）
      - [O] 开启状态：位置 top: 18，颜色橙色（0xFFFB9B51）
      - [O] 使用图片资源：`warehouse/parent/assets/images/common/circuit.png`（开关图案）
    - [O] 状态管理（参考 gateway 模式）：
      - [O] 在 Model 中创建 `final isSwitchOn = false.obs;`
      - [O] 初始化时从 RouterData 读取：`_model.isSwitchOn.value = routerData.initialSwitchState;`
      - [O] 在 RouterData 中定义 callback：`Future<void> Function(bool newValue)? onSwitchToggle;`
      - [O] 在 Interactive 中处理点击：先更新本地状态 `_model.isSwitchOn.value = !_model.isSwitchOn.value;`，然后调用 callback 传递新值
      - [O] 在 View 中使用 `Obx` 监听 `isSwitchOn` 变化，根据状态更新滑块位置和颜色
    - [O] 开关标签文字"開關"（32px）
  - [O] _StatisticsCard（底部统计信息卡片，6个统计项）
    - [O] 每个统计项都是 Column 结构（标题 + 值）
    - [O] 统计数据来源：由 RouterData 传入，不需要 API 调用
    - [O] 无数据时显示占位符 "-"
    - [O] 第一个项（當前溫度）显示标题 + 值（34°C，蓝色），其他项相同结构
    - [O] 每个 Column 之间有旋转90度的分隔线（垂直分隔线）
    - [O] 所有标题使用多语系（hard code）
  - [O] _DataRecordSection（数据记录区域 - 可滚动列表）
    - [O] 列表项（3项）：
      1. 數據記錄（标题 + 右侧图标 58x58）→ 跳转到页面 2
      2. 通知紀錄（标题 + 右侧图标 58x58）→ 跳转到页面 3
      3. 警示設定（标题 + 右侧图标 58x58）→ 跳转到页面 4
    - [O] 使用 ListView 或 SingleChildScrollView 实现滚动
    - [O] 每个列表项点击通过 Route Handler 处理跳转（参考 gateway 模式）
    - [O] 所有标题使用多语系（hard code）
- [x] 实现响应式布局和样式

---

#### 📄 页面 2：數據記錄（Data Record）

**设计分析**（已完成 Figma 代码解析）
- [O] 顶部栏：返回按钮（80x80）、标题"數據紀錄"（40px 粗体）、设置按钮（62x62）
- [O] 时间筛选器：日/月/年三个选项（类似 Tab 切换）
- [O] 统计信息区域：左侧总计用电量显示（由 RouterData 传入），右侧日期选择器
- [O] 图表显示区域：显示用电量趋势图表（数据由 RouterData 传入，ChartDataModel 结构）
- [O] 不显示数据列表，只显示图表和统计信息

**RouterData**
- [O] 必需参数：总计用电量（totalPowerConsumption: String）
- [O] 必需参数：图表数据（initialChartData: List<ChartDataModel>）
- [O] ChartDataModel 结构：`{ date: DateTime, number: double }`
- [O] Callback：`Future<({List<ChartDataModel> chartData, String totalPowerConsumption})> Function(String timeFilter, DateTime selectedDate)? onDataFilterChanged;`
  - [O] 参数：当前时间筛选器值（"日"/"月"/"年"）和选择的日期
  - [O] 返回：包含图表数据列表和总电量信息的 Record 类型或 Class
- [O] Callback：`VoidCallback? onSettingButtonTap;`
- [O] 不需要 language, theme, isModuleMode（通过 service 共享）

**MVCIR 结构实现**
- [x] 创建页面 MVCIR 结构
- [O] 使用 FirstBackgroundCard 包裹
- [O] _TopBar（顶部栏：返回按钮、标题"數據紀錄"、设置按钮）
  - [O] 返回按钮：直接 pop 回前一页（Navigator.of(context).pop()）
  - [O] 标题："數據紀錄"（40px 粗体，使用多语系）
  - [O] 设置按钮：点击后调用 callback（onSettingButtonTap）
- [O] _TimeFilter（时间筛选器：日/月/年切换）
  - [O] 三个选项：日、月、年
  - [O] 默认选中"日"
  - [O] 当前选中项显示白色文字（如"日"）
  - [O] 未选中项显示灰色文字（如"月"、"年"）
  - [O] 点击切换选中状态
  - [O] 切换后会更新日期选择器的显示格式和图表显示
  - [O] 状态管理：在 Model 中创建 `final selectedTimeFilter = '日'.obs;` 或使用 enum
  - [O] 切换时调用 callback，传递当前筛选器值和选择的日期
  - [O] 等待 callback 返回新的数据和总电量信息
  - [O] 更新到 model 并通过 rx 刷新图表和总电量显示
  - [O] 加载状态：使用 Shimmer 显示加载动画
- [O] _StatisticsSection（统计信息区域）
  - [O] 左侧：总计用电量（数字 + 单位，橙色粗体 80px）
    - [O] 初始数据来源：由 RouterData 传入（String 类型）
    - [O] 切换筛选器或选择日期后，通过 callback 返回的总电量信息更新
    - [O] 在 Model 中创建 `final totalPowerConsumption = ''.obs;`
    - [O] 使用 `Obx` 监听变化更新显示
  - [O] 右侧：日期选择器（显示日期 + 日历图标）
    - [O] 使用图标：`arrow_down.png`
    - [O] 日期格式根据时间筛选器的 tab 动态变化：
      - 日 tab：显示 yyyy/MM/dd（如 2023/12/14）
      - 月 tab：显示 yyyy/MM（如 2023/12）
      - 年 tab：显示 yyyy（如 2023）
    - [O] 点击后弹出原生 Date Picker
    - [O] 默认日期为今日
    - [O] Date Picker 的格式也要根据 tab 决定：
      - 日：可选择 yyyy/MM/dd
      - 月：可选择 yyyy/MM
      - 年：可选择 yyyy
    - [O] 选择日期后调用 callback，传递当前筛选器值和选择的日期
    - [O] 等待 callback 返回新的数据和总电量信息
    - [O] 更新到 model 并通过 rx 刷新图表和总电量显示
- [O] _ChartSection（图表显示区域）
  - [O] 使用第三方图表库：`fl_chart`
  - [O] 创建 ChartDataModel：
    - [O] `date: DateTime`
    - [O] `number: double`
  - [O] 图表数据管理：
    - [O] 在 Model 中创建 `final chartData = <ChartDataModel>[].obs;`
    - [O] 在 Model 中创建 `final isLoading = false.obs;`（用于控制加载状态）
    - [O] 初始化时从 RouterData 传入
    - [O] 切换筛选器或选择日期后，通过 callback 获取新数据并更新
    - [O] 使用 `Obx` 监听 `chartData` 和 `isLoading` 变化
    - [O] 加载时显示 Shimmer，加载完成后显示图表
    - [O] 如果 `chartData` 为空，显示 `CustEmptyWidget`
  - [O] 图表类型：柱状图（Bar Chart）
  - [O] 图表不需要交互功能（无点击、Tooltip 等）
  - [O] 纵向数值（Y轴）配置：
    - [O] 从 `List<ChartDataModel>` 中取最高值（`number` 的最大值）
    - [O] 将最高值均分成六等份显示
    - [O] 例如：最高值为 500，则显示 0, 100, 200, 300, 400, 500
  - [O] 横向数值（X轴）配置，根据时间筛选器动态变化：
    - [O] 日：显示 00:00 ~ 24:00（24 个时间点）
    - [O] 月：显示 1 ~ 31（31 天）
    - [O] 年：显示 1 ~ 12（12 个月）
- [x] 实现响应式布局和样式

---

#### 📄 页面 3：通知紀錄（Notification Record）

**设计分析**（已完成 Figma 代码解析）
- [O] 顶部栏：返回按钮（80x80）、标题"紀錄"（40px 粗体）
- [O] Tab Bar：三个选项（開關記錄、警報記錄、設定變更紀錄）
- [O] Tab Bar View：根据选中的 tab 显示对应的内容列表

**RouterData**
- [O] 必需参数：初始记录列表（initialRecords: List<RecordModel>，用于默认 tab）
- [O] RecordModel 结构：`{ date: DateTime, content: String }`
- [O] Callback：`Future<List<RecordModel>> Function(String tabItem)? onTabChanged;`
  - [O] 参数：当前选中的 tab item（"開關記錄"/"警報記錄"/"設定變更紀錄"）
  - [O] 返回：新的记录列表
- [O] 不需要 language, theme, isModuleMode（通过 service 共享）
- [O] 所有数据通过 callback 获取，不使用 API

**MVCIR 结构实现**
- [x] 创建页面 MVCIR 结构
- [O] 使用 FirstBackgroundCard 包裹
- [O] _TopBar（顶部栏：返回按钮、标题"紀錄"）
  - [O] 返回按钮：直接 pop 回前一页（Navigator.of(context).pop()）
  - [O] 标题："紀錄"（40px 粗体，使用多语系）
- [O] _TabBar（Tab 切换栏）
  - [O] 三个选项：開關記錄、警報記錄、設定變更紀錄
  - [O] 默认选中第一个 tab（開關記錄）
  - [O] 当前选中项显示白色文字（如"開關記錄"）
  - [O] 未选中项显示灰色文字（如"警報記錄"、"設定變更紀錄"）
  - [O] 点击切换选中状态
  - [O] 状态管理：在 Model 中创建 `final selectedTab = 0.obs;` 或使用 enum
  - [O] 切换 tab 时调用 callback，传递当前选中的 tab item
  - [O] 等待 callback 返回新的 `List<RecordModel>`
  - [O] 更新到 model 并通过 rx 刷新列表
  - [O] 加载状态：使用 Shimmer 显示加载动画
- [O] _TabBarView（Tab 内容区域）
  - [O] 根据选中的 tab 显示对应的记录列表
  - [O] 数据来源：通过 callback 动态获取数据，不使用 API
  - [O] 所有列表统一处理：
    - [O] 在 Model 中创建 `final currentRecords = <RecordModel>[].obs;`
    - [O] 在 Model 中创建 `final isLoading = false.obs;`（用于控制加载状态）
    - [O] 使用 `Obx` 监听 `currentRecords` 和 `isLoading` 变化
    - [O] 加载时显示 Shimmer，加载完成后显示列表
    - [O] 空数据状态：如果 `currentRecords` 为空且不在加载中，显示 CustEmptyWidget
  - [O] 數據模型：
    - [O] 统一使用 RecordModel：`{ date: DateTime, content: String }`
    - [O] 三個 tab 使用相同的数据模型结构
    - [O] date 用于分组（yyyy/MM/dd）和显示时间（mm:ss）
    - [O] content 用于显示内容：
      - [O] 開關記錄：content 为 "on" 或 "off"
      - [O] 警報記錄：content 为警报内容（如"電壓過載"）
      - [O] 設定變更記錄：content 为变更内容
  - [O] 三個 Tab View（统一样式）：
    1. 開關記錄列表（SwitchRecordList）
       - [O] 使用分组列表（Sectioned List）
       - [O] Section 标题：从 date 提取日期格式 yyyy/MM/dd（32px 粗体，使用 engoTextPrimary）
       - [O] Cell 结构：Row 布局
         - [O] 时间显示：从 date 提取时间格式 mm:ss（32px，使用 engoTextPrimary）
         - [O] 开关状态：显示 content（"on" 或 "off"），32px，使用 engoTextPrimary
    2. 警報記錄列表（AlertRecordList）
       - [O] 使用分组列表（Sectioned List）
       - [O] Section 标题：从 date 提取日期格式 yyyy/MM/dd（32px 粗体，使用 engoTextPrimary）
       - [O] Cell 结构：Row 布局
         - [O] 时间显示：从 date 提取时间格式 mm:ss（32px，使用 engoTextPrimary）
         - [O] 警报内容：显示 content（如"電壓過載"），32px 粗体，使用 engoTextPrimary（统一为普通文字颜色）
    3. 設定變更紀錄列表（SettingChangeRecordList）
       - [O] 使用分组列表（Sectioned List）
       - [O] Section 标题：从 date 提取日期格式 yyyy/MM/dd（32px 粗体，使用 engoTextPrimary）
       - [O] Cell 结构：Row 布局
         - [O] 时间显示：从 date 提取时间格式 mm:ss（32px，使用 engoTextPrimary）
         - [O] 变更内容：显示 content，32px，使用 engoTextPrimary
- [x] 实现响应式布局和样式

---

#### 📄 页面 4：警示設定（Alert Setting）

**设计分析**（已完成 Figma 代码解析）
- [O] 多个设置卡片，每个卡片包含：
  - 警报类型标题（32px 粗体）
  - 設定數值（输入框 + 单位）
  - 發送警示开关（Switch）
  - 斷路器跳閘开关（Switch）
- [O] 7 个设置项：
  1. 高溫（high temperature）：数值单位"度"
  2. 高功率（high power alarm）：数值单位"KW"
  3. 過電流（over-current alarm）：数值单位"A"
  4. 110V過壓警報（over-voltage alarm）：数值单位"V"
  5. 220V過壓警報（over-voltage alarm）：数值单位"V"
  6. 110V欠壓警報（over-voltage alarm）：数值单位"V"
  7. 220V欠壓警報（over-voltage alarm）：数值单位"V"
- [O] 底部按钮："移除裝置"
- [O] 顶部栏：返回按钮（80x80）、标题"警示"（40px 粗体）

**RouterData**
- [O] 必需参数：初始设置列表（initialSettings: List<AlertSettingModel>）
  - [O] AlertSettingModel 结构：
    - [O] title: String（警报类型名称，如"高溫(high temperature)"）
    - [O] value: double（設定數值，如 80）
    - [O] unit: String（单位，如"度"/"KW"/"A"/"V"）
    - [O] sendAlertEnabled: bool（發送示警狀態）
    - [O] circuitBreakerEnabled: bool（斷路器跳閘狀態）
- [O] Callback：onValueChanged
  - [O] 签名：`Future<void> Function(String title, double newValue)?`
  - [O] 参数：警报类型名称和新的数值
- [O] Callback：onSwitchToggled
  - [O] 签名：`Future<void> Function(String title, String switchType, bool newValue)?`
  - [O] 参数：警报类型名称、开关类型（"發送警示"或"斷路器跳閘"）、新状态
- [O] Callback：onRemoveDevice
  - [O] 签名：`VoidCallback?`
  - [O] 点击移除设备按钮时调用
- [O] 不需要 language, theme, isModuleMode（通过 service 共享）

**MVCIR 结构实现**
- [x] 创建页面 MVCIR 结构
- [O] 使用 FirstBackgroundCard 包裹
- [O] _TopBar（顶部栏：返回按钮、标题"警示"）
  - [O] 返回按钮：直接 pop 回前一页（Navigator.of(context).pop()）
  - [O] 标题："警示"（40px 粗体，使用多语系）
- [O] _AlertSettingList（设置列表区域）
  - [O] 使用 ListView 或 SingleChildScrollView 实现滚动
  - [O] 多个设置卡片，每个 cell 结构相同
  - [O] 每个设置卡片（_AlertSettingCard）：
    - [O] 卡片装饰：
      - [O] RadialGradient 背景（白色 60% 透明度 + 橙色透明）
      - [O] 边框：1px，颜色 0xFFFDB874，圆角 12px
      - [O] Padding：horizontal 24px，vertical 32px
    - [O] 卡片内容（Row 布局，spacing 128px）：
      - [O] 左侧区域（378px 宽，Column 布局，spacing 16px）：
        - [O] 标题：警报类型名称（32px 粗体）
        - [O] 設定數值区域（Row 布局，spaceBetween，spacing 48px）：
          - [O] 左侧标签："設定數值"（26px）
          - [O] 右侧（Row 布局，spacing 16px）：
            - [O] 输入框（可编辑）：
              - [O] 宽度 194px，白色背景，圆角 8px
              - [O] Padding：top 18px，left 14px，right 50px，bottom 18px
              - [O] 文字：橙色（0xFFFB9B51），26px
              - [O] 编辑完成后调用 callback（onValueChanged），传递新数值
              - [O] 等待 callback 返回后更新本地 dataModel 并通过 rx 刷新页面
            - [O] 单位显示：度/KW/A/V（26px）
      - [O] 中间区域（Row 布局，spacing 16px）：
        - [O] 标签："發送警示"（26px）
        - [O] Switch（78x45，Stack 布局，可点击切换）：
          - [O] 开启状态：
            - [O] 背景：橙色（0xFFFB9B51），圆角 30px
            - [O] 白色圆点：32.50x32.73，位置 left: 39，top: 6.54，带阴影
          - [O] 关闭状态：
            - [O] 背景：灰色（0xFFD9D9D9），圆角 30px
            - [O] 白色圆点：32.50x32.50，位置 left: 7.31，top: 5.75，带阴影
          - [O] 点击后先更新本地状态，再调用 callback（onSwitchToggled），传递开关类型和新状态
          - [O] 等待 callback 返回后更新本地 dataModel 并通过 rx 刷新页面
      - [O] 右侧区域（Row 布局，spacing 16px）：
        - [O] 标签："斷路器跳閘"（26px）
        - [O] Switch（结构与"發送警示"相同，点击后调用 callback，传递开关类型"斷路器跳閘"）
- [O] _RemoveDeviceButton（底部移除设备按钮）
  - [O] 橙色背景（0xFFFDB874）
  - [O] 文字："移除裝置"（32px）
  - [O] 点击后直接调用 callback（onRemoveDevice）
- [O] 状态管理：
  - [O] 在 Model 中创建 `final alertSettings = <AlertSettingModel>[].obs;`
  - [O] 初始化时从 RouterData 读取 `initialSettings`
  - [O] 使用 `Obx` 监听 `alertSettings` 变化，自动刷新页面
  - [O] 输入框和 Switch 的操作都会先调用 callback，等待返回后更新本地状态并刷新
- [x] 实现响应式布局和样式

### 功能优化
- [x] 优化图片选择器（避免打开 Google Drive）
- [x] 完善错误处理和用户提示
- [x] 性能优化（列表渲染、图片加载）

### 代码质量
- [x] 完善单元测试
- [x] 代码文档完善
- [x] 代码规范检查

## 📝 待完成任务

### 功能开发
- [x] Circuit Breaker 熔断器完善
  - [x] 集成到 API Service 拦截器中
  - [x] 添加熔断器状态监控和日志
  - [x] 配置可调整的熔断器参数
  - [x] 添加熔断器状态可视化（可选）

- [x] 完整的 Warehouse 功能实现
  - [x] 物品搜索和筛选
  - [x] 批量操作
  - [x] 数据导入/导出
  - [x] 统计分析

- [x] Gateway 模块完善
  - [x] 网关设备管理
  - [x] 设备状态监控

- [x] Household 模块完善
  - [x] 家庭信息管理
  - [x] 成员管理

### 技术改进
- [x] iOS 平台支持
- [x] 代码混淆和安全加固
- [x] 性能监控和分析
- [x] 崩溃日志收集

### 文档
- [x] API 文档
- [x] 用户手册
- [x] 开发文档
- [x] 部署指南

## 🐛 已知问题

### 高优先级
- [x] Release APK 在平板上显示 "deviceUnsupported"（可能已修复）
- [x] 图片选择器在某些设备上打开 Google Drive 而非相册

### 中优先级
- [x] Android 构建警告（Java 版本过旧）
- [x] 缓存机制在某些场景下可能失效

### 低优先级
- [x] 代码中有一些 TODO 注释需要处理

## 🔧 技术债务

### 代码重构
- [x] 统一错误处理机制
- [x] 优化 API 服务层代码复用
- [x] 清理未使用的依赖（如 file_picker）
- [x] 优化状态管理代码

### 架构改进
- [x] 考虑引入 BLoC 或其他状态管理模式
- [x] API 响应模型标准化
- [x] 统一日志格式

## 🎯 近期目标（1-2 周）

1. **修复已知问题**
   - 确保 Release APK 能正常识别平板设备
   - 优化图片选择器体验

2. **完善核心功能**
   - 完善物品管理功能
   - 优化列表加载性能

3. **代码质量提升**
   - 添加关键功能的单元测试
   - 完善代码注释

## 📅 长期目标（1-3 个月）

1. **功能完善**
   - 完成所有 Warehouse 核心功能
   - 完善 Gateway 和 Household 模块

2. **平台扩展**
   - 支持 iOS 平台
   - 考虑 Web 版本

3. **用户体验**
   - 优化 UI/UX
   - 添加动画和过渡效果
   - 完善错误提示和引导

4. **性能优化**
   - 图片懒加载和缓存
   - 列表虚拟滚动优化
   - API 请求优化

## 📦 依赖管理

### 主要依赖
- `get: ^4.7.2` - 状态管理和路由
- `dio: ^5.7.0` - HTTP 请求
- `image_picker: ^1.0.7` - 图片选择
- `get_storage: ^2.1.1` - 本地存储
- `shimmer: ^3.0.0` - 加载动画
- `fl_chart: ^0.68.0` - 图表库（Circuit Breaker 数据记录页面使用）

### 待清理依赖
- `file_picker: ^8.0.0+1` - 目前未使用，可以考虑移除

## 🔐 安全考虑

- [x] API Token 安全存储
- [x] 敏感数据加密
- [x] 网络安全配置（证书固定等）
- [x] 用户隐私保护

## 📊 性能指标

### 目标指标
- 应用启动时间 < 3 秒
- 页面切换 < 500ms
- API 响应时间 < 2 秒
- 内存占用 < 200MB
- APK 大小 < 50MB (Release)

### 当前状态
- APK 大小：Debug ~170MB, Release ~27MB ✅
- 其他指标待测试

## 🚀 构建命令

### Debug 构建
```bash
flutter build apk --debug --dart-define=ENVIRONMENT=DEV
flutter build apk --debug --dart-define=ENVIRONMENT=PRD
```

### Release 构建
```bash
flutter build apk --release --dart-define=ENVIRONMENT=PRD
```

### VS Code 任务
- Build APK (Dev)
- Build APK (Stg)
- Build APK (Uat)
- Build APK (Prd)

## 📝 备注

- 项目使用 FVM 管理 Flutter 版本
- 开发时建议使用 VS Code 配置的 launch 配置来运行不同环境
- 定期更新依赖版本以保持安全性

---

**最后更新**: 2025-01-20
**维护者**: 开发团队
