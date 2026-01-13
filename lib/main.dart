import 'package:engo_terminal_app3/service/api_service/api_service.dart';
import 'package:engo_terminal_app3/service/router_service/router_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/device_service/device_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/storage_service/storage_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _registerServices();
  runApp(const MyApp());
}

Future<void> _registerServices() async {
  LogService.register();
  final envService = EnvironmentService.register();
  envService.setModuleMode(false);
  ApiService.register(envService.apiBaseUrl);
  await StorageService.register();
  await LocaleService.register();
  ThemeService.register();
  RouterService.register();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routerService = RouterService.instance;
    final localeService = LocaleService.instance;
    final themeService = ThemeService.instance;
    DeviceService.register(context);

    // 如果設備不支援，顯示不支援頁面
    final deviceService = DeviceService.instance;
    if (!deviceService.getIsSupportedDevice) {
      return const _UnsupportedDevicePage();
    }

    return GetMaterialApp(
      navigatorKey: routerService.rootNavigatorKey,
      navigatorObservers: [routerService],
      title: '智管家',
      debugShowCheckedModeBanner: false,
      translations: localeService.getCurrentTranslation,
      locale: localeService.getCurrentLocale,
      fallbackLocale: localeService.getDefaultLocale,
      supportedLocales: localeService.getSupportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: themeService.getCurrentThemeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeService.getLightSeedColor,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeService.getDarkSeedColor,
        ),
        useMaterial3: true,
      ),
      initialRoute: routerService.initRouterPath,
      getPages: routerService.getRouterPages,
    );
  }
}

/// 不支援設備頁面
class _UnsupportedDevicePage extends StatelessWidget {
  const _UnsupportedDevicePage();

  @override
  Widget build(BuildContext context) {
    // 初始化 scale 值
    final deviceService = DeviceService.instance;
    scaleMin = deviceService.getMinScale;
    scaleWidth = deviceService.getScaleWidthValue;
    scaleHeight = deviceService.getScaleHeightValue;

    return MaterialApp(
      title: '智管家',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(EnumLocale.appTitle.tr),
          backgroundColor: Theme.of(context).colorScheme.primary,
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
                  color: Theme.of(context).colorScheme.error,
                ),
                SizedBox(height: 24.0.scale),
                Text(
                  EnumLocale.deviceUnsupported.tr,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 16.0.scale),
                Text(
                  EnumLocale.deviceUnsupportedMessage.tr,
                  style: Theme.of(context).textTheme.bodyLarge,
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
