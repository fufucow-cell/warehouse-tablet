part of 'smart_home_setting_page.dart';

enum EnumSmartHomeSettingPageInteractive {
  tapLocale,
  tapTheme,
}

extension SmartHomeSettingPageUserEventExtension on SmartHomeSettingPageController {
  void interactive(
    EnumSmartHomeSettingPageInteractive type, {
    BuildContext? context,
    dynamic data,
  }) {
    switch (type) {
      case EnumSmartHomeSettingPageInteractive.tapLocale:
        if (data is LocaleTranslation) {
          switchLocale(data, context);
        }
      case EnumSmartHomeSettingPageInteractive.tapTheme:
        if (data is EnumThemeMode) {
          switchTheme(data, context);
        }
    }
  }
}
