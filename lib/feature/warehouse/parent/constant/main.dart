import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/locale_util.dart';
import 'package:flutter_smart_home_tablet/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/util/api_util.dart';
import 'package:flutter_smart_home_tablet/util/device_util.dart';
import 'package:flutter_smart_home_tablet/util/environment_util.dart';
import 'package:flutter_smart_home_tablet/util/router_util.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _registerServices();
  runApp(const MyApp());
}

void _registerServices() {
  final envUtil = EnvironmentUtil.register();
  ApiUtil.register(envUtil.apiBaseUrl);
  LocaleUtil.register();
  RouterUtil.register();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routerUtil = RouterUtil.instance;
    final localeUtil = LocaleUtil.instance;
    final deviceUtil = DeviceUtil.register(context);

    // 如果設備不支援，顯示不支援頁面
    if (!deviceUtil.isSupportedDevice) {
      return const _UnsupportedDevicePage();
    }

    return GetMaterialApp(
      navigatorKey: routerUtil.rootNavigatorKey,
      navigatorObservers: [routerUtil],
      title: EnumLocale.appTitle.tr,
      debugShowCheckedModeBanner: false,
      translations: localeUtil.getDefaultTranslations,
      locale: localeUtil.getCurrentLocale,
      fallbackLocale: localeUtil.getDefaultLocale,
      supportedLocales: localeUtil.getSupportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: routerUtil.initRouterPath,
      getPages: routerUtil.getRouterPages,
    );
  }
}

/// 不支援設備頁面
class _UnsupportedDevicePage extends StatelessWidget {
  const _UnsupportedDevicePage();

  @override
  Widget build(BuildContext context) {
    final deviceUtil = DeviceUtil.instance;
    // 初始化 scale 值
    scaleMin = deviceUtil.minScale;
    scaleWidth = deviceUtil.scaleWidget;
    scaleHeight = deviceUtil.scaleWidgetHeight;

    return MaterialApp(
      title: EnumLocale.appTitle.tr,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(EnumLocale.appTitle.tr),
          backgroundColor:
              Theme.of(context).colorScheme.primary,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0.scale),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 80.0.scale,
                  color:
                      Theme.of(context).colorScheme.error,
                ),
                SizedBox(height: 24.0.scale),
                Text(
                  EnumLocale.deviceUnsupported.tr,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 16.0.scale),
                Text(
                  EnumLocale.deviceUnsupportedMessage.tr,
                  style:
                      Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
