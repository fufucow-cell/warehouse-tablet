part of 'smart_home_setting_page.dart';

class SmartHomeSettingPageController extends BasePageController {
  // MARK: - Properties

  final _localeUtil = LocaleUtil.instance;
  final _themeUtil = ThemeUtil.instance;

  // MARK: - Init

  SmartHomeSettingPageController() {
    super.init();
  }

  // MARK: - Method

  @override
  Future<void> apiProcessing() async {}

  /// 檢查是否為當前語言
  bool isCurrentLocale(LocaleTranslation translation) =>
      _localeUtil.currentTranslation == translation;

  /// 切換語言
  Future<void> switchLocale(
    LocaleTranslation translation,
  ) async {
    final success = await _localeUtil.switchFromTranslation(translation);
    if (success) {
      update(); // 更新 UI
      Get.snackbar(
        EnumLocale.commonSuccess.tr,
        EnumLocale.successUpdate.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        EnumLocale.commonError.tr,
        EnumLocale.errorUnknown.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// 檢查是否為當前主題
  bool isCurrentTheme(EnumThemeMode theme) => _themeUtil.currentTheme == theme;

  /// 切換主題
  Future<void> switchTheme(
    EnumThemeMode theme,
  ) async {
    final success = await _themeUtil.switchFromMode(theme);
    if (success) {
      update(); // 更新 UI
      Get.snackbar(
        EnumLocale.commonSuccess.tr,
        EnumLocale.successUpdate.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        EnumLocale.commonError.tr,
        EnumLocale.errorUnknown.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
