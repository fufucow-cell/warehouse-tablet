import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locale_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/locale_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/ui/cust_scaffold.dart';
import 'package:get/get.dart';

part 'smart_home_setting_page_controller.dart';
part 'smart_home_setting_page_interactive.dart';
part 'smart_home_setting_page_model.dart';
part 'smart_home_setting_page_route.dart';

class SmartHomeSettingPage
    extends GetView<SmartHomeSettingPageController> {
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
    final controller =
        Get.find<SmartHomeSettingPageController>();
    final localeUtil = LocaleUtil.instance;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // 語言設置區塊
        _buildLanguageSection(controller, localeUtil),
      ],
    );
  }

  /// 語言設置區塊
  Widget _buildLanguageSection(
    SmartHomeSettingPageController controller,
    LocaleUtil localeUtil,
  ) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              EnumLocale.languageTitle.tr,
              style: Theme.of(Get.context!)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Divider(height: 1),
          // 系統語言選項
          _buildLanguageTile(
            controller,
            localeUtil,
            LocaleConstant.system,
            EnumLocale.languageSystem.tr,
          ),
          // 所有可用語言
          ...LocaleConstant.getAvalibleLocales.map(
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
    LocaleUtil localeUtil,
    LocaleConstant locale,
    String displayName,
  ) {
    return GetBuilder<SmartHomeSettingPageController>(
      builder: (_) {
        final isSelected =
            controller.isCurrentLocale(locale);
        return ListTile(
          title: Text(displayName),
          trailing: isSelected
              ? Icon(
                  Icons.check,
                  color: Theme.of(Get.context!)
                      .colorScheme
                      .primary,
                )
              : null,
          onTap: () => controller.switchLocale(locale),
        );
      },
    );
  }
}
