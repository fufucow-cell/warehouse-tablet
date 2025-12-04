part of 'smart_home_message_page.dart';

enum EnumSmartHomeMessagePageInteractive {
  tapSomeWidget,
}

extension SmartHomeMessagePageUserEventExtension
    on SmartHomeMessagePageController {
  void interactive(EnumSmartHomeMessagePageInteractive type,
      {dynamic data}) {
    switch (type) {
      case EnumSmartHomeMessagePageInteractive.tapSomeWidget:
        break;
    }
  }
}
