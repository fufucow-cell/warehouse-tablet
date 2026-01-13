import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale_service_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme_service_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/cust_snack_bar.dart';
import 'package:flutter_smart_home_tablet/ui/cust_scaffold.dart';
import 'package:get/get.dart';

part 'smart_home_setting_page_controller.dart';
part 'smart_home_setting_page_interactive.dart';
part 'smart_home_setting_page_model.dart';
part 'smart_home_setting_page_route.dart';

class SmartHomeSettingPage extends GetView<SmartHomeSettingPageController> {
  const SmartHomeSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeSettingPageController>(
      init: SmartHomeSettingPageController(),
      builder: (controller) {
        return CustScaffold(
          title: EnumLocale.settingTitle.tr,
          showBackButton: false,
          child: _Body(),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SmartHomeSettingPageController>();
    final localeUtil = LocaleService.instance;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // 語言設置區塊
        _buildLanguageSection(controller, localeUtil),
        const SizedBox(height: 16),
        // 主題設置區塊
        _buildThemeSection(controller),
      ],
    );
  }

  /// 語言設置區塊
  Widget _buildLanguageSection(
    SmartHomeSettingPageController controller,
    LocaleService localeUtil,
  ) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              EnumLocale.languageTitle.tr,
              style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Divider(height: 1),
          // 系統語言選項
          _buildLanguageTile(
            controller,
            localeUtil,
            LocaleTranslation.system,
            EnumLocale.languageSystem.tr,
          ),
          // 所有可用語言
          ...LocaleTranslation.getAvalibleLocales.map(
            (locale) => _buildLanguageTile(
              controller,
              localeUtil,
              locale,
              locale.displayName,
            ),
          ),
        ],
      ),
    );
  }

  /// 語言選項 Tile
  Widget _buildLanguageTile(
    SmartHomeSettingPageController controller,
    LocaleService localeUtil,
    LocaleTranslation locale,
    String displayName,
  ) {
    return GetBuilder<SmartHomeSettingPageController>(
      builder: (_) {
        final isSelected = controller.isCurrentLocale(locale);
        return Builder(
          builder: (context) => ListTile(
            title: Text(displayName),
            trailing: isSelected
                ? Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : null,
            onTap: () => controller.interactive(
              EnumSmartHomeSettingPageInteractive.tapLocale,
              context: context,
              data: locale,
            ),
          ),
        );
      },
    );
  }

  /// 主題設置區塊
  Widget _buildThemeSection(
    SmartHomeSettingPageController controller,
  ) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '主題設定',
              style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Divider(height: 1),
          // 所有可用主題模式
          ...EnumThemeMode.values.map(
            (theme) => _buildThemeTile(
              controller,
              theme,
            ),
          ),
        ],
      ),
    );
  }

  /// 主題選項 Tile
  Widget _buildThemeTile(
    SmartHomeSettingPageController controller,
    EnumThemeMode theme,
  ) {
    return GetBuilder<SmartHomeSettingPageController>(
      builder: (_) {
        final isSelected = controller.isCurrentTheme(theme);
        return Builder(
          builder: (context) => ListTile(
            title: Text(theme.displayName),
            trailing: isSelected
                ? Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : null,
            onTap: () => controller.interactive(
              EnumSmartHomeSettingPageInteractive.tapTheme,
              context: context,
              data: theme,
            ),
          ),
        );
      },
    );
  }
}
