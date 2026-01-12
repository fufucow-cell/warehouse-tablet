# 项目架构规范

本文档基于 `lib/feature/warehouse` 目录结构，定义了项目中每个 feature 模块的标准架构规范。

## 快速开始

项目提供了多个自动化脚本来简化开发工作：
- **MVC Operator**：快速创建页面结构
- **资源更新脚本**：自动生成颜色、图片、多语系的枚举映射

详细使用方法请参考下方各章节。

## 使用项目脚本

项目提供了多个自动化脚本来简化开发工作，**强烈建议使用脚本而非手动操作**。

### MVC Operator 脚本

项目提供了自动化脚本 `script/mvcir_create.dart` 来快速创建符合规范的页面结构。

### 创建新页面

使用 `mvcir_create.dart` 脚本创建完整的 MVCIR 结构：

```bash
dart script/mvcir_create.dart <feature_name> <page_name>
```

**示例：**
```bash
# 创建 warehouse feature 下的 item 页面
dart script/mvcir_create.dart warehouse item

# 创建 bank_record feature 下的 main 页面
dart script/mvcir_create.dart bank_record main
```

**脚本会自动创建：**
- `lib/feature/{feature_name}/page/{page_name}/` 目录
- `{feature_name}_{page_name}_page.dart` (View)
- `{feature_name}_{page_name}_page_model.dart` (Model)
- `{feature_name}_{page_name}_page_controller.dart` (Controller)
- `{feature_name}_{page_name}_page_interactive.dart` (Interactive)
- `{feature_name}_{page_name}_page_route.dart` (Route)

所有文件都会包含符合规范的初始代码模板。

### 完整工作流程示例

```bash
# 1. 创建新页面
dart script/mvcir_create.dart warehouse record

# 2. 开始开发...
# 编辑生成的文件，添加业务逻辑
```

### 资源更新脚本

项目提供了三个脚本来自动生成资源映射文件，当添加新的颜色、图片或多语系文本时，运行相应脚本即可自动更新枚举。

#### Color Update（颜色更新）

**脚本：** `script/color_update.dart`

**功能：**
- 从 `lib/feature/warehouse/parent/constant/theme/color_data.dart` 中提取所有颜色 key
- 自动生成 `EnumColor` enum 到 `color_map.dart`
- 支持普通颜色和渐变颜色（Gradient）的自动识别和分组

**使用方法：**
```bash
dart script/color_update.dart
```

**使用场景：**
- 在 `color_data.dart` 中添加新的颜色定义后
- 修改颜色 key 名称后
- 需要同步更新 `color_map.dart` 时

**示例：**
```dart
// 1. 在 color_data.dart 中添加新颜色
Map<String, ColorData> colorDataMap = {
  'backgroundPrimary': ColorData(...),
  'textSecondary': ColorData(...),
  'newColor': ColorData(...), // 新增颜色
};

// 2. 运行脚本
dart script/color_update.dart

// 3. color_map.dart 会自动更新，包含新的 EnumColor.newColor
```

**生成内容：**
- `EnumColor` enum，包含所有颜色 key
- 自动处理渐变颜色分组（如 `backgroundItemGradient1`, `backgroundItemGradient2` 会合并为 `backgroundItemGradient`）
- 提供 `color` getter 根据当前主题返回对应颜色
- 提供 `colors` getter 返回渐变颜色列表

#### Image Update（图片更新）

**脚本：** `script/image_update.dart`

**功能：**
- 扫描 `lib/feature/warehouse/parent/assets/images/` 目录下的所有图片文件
- 自动生成 `EnumImage` enum 到 `image_map.dart`
- 根据图片所在目录自动添加前缀：
  - `common/` 目录 → `c` 前缀（如 `cCow`, `cHouse`）
  - `light/` 或 `dark/` 目录 → `t` 前缀（如 `tCow`, `tLogo`）

**使用方法：**
```bash
dart script/image_update.dart
```

**使用场景：**
- 添加新图片到 `assets/images/` 目录后
- 删除图片文件后
- 需要同步更新 `image_map.dart` 时

**目录结构：**
```
lib/feature/warehouse/parent/assets/images/
├── common/          # 通用图片（不随主题变化）
│   ├── cow.png      → EnumImage.cCow
│   └── house.png    → EnumImage.cHouse
├── light/           # 浅色主题图片
│   ├── logo.png     → EnumImage.tLogo
│   └── icon.png     → EnumImage.tIcon
└── dark/            # 深色主题图片
    ├── logo.png     → EnumImage.tLogo（与 light 共用）
    └── icon.png     → EnumImage.tIcon（与 light 共用）
```

**示例：**
```bash
# 1. 添加新图片到 common/ 目录
# lib/feature/warehouse/parent/assets/images/common/new_icon.png

# 2. 运行脚本
dart script/image_update.dart

# 3. image_map.dart 会自动更新，包含 EnumImage.cNewIcon
```

**生成内容：**
- `EnumImage` enum，包含所有图片
- 提供 `path` getter 根据当前主题返回图片路径
- 提供 `image()` 方法返回图片 Widget
- 提供 `decorationImage` getter 返回装饰图片

#### Locale Update（多语系更新）

**脚本：** `script/locale_update.dart`

**功能：**
- 从 `lib/feature/warehouse/parent/constant/locales/zh_tw.dart` 中提取所有 key
- 自动生成 `EnumLocale` enum 到 `locale_map.dart`
- 提供 `tr` getter 和 `trArgs()` 方法用于多语系翻译

**使用方法：**
```bash
dart script/locale_update.dart
```

**使用场景：**
- 在 `zh_tw.dart` 中添加新的多语系 key 后
- 修改多语系 key 名称后
- 需要同步更新 `locale_map.dart` 时

**示例：**
```dart
// 1. 在 zh_tw.dart 中添加新的多语系文本
Map<String, String> zhTW = {
  'item': '物品',
  'cabinet': '櫃子',
  'newKey': '新文本', // 新增 key
};

// 2. 运行脚本
dart script/locale_update.dart

// 3. locale_map.dart 会自动更新，包含 EnumLocale.newKey
```

**生成内容：**
- `EnumLocale` enum，包含所有多语系 key
- 提供 `tr` getter 返回当前语言的翻译文本
- 提供 `trArgs(List<String> params)` 方法支持参数替换（使用 `@para1`, `@para2` 等占位符）

**使用示例：**
```dart
// 基本使用
Text(EnumLocale.item.tr)

// 带参数
Text(EnumLocale.welcomeMessage.trArgs(['John', 'Admin']))
// zh_tw.dart: 'welcomeMessage': '歡迎 @para1，您的角色是 @para2'
```

### 脚本使用最佳实践

1. **添加资源后立即运行脚本**：添加颜色、图片或多语系文本后，立即运行相应脚本更新映射文件
2. **提交前检查生成文件**：确保生成的文件符合预期，必要时可以手动调整
3. **不要手动修改生成文件**：所有 `*_map.dart` 文件都是自动生成的，手动修改会在下次运行时被覆盖
4. **版本控制**：建议将生成的文件也纳入版本控制，方便团队协作
```

## 目录结构

```
lib/feature/{feature_name}/
├── page/                    # 页面目录
│   ├── {page_name}/         # 具体页面
│   │   ├── ui/              # UI 组件（可选，仅在需要共用 UI 时创建）
│   │   │   └── ...
│   │   ├── {page_name}_page.dart              # View (V)
│   │   ├── {page_name}_page_controller.dart    # Controller (C)
│   │   ├── {page_name}_page_model.dart         # Model (M)
│   │   ├── {page_name}_page_interactive.dart   # Interactive (I)
│   │   └── {page_name}_page_route.dart         # Route (R)
│   └── ...
├── parent/                  # 父级目录（共用资源，不随模块复制）
│   ├── model/               # API 请求和响应模型
│   │   ├── request_model/   # 请求模型
│   │   └── response_model/  # 响应模型
│   ├── constant/            # 常量定义（颜色、多语系等）
│   ├── assets/              # 资源文件（图片、mock 数据等）
│   ├── util/                # 工具类
│   └── inherit/             # 继承和扩展
├── service/                  # 服务目录
│   ├── {feature_name}_service.dart
│   └── {feature_name}_service_model.dart
├── ui/                       # 共用 UI 组件（可选）
│   └── ...
└── util/                     # 共用工具类（可选）
    └── ...
```

## 核心组件说明

### 1. Service（服务层）

**职责：**
- 提供所有 page 共用的数据和状态管理
- 处理所有 API 请求和响应
- 作为数据中介，从外部 service 或 util 获取数据后传递给 page controller
- 管理 feature 级别的全局状态

**文件结构：**
- `{feature_name}_service.dart` - 服务主文件
- `{feature_name}_service_model.dart` - 服务数据模型（独立文件，使用 `import` 引入）

**Service 文件结构规范：**

Service 文件必须遵循以下结构，使用 `// MARK:` 注释进行分段：

```dart
class ApiService extends GetxService {
  // MARK: - Properties

  static const String _tagName = 'warehouse';
  static ApiService get instance => Get.find<ApiService>(tag: _tagName);

  // MARK: - Init

  ApiService._internal();

  static ApiService register(String baseUrl) {
    if (Get.isRegistered<ApiService>(tag: _tagName)) {
      return instance;
    }
    final ApiService service = ApiService._internal();
    // 初始化逻辑
    Get.put<ApiService>(service, tag: _tagName, permanent: true);
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<ApiService>(tag: _tagName)) {
      Get.delete<ApiService>(tag: _tagName);
    }
  }

  // MARK: - Public Method

  // 公共方法...

  // MARK: - Private Method

  // 私有方法...
}
```

**Service Model 文件结构规范：**

Service Model 文件必须遵循以下结构：

```dart
/// Service Model 说明
class ApiServiceModel {
  ApiServiceModel._();
  static final ApiServiceModel instance = ApiServiceModel._();

  // Service instance properties
  final Dio dio = Dio();

  // Cache properties
  final Map<String, RequestCache> requestCache = {};
  final Map<String, dynamic> responseCache = {};
  Timer? cacheCleanupTimer;
  static const int cacheExpirationSeconds = 10;

  // Mock properties
  static const bool isAllMock = false;
  List<EnumApiInfo> get mockApiList => [];
}

// 相关的枚举类型
enum EnumApiInfo {
  // ...
}
```

**关键规范：**

1. **单例模式**：
   - Service 使用 `GetxService` 和 GetX 的依赖注入
   - Service Model 使用单例模式：`Model._()` 私有构造函数 + `static final Model instance = Model._()`

2. **注册和注销**：
   - 必须提供 `static register()` 方法用于注册服务
   - 必须提供 `static unregister()` 方法用于注销服务
   - `instance` getter 通过 `Get.find()` 获取已注册的实例

3. **数据访问**：
   - Service 通过 `ServiceModel.instance.propertyName` 访问 Model 中的数据
   - Service Model 包含所有服务的数据和状态

4. **文件关系**：
   - Service 和 Service Model 是**独立文件**，使用 `import` 引入，**不使用 `part`**
   - Service Model 可以包含相关的枚举类型

5. **MARK 注释规范**：
   - `// MARK: - Properties` - 属性部分
   - `// MARK: - Init` - 初始化部分（构造函数、register、unregister）
   - `// MARK: - Public Method` - 公共方法部分
   - `// MARK: - Private Method` - 私有方法部分（可选）

**完整示例：**

```dart
// api_service.dart
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/api_service/api_service_model.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  // MARK: - Properties

  static const String _tagName = 'warehouse';
  static ApiService get instance => Get.find<ApiService>(tag: _tagName);

  // MARK: - Init

  ApiService._internal();

  static ApiService register(String baseUrl) {
    if (Get.isRegistered<ApiService>(tag: _tagName)) {
      return instance;
    }
    final ApiService service = ApiService._internal();
    ApiServiceModel.instance.dio.options.baseUrl = baseUrl;
    Get.put<ApiService>(service, tag: _tagName, permanent: true);
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<ApiService>(tag: _tagName)) {
      Get.delete<ApiService>(tag: _tagName);
    }
  }

  // MARK: - Public Method

  Future<void> sendRequest() async {
    // 使用 ApiServiceModel.instance.dio
  }
}

// api_service_model.dart
import 'package:dio/dio.dart';

class ApiServiceModel {
  ApiServiceModel._();
  static final ApiServiceModel instance = ApiServiceModel._();

  final Dio dio = Dio();
  final Map<String, dynamic> cache = {};
}

enum EnumApiInfo {
  // ...
}
```

### 2. Request & Response Model（请求和响应模型）

**位置：** `lib/feature/{feature_name}/parent/model/`

**目录结构：**
```
lib/feature/{feature_name}/parent/model/
├── request_model/              # API 请求模型
│   └── {feature_name}_{entity}_request_model/
│       ├── {feature_name}_{entity}_request_model.dart
│       ├── {feature_name}_{entity}_request_model.freezed.dart  # 自动生成
│       └── {feature_name}_{entity}_request_model.g.dart        # 自动生成
└── response_model/             # API 响应模型
    └── {feature_name}_{entity}_response_model/
        ├── {feature_name}_{entity}_response_model.dart
        ├── {feature_name}_{entity}_response_model.freezed.dart  # 自动生成
        └── {feature_name}_{entity}_response_model.g.dart        # 自动生成
```

**生成方式：**
- 使用 **VSCode 的 "Json to Dart Model" 插件**生成
- 使用 **Freezed** 包进行代码生成
- 生成后需要运行 `dart run build_runner build` 生成 `.freezed.dart` 和 `.g.dart` 文件

**使用步骤：**
1. 在 VSCode 中安装 "Json to Dart Model" 插件
2. 准备 JSON 格式的请求或响应数据
3. 使用插件生成 Dart Model 代码
4. 确保生成的代码使用 `@freezed` 注解和 `freezed_annotation` 包
5. 运行 `dart run build_runner build` 生成 Freezed 相关文件

**示例：**
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_item_request_model.freezed.dart';
part 'warehouse_item_request_model.g.dart';

@freezed
class WarehouseItemRequestModel with _$WarehouseItemRequestModel {
  factory WarehouseItemRequestModel({
    @JsonKey(name: 'item_id') String? itemId,
    @JsonKey(name: 'cabinet_id') String? cabinetId,
    @JsonKey(name: 'category_id') String? categoryId,
  }) = _WarehouseItemRequestModel;

  factory WarehouseItemRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WarehouseItemRequestModelFromJson(json);
}
```

**注意事项：**
- 所有 Model 必须使用 `@freezed` 注解
- 使用 `@JsonKey` 处理 JSON 字段名与 Dart 变量名的映射
- 生成后不要手动修改 `.freezed.dart` 和 `.g.dart` 文件
- 修改 Model 后需要重新运行 `build_runner` 生成代码

### 3. Page（页面层）

每个 page 遵循 **MVCIR** 架构模式：

#### M - Model（模型）
**文件：** `{page_name}_page_model.dart`

**职责：**
- 定义页面的数据模型和状态
- 使用 GetX 的响应式变量（`Rx`, `Rxn`）管理状态

**示例：**
```dart
class WarehouseMainPageModel {
  final isTabControllerReady = false.obs;
  final isLoading = false.obs;
}
```

#### V - View（视图）
**文件：** `{page_name}_page.dart`

**职责：**
- 定义页面的 UI 结构
- **只能与 Controller 交互**，不能直接调用 Service
- 通过 Controller 获取数据和触发事件

**示例：**
```dart
class WarehouseMainPage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseMainPageController>(
      builder: (controller) {
        return Obx(() {
          // 通过 controller 获取数据
          final data = controller.dataRx.value;
          return Scaffold(...);
        });
      },
    );
  }
}
```

#### C - Controller（控制器）
**文件：** `{page_name}_page_controller.dart`

**职责：**
- 作为 View 和 Service 之间的桥梁
- 管理页面的业务逻辑
- 调用 Service 获取数据和处理 API 事件
- 通过 `part` 引入 Interactive 和 Route

**文件结构：**
```dart
part '{page_name}_page_interactive.dart';
part '{page_name}_page_route.dart';

class WarehouseMainPageController extends GetxController {
  final _model = WarehouseMainPageModel();
  WarehouseService get _service => WarehouseService.instance;

  // 通过 service 获取数据
  RxReadonly<List<Item>> get itemsRx => _service.allItemsRx;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void _loadData() {
    // 调用 service 获取数据
    _service.apiReqReadItem(...);
  }
}
```

#### I - Interactive（交互处理）
**文件：** `{page_name}_page_interactive.dart`（使用 `part of`）

**职责：**
- 处理所有用户点击事件和交互
- 定义交互事件枚举
- 将事件转发给 Route 或执行相应逻辑

**示例：**
```dart
part of 'warehouse_main_page_controller.dart';

enum EnumWarehouseMainPageInteractive {
  selectTabItem,
  tapSearch,
  tapCreate,
}

extension WarehouseMainPageUserEventExtension on WarehouseMainPageController {
  void interactive(
    EnumWarehouseMainPageInteractive type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumWarehouseMainPageInteractive.tapSearch:
        routerHandle(EnumWarehouseMainPageRoute.showSearchDialog);
      case EnumWarehouseMainPageInteractive.tapCreate:
        routerHandle(EnumWarehouseMainPageRoute.showCreateItemDialog);
    }
  }
}
```

#### R - Route（路由处理）
**文件：** `{page_name}_page_route.dart`（使用 `part of`）

**职责：**
- 处理所有与 `context` 相关的操作
- 弹窗显示/隐藏
- 页面跳转和导航
- 所有需要 `BuildContext` 的操作

**示例：**
```dart
part of 'warehouse_main_page_controller.dart';

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
}
```

## 数据流向

```
┌─────────┐
│  View   │
└────┬────┘
     │ 1. 获取数据/触发事件
     ▼
┌─────────────┐
│ Controller  │
└────┬────┬───┘
     │    │
     │    │ 2. 处理交互
     │    ▼
     │  ┌──────────────┐
     │  │ Interactive  │
     │  └──────┬───────┘
     │         │ 3. 路由处理
     │         ▼
     │  ┌──────────────┐
     │  │    Route     │
     │  └──────────────┘
     │
     │ 4. 获取数据/API 调用
     ▼
┌─────────┐
│ Service │
└────┬────┘
     │ 5. 从外部获取
     ▼
┌─────────┐
│ Util /  │
│ Other   │
│ Service │
└─────────┘
```

## 交互规范

### View → Controller
- View 通过 `GetBuilder` 或 `Get.find` 获取 Controller
- 通过 `Obx` 监听响应式数据变化
- 点击事件调用 `controller.interactive(EnumInteractiveType)`

### Controller → Service
- Controller 通过 `Service.instance` 获取 Service
- 调用 Service 的方法获取数据或处理 API
- Service 负责从外部 service/util 获取数据后返回给 Controller

### Interactive → Route
- Interactive 处理用户事件后，需要 context 相关操作时调用 `routerHandle(EnumRouteType)`
- Route 负责所有弹窗、导航等 context 操作

## 可选目录

### ui/（共用 UI 组件）
- 当多个 page 需要共用 UI 组件时创建
- 放在 feature 根目录下的 `ui/` 文件夹
- 例如：`dialog_with_photo_widget.dart`, `first_background_card.dart`

### util/（共用工具类）
- 当多个 page 需要共用工具函数时创建
- 放在 feature 根目录下的 `util/` 文件夹
- 例如：`record_util.dart`, `cabinet_util.dart`

### page/{page_name}/ui/（页面内 UI 组件）
- 当某个 page 有多个 UI 组件需要组织时创建
- 放在对应 page 目录下的 `ui/` 文件夹
- 例如：`page/item/ui/filter_info.dart`

## 注意事项

1. **View 只能与 Controller 交互**，不能直接调用 Service
2. **所有点击事件**必须通过 `Interactive` 处理
3. **所有 context 相关操作**（弹窗、导航）必须在 `Route` 中处理
4. **Service 是数据中介**，负责从外部获取数据后传递给 Controller
5. **Model 使用响应式变量**（`Rx`, `Rxn`）管理状态
6. **Interactive 和 Route 使用 `part of`** 引入到 Controller 中
7. **优先使用脚本创建页面**，确保结构一致性和规范性

## 示例结构

```
lib/feature/warehouse/
├── page/
│   ├── main/
│   │   ├── ui/
│   │   │   └── tab_bar.dart
│   │   ├── warehouse_main_page.dart
│   │   ├── warehouse_main_page_controller.dart
│   │   ├── warehouse_main_page_model.dart
│   │   ├── warehouse_main_page_interactive.dart
│   │   └── warehouse_main_page_route.dart
│   ├── item/
│   │   ├── ui/
│   │   │   ├── filter_info.dart
│   │   │   └── item_list.dart
│   │   ├── warehouse_item_page.dart
│   │   ├── warehouse_item_page_controller.dart
│   │   ├── warehouse_item_page_model.dart
│   │   ├── warehouse_item_page_interactive.dart
│   │   └── warehouse_item_page_route.dart
│   └── ...
├── service/
│   ├── warehouse_service.dart
│   └── warehouse_service_model.dart
├── ui/
│   ├── dialog_with_photo_widget.dart
│   └── first_background_card.dart
└── util/
    ├── record_util.dart
    └── cabinet_util.dart
```
