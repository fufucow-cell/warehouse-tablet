import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/storage_service/storage_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/storage_service/storage_service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleService extends GetxService {
  // MARK: - Properties

  final _model = LocaleServiceModel();
  EnvironmentService get _envService => EnvironmentService.instance;
  StorageService get _storageService => StorageService.instance;
  LocaleTranslation get getCurrentTranslation => _model.currentTranslation;
  LocaleTranslation get getDefaultTranslation => _model.defaultTranslation;
  Locale get getCurrentLocale => _convertLocaleFromTranslation(getCurrentTranslation);
  String get getCurrentLocaleCode => _convertCodeFromLocale(getCurrentLocale);
  Locale get getDefaultLocale => _convertLocaleFromTranslation(getDefaultTranslation);
  List<LocaleTranslation> get getAvalibleLocales => LocaleServiceModel.avalibleLocales;
  static LocaleService get instance => Get.find<LocaleService>();

  // MARK: - Init

  LocaleService._internal();

  static Future<LocaleService> register() async {
    if (Get.isRegistered<LocaleService>()) {
      return Get.find<LocaleService>();
    }
    final LocaleService service = LocaleService._internal();
    Get.put<LocaleService>(service, permanent: true);
    service._readFromStorage();
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<LocaleService>()) {
      Get.delete<LocaleService>(force: true);
    }
  }

  // MARK: - Public Method

  Future<bool> switchFromTranslation(
    LocaleTranslation newTranslation,
  ) async {
    try {
      if (_model.currentTranslation.getLocale == newTranslation.getLocale) {
        return true;
      }

      final translation = _convertTranslationFromLocale(newTranslation.getLocale);

      if (_envService.getIsModuleMode) {
        _model.currentTranslation = newTranslation;
        EnumLocale.setCurrentTranslation(translation);
      } else {
        final locale = _convertLocaleFromTranslation(translation);
        await Get.updateLocale(locale);
        await _writeToStorage(newTranslation);
      }
      return true;
    } on Exception catch (e) {
      LogService.instance.e('切換語系失敗', e);
    }

    return false;
  }

  Future<bool> switchFromCode(
    String code,
  ) async =>
      switchFromTranslation(
        _convertTranslationfromCode(code),
      );

  Future<bool> switchFromLocale(
    Locale locale,
  ) async =>
      switchFromTranslation(
        _convertTranslationFromLocale(locale),
      );

  List<Locale> get getSupportedLocales {
    return LocaleServiceModel.avalibleLocales
        .map(
          (e) => e.countryCode != null ? Locale(e.languageCode, e.countryCode) : Locale(e.languageCode),
        )
        .toList();
  }

  // MARK: - Private Method

  /// 從 Storage 讀取語系
  void _readFromStorage() {
    if (_envService.getIsModuleMode) {
      return;
    }

    try {
      final String? localeCode = _storageService.read<String>(EnumStorageKey.locale);

      if (localeCode != null && localeCode.isNotEmpty) {
        final savedTranslation = _convertTranslationfromCode(localeCode);
        _model.currentTranslation = savedTranslation;
        final locale = getCurrentLocale;
        EnumLocale.setCurrentTranslation(_convertTranslationFromLocale(locale));

        if (!_envService.getIsModuleMode) {
          Get.updateLocale(locale);
        }

        LogService.instance.i(
          EnumLogType.storage,
          '從 Storage 讀取語系: ${savedTranslation.displayName}',
        );
      } else {
        // 如果沒有保存的語系，使用系統語系
        _genSystemLocale();
        LogService.instance.i(
          EnumLogType.storage,
          '使用系統語系: ${_model.currentTranslation.displayName}',
        );
      }
    } on Exception catch (e) {
      LogService.instance.e('從 Storage 讀取語系失敗', e);
      // 讀取失敗時使用系統語系
      _genSystemLocale();
    }
  }

  /// 寫入語系到 Storage
  Future<void> _writeToStorage(LocaleTranslation translation) async {
    if (_envService.getIsModuleMode) {
      return;
    }

    try {
      final localeCode = _convertCodeFromLocale(getCurrentLocale);
      await _storageService.write<String>(EnumStorageKey.locale, localeCode);
      LogService.instance.i(
        EnumLogType.storage,
        '寫入語系到 Storage: ${translation.displayName}',
      );
    } on Exception catch (e) {
      LogService.instance.e('寫入語系到 Storage 失敗', e);
    }
  }

  /// 比對系統語系
  void _genSystemLocale() {
    final deviceLocale = Get.deviceLocale;

    if (deviceLocale == null) {
      _model.currentTranslation = _model.defaultTranslation;
    } else {
      final translation = _convertTranslationFromLocale(deviceLocale);

      if (translation == EnumLocaleType.system.model) {
        _model.currentTranslation = _model.defaultTranslation;
      } else {
        _model.currentTranslation = translation;
      }
    }
  }

  String _convertCodeFromLocale(Locale locale) {
    if (locale.countryCode != null) {
      return '${locale.languageCode}_${locale.countryCode}';
    }
    return locale.languageCode;
  }

  Locale _convertLocaleFromTranslation(
    LocaleTranslation translation,
  ) {
    if (translation.getLocale == EnumLocaleType.system.model.getLocale) {
      return _model.currentTranslation.countryCode != null
          ? Locale(
              _model.currentTranslation.languageCode,
              _model.currentTranslation.countryCode,
            )
          : Locale(_model.defaultTranslation.languageCode);
    }

    return translation.countryCode != null
        ? Locale(
            translation.languageCode,
            translation.countryCode,
          )
        : Locale(translation.languageCode);
  }

  LocaleTranslation _convertTranslationFromLocale(
    Locale locale,
  ) {
    final code = _convertCodeFromLocale(locale);
    return _convertTranslationfromCode(code);
  }

  LocaleTranslation _convertTranslationfromCode(
    String? code,
  ) {
    if (code == null || code.isEmpty) {
      return EnumLocaleType.system.model;
    }

    // 處理 system 特殊值
    if (code == 'system') {
      return EnumLocaleType.system.model;
    }

    final parts = code.split('_');
    final language = parts[0];
    final country = parts.length > 1 ? parts[1] : null;
    final sameLanguage = LocaleServiceModel.avalibleLocales.where((e) => e.languageCode == language).toList();

    if (sameLanguage.isEmpty) {
      return _model.defaultTranslation;
    }

    if (country != null) {
      final matchedByCountry = sameLanguage.firstWhereOrNull(
        (e) => e.countryCode == country,
      );

      if (matchedByCountry != null) {
        return matchedByCountry;
      }
    }

    return sameLanguage.first;
  }
}
