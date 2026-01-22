# 项目开发计划 2 (Project Plan 2)

## 📋 项目概述

这是 PLAN.md 的补充文档，专注于 Water Value（止水閥）功能模块的开发。

**开发重点**：专注于 split view 右边 FirstBackgroundCard 内的内容开发。

---

## 🔄 进行中的任务

### 功能开发

#### Water Value 止水閥模块（参考 circuit_breaker 模块模式，遵循 STRUCTURE.md 规范）

**基础设施**
- [x] 创建 water_value_service.dart
- [x] 创建 water_value_service_model.dart
- [x] 所有页面共享 WaterValueService（在 Controller 构造函数中注册，参考 gateway 模式）
- [x] **重要**：此项目不使用 API，所有数据通过 RouterData 传入（供其他 RD 串接）

**RouterData 设计**
- [x] 创建 RouterData 类（包含所有 callback 函数，参考 CircuitBreakerMainPageRouterData）
- [ ] 主页面 RouterData（见下方页面 1）
- [ ] 其他页面 RouterData（根据需求添加）

---

#### 📄 页面 1：主页面（Water Value Main）

**设计分析**（已完成 Figma 代码解析）
- [x] 顶部栏：标题"水閥控制開關"、编辑按钮、设置按钮
- [x] 中间区域：开关控制区域
  - [x] 水閥图形显示（523x320，包含装饰性边框元素）
  - [x] 三个按钮水平排列：
    - [x] "關閉"按钮（140x140，圆形边框，3px 橙色边框）
    - [x] 中间状态显示："狀態"（24px）+ "開啟中"（48px 粗体，橙色）
    - [x] "開啟"按钮（140x140，圆形边框，3px 橙色边框，选中状态）
- [x] 底部区域：三个功能卡片（每个 400 宽）
  - [x] "設置"（设置）- 图标 70x70 + 文字 32px
  - [x] "定時"（定时）- 图标 70x70 + 文字 32px
  - [x] "倒計時"（倒计时）- 图标 70x70 + 文字 32px
  - [x] 卡片样式：RadialGradient 背景（白色 60% 透明度 + 橙色透明）、橙色边框 1px、圆角 12px

**RouterData**
- [x] 必需参数：止水閥名称（waterValueName: String，默认"水閥控制開關"）
- [x] 必需参数：开关初始状态（initialSwitchState: bool，"開啟"或"關閉"）
- [x] 可选参数：language, theme, isModuleMode（参考 gateway）
- [x] Callback：onSwitchToggle（切换开关状态），onBackButtonTap，onEditButtonTap，onSettingButtonTap
- [x] Callback：onTimerButtonTap（点击"定時"卡片，跳转到定时列表页面）
- [x] 所有页面文本使用多语系（hard code），不需要从外部传入

**MVCIR 结构实现**
- [x] 创建页面 MVCIR 结构
- [x] 使用 FirstBackgroundCard 包裹（参考 circuit_breaker_main_page）
- [x] 实现页面布局组件：
  - [x] _TopBar（顶部栏：返回按钮、标题、编辑按钮、设置按钮）
    - [x] 左侧返回按钮：`EnumImage.cArrowLeft`，大小 80.0.scale，颜色 `EnumColor.engoIconBackButton.color`
    - [x] 中间标题："止水閥"（40px 粗体）+ 编辑按钮：`EnumImage.cPencilLine`，大小 50.0.scale，颜色 `EnumColor.engoTextPrimary.color`
    - [x] 右侧设置按钮：`EnumImage.cSetting`，大小 62.0.scale，颜色 `EnumColor.engoTextPrimary.color`
    - [x] 使用 `CustIconButton` 组件（参考 gateway_main_page.dart）
  - [x] _SwitchControl（中间开关控制区域）
    - [x] 水閥图形显示区域（根据状态动态调整尺寸）
      - [x] 开启状态：523x320
      - [x] 关闭状态：503x304
      - [x] 使用 Stack 布局，包含装饰性边框元素（参考 Figma 设计）
      - [x] 使用图片资源：`water_value_on.png`（开启）和 `water_value_off.png`（关闭）
    - [x] 三个按钮水平排列（Row，spacing: 128）
      - [x] "關閉"按钮（140x140，圆形边框 83.5px 圆角）
        - [x] 边框：3px，颜色使用主题色
        - [x] 文字："關閉"（32px）
        - [x] 点击后切换状态为"關閉"
      - [x] 中间状态显示（Column，spacing: 9）
        - [x] "狀態"标签（24px）
        - [x] 开启状态："開啟中"（48px 粗体，橙色）
        - [x] 关闭状态："關閉中"（48px 粗体，灰色）
        - [x] 根据开关状态动态显示文字和颜色
      - [x] "開啟"按钮（140x140，圆形边框 83.5px 圆角）
        - [x] 边框：3px，颜色使用主题色
        - [x] 文字："開啟"（32px）
        - [x] 点击后切换状态为"開啟"
    - [x] 状态管理：
      - [x] 在 Model 中创建 `final isSwitchOn = false.obs;`（true = 開啟，false = 關閉）
      - [x] 初始化时从 RouterData 读取：`_model.isSwitchOn.value = routerData.initialSwitchState;`
      - [x] 在 RouterData 中定义 callback：`Future<void> Function(bool newValue)? onSwitchToggle;`
      - [x] 在 Interactive 中处理点击：更新本地状态并调用 callback
      - [x] 在 View 中使用 `Obx` 监听 `isSwitchOn` 变化，更新按钮样式和状态文字
  - [x] _FunctionCards（底部功能卡片区域）
    - [x] 单个功能卡片居中显示（只包含"定時"卡片）
    - [x] 卡片样式：
      - [x] RadialGradient 背景：使用主题色
      - [x] 边框：1px，颜色使用主题色
      - [x] 圆角：12px
      - [x] Padding：horizontal 88px，vertical 16px
      - [x] 宽度：400
    - [x] "定時"卡片：
      - [ ] 图标容器（70x70）- 待确认图标（目前为占位符）
      - [x] 文字："定時"（32px）
      - [x] 点击后调用 callback：`onTimerButtonTap`
- [x] 实现响应式布局和样式

---

#### 📄 页面 2：定時設定（Timer Setting）

**设计分析**（已完成 Figma 代码解析）
- [x] 顶部栏：返回按钮、标题"定時設定"、设置按钮
- [x] Tab 切换栏（1195x68）：
  - [x] "開啟和關閉"（选中，白色文字，橙色背景）
  - [x] "開啟"（未选中，灰色文字）
  - [x] "關閉"（未选中，灰色文字）
- [x] 时间选择器区域（两个并排，每个 593 宽）：
  - [x] 左侧："開啟時間"
  - [x] 右侧："關閉時間"
  - [x] 每个时间选择器包含：
    - [x] 上午/下午选择（65px 宽，spacing: 88）
    - [x] 小时选择（38px 宽，显示 08-11，spacing: 88）
    - [x] 分钟选择（38px 宽，显示 55, 00, 05, 10，spacing: 88）
    - [x] 选中项显示橙色（0xFFFB9B51），未选中显示灰色（0xFF7C7C7C）
    - [x] 选中背景条：灰色 30% 透明度（0xFF989898），46px 高，位置 top: 61
- [x] 重复设置区域：
  - [x] "重覆"标签（64px 宽，32px 文字）
  - [x] Switch 开关（101x58，橙色背景 0xFFFB9B51，白色圆点 42.08x42.18，带阴影）
  - [x] 分隔线（1px，灰色 0xFF7C7C7C）
- [x] 工作日选择卡片（1195x68）：
  - [x] 白色背景，橙色边框 1px，圆角 12px
  - [x] "工作日"（选中，白色文字）
  - [x] "每天"（未选中，灰色文字）
  - [x] "自定義"（未选中，灰色文字）
- [x] 设定区域：
  - [x] "設定"标签（64px 宽，32px 文字）
  - [x] "冷氣 26˚C 自動"文字（26px，灰色）
  - [x] 图标（58x58）
  - [x] 分隔线
- [x] 标签区域：
  - [x] "標籤"标签（64px 宽，32px 文字）
  - [x] "未命名"文字（26px，灰色）
  - [x] 图标（58x58）
  - [x] 分隔线
- [x] 底部按钮：
  - [x] "儲存"按钮（橙色背景 0xFFFDB874，32px 文字，圆角 12px，padding: horizontal 235px, vertical 24px）

**RouterData**
- [ ] 必需参数：初始定时设置数据
- [ ] Callback：onSave（保存定时设置）
- [ ] Callback：onTabChanged（切换 Tab：開啟和關閉/開啟/關閉）
- [ ] Callback：onTimeChanged（时间选择器变化）
- [ ] Callback：onRepeatToggle（重复开关切换）
- [ ] Callback：onWeekdayChanged（工作日选择变化）
- [ ] Callback：onSettingTap（点击设定）
- [ ] Callback：onLabelTap（点击标签）

**MVCIR 结构实现**
- [ ] 创建页面 MVCIR 结构
- [ ] 使用 FirstBackgroundCard 包裹
- [ ] 实现页面布局组件：
  - [ ] _TopBar（顶部栏：返回按钮、标题"定時設定"、设置按钮）
  - [ ] _TabBar（Tab 切换栏：開啟和關閉、開啟、關閉）
  - [ ] _TimePickerSection（时间选择器区域：两个并排的时间选择器）
  - [ ] _RepeatSection（重复设置区域：Switch 开关）
  - [ ] _WeekdaySelector（工作日选择卡片）
  - [ ] _SettingSection（设定区域）
  - [ ] _LabelSection（标签区域）
  - [ ] _SaveButton（底部儲存按钮）

---

#### 📄 页面 3：定時列表（Timer List）

**设计分析**
- [ ] 框架：使用 FirstBackgroundCard 包裹（与主页面一致）
- [ ] 顶部栏：返回按钮、标题"定時列表"（或类似标题）
- [ ] 内容区域：ScrollView 显示所有设定的定时信息
- [ ] 每个 Cell 内容：
  - [ ] Row 布局，包含两部分：
    - [ ] 左侧 Column：显示定时信息
      - [ ] 时间：上下午 + 时:分（例如："上午 09:00"）
      - [ ] 重复周期：
        - [ ] 有周期：显示选中的周一到周日（例如："一、三、五"）
        - [ ] 没有周期：显示"僅執行一次"
      - [ ] 水閥狀態：顯示"開啟"或"關閉"
      - [ ] 通知狀態：顯示"開啟"或"關閉"
    - [ ] 右侧 Switch：确认是否执行定时动作

**RouterData**
- [ ] 必需参数：定时列表数据（List<TimerItem>）
- [ ] Callback：onBackButtonTap（返回）
- [ ] Callback：onTimerItemTap（点击某个定时项，跳转到定时设定页面编辑）
- [ ] Callback：onTimerItemToggle（切换某个定时项的 Switch）
- [ ] Callback：onAddTimer（添加新定时，跳转到定时设定页面）

**数据结构**
- [ ] TimerItem 类：
  - [ ] id: String（唯一标识）
  - [ ] time: TimeOfDay（时间）
  - [ ] isOpenTime: bool（true = 開啟，false = 關閉）
  - [ ] isRepeatEnabled: bool（是否重复）
  - [ ] selectedDays: Set<int>（选中的星期，0-6 代表周一到周日，空集合表示仅执行一次）
  - [ ] isNotificationEnabled: bool（通知状态）
  - [ ] isEnabled: bool（是否启用，对应 Switch 状态）
  - [ ] note: String（備注）
  - [ ] label: String（標籤）

**MVCIR 结构实现**
- [ ] 创建页面 MVCIR 结构
- [ ] 使用 FirstBackgroundCard 包裹
- [ ] 实现页面布局组件：
  - [ ] _TopBar（顶部栏：返回按钮、标题）
  - [ ] _TimerList（ScrollView 列表，显示所有定时项）
  - [ ] _TimerItemCell（单个定时项 Cell）
    - [ ] 左侧信息 Column
    - [ ] 右侧 Switch

**页面跳转逻辑**
- [ ] 第一页点击"定時"按钮 → 跳转到第三页（定时列表）
- [ ] 第三页点击某个定时项 → 跳转到第二页（定时设定页面，编辑模式）
- [ ] 第三页添加新定时 → 跳转到第二页（定时设定页面，新建模式）

---

## 📝 待完成任务

### 功能开发
- [x] 完成 Figma 设计稿解析，确认具体 UI 设计
- [ ] 实现 _SwitchControl 组件（水閥图形 + 三个按钮）
- [ ] 实现 _FunctionCards 组件（三个功能卡片）
- [ ] 添加水閥图形资源或自定义绘制
- [ ] 添加功能卡片图标（設置、定時、倒計時）
- [ ] 更新 RouterData，添加功能卡片的 callback
- [ ] 添加多语系支持（水閥控制開關、關閉、開啟、開啟中、關閉中、設置、定時、倒計時）
- [ ] 根据需求添加其他子页面（設置、定時、倒計時页面）

### 技术改进
- [ ] 优化 UI 交互体验
- [ ] 完善错误处理和用户提示

---

## 🔍 需要确认的问题

### 第一页（主页面）

1. **资源文件**：
   - [x] 水閥图形：已使用图片资源（`EnumImage.tWaterValueOn` 和 `EnumImage.tWaterValueOff`）
   - [x] "定時"功能卡片的图标：已使用 `EnumImage.cClock`

2. **功能需求**：
   - [x] "定時"功能：点击后跳转到定时列表页面（第三页）
   - [x] "設置"功能：右上角设置按钮，通过 callback 接口（`onSettingButtonTap`）丢出去，跟 gateway 一样
   - [x] "倒計時"功能：已移除，不需要实现

3. **交互细节**：
   - [x] 水閥图形根据开关状态变化：已实现，使用 AnimatedContainer
   - [x] 点击"關閉"或"開啟"按钮时的动画效果：已实现，使用 AnimatedButton 组件（缩放动画）

### 第二页（定时设定页面）

1. **功能确认**：
   - [x] Tab 栏：已简化为"開啟"和"關閉"两个选项
   - [x] 时间选择器：已改为单个居中显示
   - [x] 重复开关：已实现
   - [x] 工作日选择：已实现（工作日、每天、自定義）
   - [x] 周一到周日列表：已实现（当重复开启且选择自定義时显示）
   - [x] 備注：已改为 TextField
   - [x] 執行通知：已改为 Switch

### 第三页（定时列表页面）

1. **功能确认**：
   - [x] "添加新定时"按钮：放在列表底部
   - [x] Cell 的样式：符合框架的卡片样式（参考其他页面）
   - [x] 重复周期的显示格式：一三五（简写）
   - [x] 空状态：使用 CustEmptyWidget
   - [x] Cell 不能点击（不能跳转到编辑页面）
   - [x] 右上角的设置点击后，每个 cell 的右边长出 trashcan，点击后可以删除

---

**最后更新**: 2025-01-20
**维护者**: 开发团队
