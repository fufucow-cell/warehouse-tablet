part of 'smart_home_setting_page.dart';

class SmartHomeSettingPageController extends GetxController {
  // MARK: - Properties

  final _localeService = LocaleService.instance;
  final _themeService = ThemeService.instance;

  // MARK: - Public Method

  /// 檢查是否為當前語言
  bool isCurrentLocale(LocaleTranslation translation) => _localeService.getCurrentTranslation.getLocale == translation.getLocale;

  /// 取得可用的語言
  List<LocaleTranslation> getAvailableLocales() => _localeService.getAvalibleLocales;

  /// 切換語言
  Future<void> switchLocale(
    LocaleTranslation translation,
    BuildContext? context,
  ) async {
    final success = await _localeService.switchFromTranslation(translation);
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
  bool isCurrentTheme(EnumThemeMode theme) => _themeService.currentTheme == theme;

  /// 切換主題
  Future<void> switchTheme(
    EnumThemeMode theme,
    BuildContext? context,
  ) async {
    final success = await _themeService.switchFromMode(theme);
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
