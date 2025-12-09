part of 'smart_home_setting_page.dart';

class SmartHomeSettingPageController
    extends BasePageController {
  // MARK: - Properties

  final _pageModel = SmartHomeSettingPageModel();
  final _localeUtil = LocaleUtil.instance;

  // MARK: - Init

  SmartHomeSettingPageController() {
    super.init();
  }

  // MARK: - Method

  @override
  Future<void> apiProcessing() async {}

  /// 檢查是否為當前語言
  bool isCurrentLocale(LocaleConstant locale) {
    return _localeUtil.currentSelectedLocale == locale;
  }

  /// 切換語言
  Future<void> switchLocale(LocaleConstant locale) async {
    final success =
        await _localeUtil.switchFromLocale(locale);
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
