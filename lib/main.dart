import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/device_service/device_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/environment_service/environment_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/storage_service/storage_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme_service.dart';
import 'package:flutter_smart_home_tablet/service/api_service/api_service.dart';
import 'package:flutter_smart_home_tablet/service/router_service/router_service.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _registerServices();
  runApp(const MyApp());
}

Future<void> _registerServices() async {
  // 1. 基础服务 - 最早注册，不依赖其他服务
  LogService.register();

  // 2. 环境服务 - 提供 API 基础 URL
  final envUtil = EnvironmentService.register();

  // 3. API 服务 - 依赖环境服务
  ApiService.register(envUtil.apiBaseUrl);

  // 4. 存储服务 - 异步初始化，需要先注册
  await StorageService.register();

  // 5. 本地化服务 - 依赖存储服务
  await LocaleService.register();

  // 6. 主题服务 - 依赖存储服务
  ThemeService.register();

  // 7. 路由服务 - 最后注册
  RouterService.register();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routerUtil = RouterService.instance;
    final localeUtil = LocaleService.instance;
    final themeUtil = ThemeService.instance;
    DeviceService.register(context);

    // 如果設備不支援，顯示不支援頁面
    final deviceService = DeviceService.instance;
    if (!deviceService.isSupportedDevice) {
      return const _UnsupportedDevicePage();
    }

    return GetMaterialApp(
      navigatorKey: routerUtil.rootNavigatorKey,
      navigatorObservers: [routerUtil],
      title: '智管家',
      debugShowCheckedModeBanner: false,
      translations: localeUtil.getDefaultTranslation,
      locale: localeUtil.getCurrentLocale,
      fallbackLocale: localeUtil.getDefaultLocale,
      supportedLocales: localeUtil.getSupportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: themeUtil.getCurrentThemeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeUtil.getLightSeedColor,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeUtil.getDarkSeedColor,
        ),
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
    // 初始化 scale 值
    final deviceService = DeviceService.instance;
    scaleMin = deviceService.minScale;
    scaleWidth = deviceService.scaleWidthValue;
    scaleHeight = deviceService.scaleHeightValue;

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
