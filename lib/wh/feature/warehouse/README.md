# Warehouse 模組遷移指南

本指南說明如何將 `warehouse` 資料夾直接搬移到另一個專案中使用。

## 步驟 1: 複製資料夾

將整個 `lib/feature/warehouse` 資料夾複製到目標專案的 `lib/feature/` 目錄下。

## 步驟 2: 替換 Import Path

在整個 `warehouse` 資料夾中，將所有的 import path 從 `engo_terminal_app3` 替換為目標專案的名稱 `${PROJECT_NAME}`。

### 方法 1: 使用 IDE 全域搜尋替換

### 方法 2: 使用命令列工具

在專案根目錄執行以下命令（請將 `${PROJECT_NAME}` 替換為實際的專案名稱）：

```bash
# macOS
find lib/feature/warehouse -type f -name "*.dart" -exec sed -i '' 's/engo_terminal_app3/${PROJECT_NAME}/g' {} +
```

## 步驟 3: 編輯 pubspec.yaml

在目標專案的 `pubspec.yaml` 檔案中進行以下修改：

### 3.1 新增 Assets

在 `flutter:` 區塊下的 `assets:` 區塊中，新增以下路徑：

```yaml
  assets:
    - lib/wh/feature/warehouse/parent/assets/images/
    - lib/wh/feature/warehouse/parent/assets/images/common/
    - lib/wh/feature/warehouse/parent/assets/images/light/
    - lib/wh/feature/warehouse/parent/assets/images/dark/
    - lib/wh/feature/warehouse/parent/assets/mock_data/response/
```

### 3.2 新增依賴項

在 `dependencies:` 區塊中，新增以下依賴項（如果尚未存在）：

```yaml
dependencies:
  flutter:
    sdk: flutter
  # ... 其他依賴項 ...
  get: ^4.7.2
  get_storage: ^2.1.1
  dio: ^5.7.0
  json_annotation: ^4.9.0
  freezed_annotation: ^2.4.4
  collection: ^1.18.0
  shimmer: ^3.0.0
  image_picker: ^1.0.7
```

### 3.3 新增開發依賴項（如需要）

如果專案中使用了 `freezed` 和 `json_serializable` 來生成程式碼，請確保在 `dev_dependencies:` 區塊中包含：

```yaml
dev_dependencies:
  # ... 其他開發依賴項 ...
  build_runner: ^2.4.9
  json_serializable: ^6.8.0
  freezed: ^2.5.2
```

## 步驟 4: 執行依賴安裝

在專案根目錄執行：

```bash
flutter pub get
```

## 步驟 5: 重新生成程式碼（如需要）

如果專案中使用了 `freezed` 和 `json_serializable`，執行以下命令重新生成程式碼：

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 步驟 6: 使用 Mock 資料（可選）

如果需要使用 mock 資料進行測試，可以使用 `WarehouseMainPageRouterData.mock()` factory 方法：

```dart
import 'package:your_project_name/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:your_project_name/feature/warehouse/service/warehouse_service.dart';

// 使用 mock 資料初始化
final mockData = WarehouseMainPageRouterData.mock();
WarehouseService.instance.updateData(mockData);
```

`mock()` factory 方法會使用 `assets/mock_data/response/home_get.json` 中的資料來建立 mock 物件。

---

## 開發環境版本

本模組在以下開發環境中開發和測試：

### Flutter & Dart SDK

- **Flutter SDK**: 3.22.2
- **Dart SDK**: ^3.4.0

### 主要依賴項

```yaml
dependencies:
  get: ^4.7.2
  get_storage: ^2.1.1
  dio: ^5.7.0
  json_annotation: ^4.9.0
  freezed_annotation: ^2.4.4
  collection: ^1.18.0
  skeletonizer: ^1.4.3
```

### 開發依賴項

```yaml
dev_dependencies:
  flutter_lints: ^4.0.0
  build_runner: ^2.4.9
  json_serializable: ^6.8.0
  freezed: ^2.5.2
```

**注意**：以上版本為開發時使用的版本，目標專案可根據實際需求調整版本號。
