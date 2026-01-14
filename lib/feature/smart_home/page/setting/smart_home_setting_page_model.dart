part of 'smart_home_setting_page.dart';

class SmartHomeSettingPageModel {
  LocaleTranslation? currentLocale;
  EnumThemeMode? currentTheme;
}

class SnackBarModel {
  String title;
  String message;

  SnackBarModel({
    required this.title,
    required this.message,
  });
}
