part of 'smart_home_setting_page.dart';

class SmartHomeSettingPageController extends GetxController {
  // MARK: - Properties

  final _model = SmartHomeSettingPageModel();
  final _service = SmartHomeService.instance;
  BuildContext? get getContext => _service.getContext();
  bool isCurrentLocale(LocaleTranslation translation) => _model.currentLocale?.getLocale == translation.getLocale;
  bool isCurrentTheme(EnumThemeMode theme) => _model.currentTheme == theme;
  List<LocaleTranslation> getAvailableLocales() => _service.getAvalibleLocales;

  // MARK: - Init

  SmartHomeSettingPageController() {
    _model.currentLocale = _service.getCurrentLocale;
    _model.currentTheme = _service.getCurrentTheme;
  }

  // MARK: - Public Method

  /// 切換語言
  Future<void> switchLocale(
    LocaleTranslation translation,
  ) async {
    final success = await _service.switchLocale(translation);
    _model.currentLocale = translation;

    if (success) {
      update(); // 更新 UI
      routerHandle(
        EnumSmartHomeSettingPageRoute.showSnackBar,
        data: SnackBarModel(
          title: EnumLocale.commonSuccess.tr,
          message: EnumLocale.successUpdate.tr,
        ),
      );
    } else {
      routerHandle(
        EnumSmartHomeSettingPageRoute.showSnackBar,
        data: SnackBarModel(
          title: EnumLocale.commonError.tr,
          message: EnumLocale.errorUnknown.tr,
        ),
      );
    }
  }

  /// 切換主題
  Future<void> switchTheme(
    EnumThemeMode theme,
  ) async {
    final success = await _service.switchTheme(theme);
    _model.currentTheme = theme;

    if (success) {
      update(); // 更新 UI
      routerHandle(
        EnumSmartHomeSettingPageRoute.showSnackBar,
        data: SnackBarModel(
          title: EnumLocale.commonSuccess.tr,
          message: EnumLocale.successUpdate.tr,
        ),
      );
    } else {
      routerHandle(
        EnumSmartHomeSettingPageRoute.showSnackBar,
        data: SnackBarModel(
          title: EnumLocale.commonError.tr,
          message: EnumLocale.errorUnknown.tr,
        ),
      );
    }
  }
}
