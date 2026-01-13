part of 'smart_home_setting_page.dart';

class SmartHomeSettingPageController extends GetxController {
  // MARK: - Properties

  final _localeUtil = LocaleService.instance;
  final _themeUtil = ThemeService.instance;

  // MARK: - Method

  /// 檢查是否為當前語言
  bool isCurrentLocale(LocaleTranslation translation) => _localeUtil.currentTranslation == translation;

  /// 切換語言
  Future<void> switchLocale(
    LocaleTranslation translation,
    BuildContext? context,
  ) async {
    final success = await _localeUtil.switchFromTranslation(translation);
    if (success) {
      update(); // 更新 UI
      routerHandle(
        EnumSmartHomeSettingPageRoute.showSnackBar,
        data: {
          'title': EnumLocale.commonSuccess.tr,
          'message': EnumLocale.successUpdate.tr,
          'context': context,
        },
      );
    } else {
      routerHandle(
        EnumSmartHomeSettingPageRoute.showSnackBar,
        data: {
          'title': EnumLocale.commonError.tr,
          'message': EnumLocale.errorUnknown.tr,
          'context': context,
        },
      );
    }
  }

  /// 檢查是否為當前主題
  bool isCurrentTheme(EnumThemeMode theme) => _themeUtil.currentTheme == theme;

  /// 切換主題
  Future<void> switchTheme(
    EnumThemeMode theme,
    BuildContext? context,
  ) async {
    final success = await _themeUtil.switchFromMode(theme);
    if (success) {
      update(); // 更新 UI
      routerHandle(
        EnumSmartHomeSettingPageRoute.showSnackBar,
        data: {
          'title': EnumLocale.commonSuccess.tr,
          'message': EnumLocale.successUpdate.tr,
          'context': context,
        },
      );
    } else {
      routerHandle(
        EnumSmartHomeSettingPageRoute.showSnackBar,
        data: {
          'title': EnumLocale.commonError.tr,
          'message': EnumLocale.errorUnknown.tr,
          'context': context,
        },
      );
    }
  }
}
