import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirQualityReferencePageModel {
  final selectedDataType = EnumAirQualityDataType.pm25.obs;
}

/// 级距标准模型
class ReferenceLevel {
  final String range;
  final Color color;
  final EnumLocale statusLocale;

  ReferenceLevel({
    required this.range,
    required this.color,
    required this.statusLocale,
  });
}

/// 级距标准数据
class ReferenceStandard {
  final EnumAirQualityDataType dataType;
  final EnumLocale titleLocale;
  final EnumLocale descriptionLocale;
  final String unit;
  final List<ReferenceLevel> levels;

  const ReferenceStandard({
    required this.dataType,
    required this.titleLocale,
    required this.descriptionLocale,
    required this.unit,
    required this.levels,
  });
}

/// 空氣數據
enum EnumAirQualityDataType {
  pm25,
  temperature,
  humidity,
  hcho,
  voc,
  co2;

  String get title => switch (this) {
        EnumAirQualityDataType.pm25 => EnumLocale.airBoxPm25.tr,
        EnumAirQualityDataType.temperature => EnumLocale.airBoxRecordTabTemperature.tr,
        EnumAirQualityDataType.humidity => EnumLocale.airBoxRecordTabHumidity.tr,
        EnumAirQualityDataType.hcho => EnumLocale.airBoxHCHOValue.tr,
        EnumAirQualityDataType.voc => EnumLocale.airBoxVocValue.tr,
        EnumAirQualityDataType.co2 => EnumLocale.airBoxCo2Value.tr,
      };

  /// 取得單位
  String get unit => switch (this) {
        EnumAirQualityDataType.pm25 => 'µg/m³',
        EnumAirQualityDataType.temperature => '°C',
        EnumAirQualityDataType.humidity => '%',
        EnumAirQualityDataType.hcho => 'mg/m³',
        EnumAirQualityDataType.voc => 'mg/m³',
        EnumAirQualityDataType.co2 => '%',
      };

  EnumImage get enumImage => switch (this) {
        EnumAirQualityDataType.pm25 => EnumImage.cPm25,
        EnumAirQualityDataType.temperature => EnumImage.cTemperature,
        EnumAirQualityDataType.humidity => EnumImage.cHumidity,
        EnumAirQualityDataType.hcho => EnumImage.cHcho,
        EnumAirQualityDataType.voc => EnumImage.cVoc,
        EnumAirQualityDataType.co2 => EnumImage.cCo2,
      };

  /// 是否為整數類型（用於圖表顯示）
  bool get isIntegerType => switch (this) {
        EnumAirQualityDataType.pm25 => true,
        EnumAirQualityDataType.temperature => true,
        EnumAirQualityDataType.humidity => true,
        EnumAirQualityDataType.hcho => false,
        EnumAirQualityDataType.voc => false,
        // CO2 的數值範圍是 0~0.15（%），用整數會導致縱軸刻度全部變 0
        EnumAirQualityDataType.co2 => false,
      };

  /// 顯示小數位數
  int get displayDecimal => switch (this) {
        EnumAirQualityDataType.pm25 => 1,
        EnumAirQualityDataType.temperature => 1,
        EnumAirQualityDataType.humidity => 1,
        EnumAirQualityDataType.hcho => 2,
        EnumAirQualityDataType.voc => 2,
        EnumAirQualityDataType.co2 => 2,
      };

  /// 取得預設最大值（用於圖表 Y 軸）
  double get defaultMax => switch (this) {
        EnumAirQualityDataType.pm25 => 150.0,
        EnumAirQualityDataType.temperature => 40.0,
        EnumAirQualityDataType.humidity => 100.0,
        EnumAirQualityDataType.hcho => 0.1,
        EnumAirQualityDataType.voc => 0.8,
        EnumAirQualityDataType.co2 => 0.15,
      };

  /// 取得預設最小值（用於圖表 Y 軸）
  double get defaultMin => switch (this) {
        EnumAirQualityDataType.pm25 => 0.0,
        EnumAirQualityDataType.temperature => 0.0,
        EnumAirQualityDataType.humidity => 0.0,
        EnumAirQualityDataType.hcho => 0.0,
        EnumAirQualityDataType.voc => 0.0,
        EnumAirQualityDataType.co2 => 0.0,
      };

  static EnumAirQualityDataType fromTitle(String title) {
    return EnumAirQualityDataType.values.firstWhere(
      (type) => type.title == title,
      orElse: () => EnumAirQualityDataType.values.first,
    );
  }

  /// 取得參考級距列表
  List<ReferenceLevel> get referenceLevels => switch (this) {
        EnumAirQualityDataType.pm25 => [
            ReferenceLevel(
              range: '0-35',
              color: EnumColor.airBoxStatusGood.color,
              statusLocale: EnumLocale.airBoxStatusGood,
            ),
            ReferenceLevel(
              range: '36-53',
              color: EnumColor.accentYellow.color,
              statusLocale: EnumLocale.airBoxStatusModerate,
            ),
            ReferenceLevel(
              range: '54-70',
              color: EnumColor.airBoxStatusBad.color,
              statusLocale: EnumLocale.airBoxStatusBad,
            ),
            ReferenceLevel(
              range: '71-150',
              color: EnumColor.airBoxStatusVeryBad.color,
              statusLocale: EnumLocale.airBoxStatusVeryBad,
            ),
          ],
        EnumAirQualityDataType.temperature => [
            ReferenceLevel(
              range: '<16',
              color: EnumColor.airBoxStatusVeryBad.color,
              statusLocale: EnumLocale.airBoxTemperatureStatusCold,
            ),
            ReferenceLevel(
              range: '16-20',
              color: EnumColor.accentYellow.color,
              statusLocale: EnumLocale.airBoxTemperatureStatusCool,
            ),
            ReferenceLevel(
              range: '20-26',
              color: EnumColor.airBoxStatusGood.color,
              statusLocale: EnumLocale.airBoxTemperatureStatusComfortable,
            ),
            ReferenceLevel(
              range: '26-30',
              color: EnumColor.airBoxStatusBad.color,
              statusLocale: EnumLocale.airBoxTemperatureStatusHot,
            ),
            ReferenceLevel(
              range: '>30',
              color: EnumColor.airBoxStatusVeryBad.color,
              statusLocale: EnumLocale.airBoxTemperatureStatusVeryHot,
            ),
          ],
        EnumAirQualityDataType.humidity => [
            ReferenceLevel(
              range: '<30',
              color: EnumColor.airBoxStatusBad.color,
              statusLocale: EnumLocale.airBoxHumidityStatusDry,
            ),
            ReferenceLevel(
              range: '30-50',
              color: EnumColor.airBoxStatusGood.color,
              statusLocale: EnumLocale.airBoxHumidityStatusComfortable,
            ),
            ReferenceLevel(
              range: '50-70',
              color: EnumColor.accentYellow.color,
              statusLocale: EnumLocale.airBoxHumidityStatusModerate,
            ),
            ReferenceLevel(
              range: '70-80',
              color: EnumColor.airBoxStatusBad.color,
              statusLocale: EnumLocale.airBoxHumidityStatusHumid,
            ),
            ReferenceLevel(
              range: '>80',
              color: EnumColor.airBoxStatusVeryBad.color,
              statusLocale: EnumLocale.airBoxHumidityStatusVeryHumid,
            ),
          ],
        EnumAirQualityDataType.hcho => [
            ReferenceLevel(
              range: '0-0.03',
              color: EnumColor.airBoxStatusGood.color,
              statusLocale: EnumLocale.airBoxHCHOStatusSafe,
            ),
            ReferenceLevel(
              range: '0.03-0.05',
              color: EnumColor.accentYellow.color,
              statusLocale: EnumLocale.airBoxHCHOStatusModerate,
            ),
            ReferenceLevel(
              range: '0.05-0.08',
              color: EnumColor.airBoxStatusBad.color,
              statusLocale: EnumLocale.airBoxHCHOStatusExceeded,
            ),
            ReferenceLevel(
              range: '>0.08',
              color: EnumColor.airBoxStatusVeryBad.color,
              statusLocale: EnumLocale.airBoxHCHOStatusDangerous,
            ),
          ],
        EnumAirQualityDataType.voc => [
            ReferenceLevel(
              range: '0-0.3',
              color: EnumColor.airBoxStatusGood.color,
              statusLocale: EnumLocale.airBoxVocStatusExcellent,
            ),
            ReferenceLevel(
              range: '0.3-0.5',
              color: EnumColor.accentYellow.color,
              statusLocale: EnumLocale.airBoxVocStatusAcceptable,
            ),
            ReferenceLevel(
              range: '0.5-0.6',
              color: EnumColor.airBoxStatusBad.color,
              statusLocale: EnumLocale.airBoxVocStatusPoor,
            ),
            ReferenceLevel(
              range: '>0.6',
              color: EnumColor.airBoxStatusVeryBad.color,
              statusLocale: EnumLocale.airBoxVocStatusHarmful,
            ),
          ],
        EnumAirQualityDataType.co2 => [
            ReferenceLevel(
              range: '0-0.05',
              color: EnumColor.airBoxStatusGood.color,
              statusLocale: EnumLocale.airBoxCo2StatusFresh,
            ),
            ReferenceLevel(
              range: '0.05-0.08',
              color: EnumColor.accentYellow.color,
              statusLocale: EnumLocale.airBoxCo2StatusModerate,
            ),
            ReferenceLevel(
              range: '0.08-0.10',
              color: EnumColor.airBoxStatusBad.color,
              statusLocale: EnumLocale.airBoxCo2StatusStuffy,
            ),
            ReferenceLevel(
              range: '>0.10',
              color: EnumColor.airBoxStatusVeryBad.color,
              statusLocale: EnumLocale.airBoxCo2StatusVeryStuffy,
            ),
          ],
      };

  /// 获取级距标准
  static List<ReferenceStandard> getReferenceStandards() {
    return [
      ReferenceStandard(
        dataType: EnumAirQualityDataType.pm25,
        titleLocale: EnumLocale.airBoxReferenceTitleExplainPm25,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionPm25,
        unit: EnumAirQualityDataType.pm25.unit,
        levels: EnumAirQualityDataType.pm25.referenceLevels,
      ),
      ReferenceStandard(
        dataType: EnumAirQualityDataType.temperature,
        titleLocale: EnumLocale.airBoxReferenceTitleExplainTemperature,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionTemperature,
        unit: EnumAirQualityDataType.temperature.unit,
        levels: EnumAirQualityDataType.temperature.referenceLevels,
      ),
      ReferenceStandard(
        dataType: EnumAirQualityDataType.humidity,
        titleLocale: EnumLocale.airBoxReferenceTitleExplainHumidity,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionHumidity,
        unit: EnumAirQualityDataType.humidity.unit,
        levels: EnumAirQualityDataType.humidity.referenceLevels,
      ),
      ReferenceStandard(
        dataType: EnumAirQualityDataType.hcho,
        titleLocale: EnumLocale.airBoxReferenceTitleExplainHCHO,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionHCHO,
        unit: EnumAirQualityDataType.hcho.unit,
        levels: EnumAirQualityDataType.hcho.referenceLevels,
      ),
      ReferenceStandard(
        dataType: EnumAirQualityDataType.voc,
        titleLocale: EnumLocale.airBoxReferenceTitleExplainVoc,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionVoc,
        unit: EnumAirQualityDataType.voc.unit,
        levels: EnumAirQualityDataType.voc.referenceLevels,
      ),
      ReferenceStandard(
        dataType: EnumAirQualityDataType.co2,
        titleLocale: EnumLocale.airBoxReferenceTitleExplainCo2,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionCo2,
        unit: EnumAirQualityDataType.co2.unit,
        levels: EnumAirQualityDataType.co2.referenceLevels,
      ),
    ];
  }

  /// 根據數值取得級距標準
  ReferenceLevel? getReferenceLevelByValue(double? numValue, String? strValue) {
    double? value;

    if (numValue != null) {
      value = numValue;
    } else if (strValue != null && strValue.isNotEmpty && strValue != '-') {
      value = double.tryParse(strValue.split(' ').first);
    }

    if (value == null) {
      return null;
    }

    final levels = referenceLevels;
    final finalValue = value;
    for (final level in levels) {
      if (_isValueInRange(finalValue, level.range)) {
        return level;
      }
    }
    return levels.last;
  }

  bool _isValueInRange(double value, String range) {
    if (range.contains('-')) {
      final parts = range.split('-');
      if (parts.length == 2) {
        final min = double.tryParse(parts[0]);
        final max = double.tryParse(parts[1]);
        if (min != null && max != null) {
          return value >= min && value <= max;
        }
      }
    }
    if (range.contains('|')) {
      final parts = range.split('|');
      return parts.any((part) => _isValueInRange(value, part.trim()));
    }
    if (range.startsWith('<')) {
      final max = double.tryParse(range.substring(1));
      if (max != null) {
        return value < max;
      }
    }
    if (range.startsWith('>')) {
      final min = double.tryParse(range.substring(1));
      if (min != null) {
        return value > min;
      }
    }
    return false;
  }
}

class AirQualityDataItem {
  final double? pm25;
  final double? temperature;
  final double? humidity;
  final double? hcho;
  final double? voc;
  final double? co2;

  const AirQualityDataItem({
    this.pm25,
    this.temperature,
    this.humidity,
    this.hcho,
    this.voc,
    this.co2,
  });
}
