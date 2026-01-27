import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirBoxReferencePageModel {
  final selectedDataType = EnumAirBoxDataType.pm25.obs;
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
  final EnumAirBoxDataType dataType;
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
enum EnumAirBoxDataType {
  pm25,
  temperature,
  humidity,
  formaldehyde,
  voc,
  co2;

  String get title => switch (this) {
        EnumAirBoxDataType.pm25 => EnumLocale.airBoxPm25.tr,
        EnumAirBoxDataType.temperature => EnumLocale.airBoxRecordTabTemperature.tr,
        EnumAirBoxDataType.humidity => EnumLocale.airBoxRecordTabHumidity.tr,
        EnumAirBoxDataType.formaldehyde => EnumLocale.airBoxFormaldehydeValue.tr,
        EnumAirBoxDataType.voc => EnumLocale.airBoxVocValue.tr,
        EnumAirBoxDataType.co2 => EnumLocale.airBoxCo2Value.tr,
      };

  /// 取得單位
  String get unit => switch (this) {
        EnumAirBoxDataType.pm25 => 'µg/m³',
        EnumAirBoxDataType.temperature => '°C',
        EnumAirBoxDataType.humidity => '%',
        EnumAirBoxDataType.formaldehyde => 'mg/m³',
        EnumAirBoxDataType.voc => 'mg/m³',
        EnumAirBoxDataType.co2 => '%',
      };

  /// 是否為整數類型（用於圖表顯示）
  bool get isIntegerType => switch (this) {
        EnumAirBoxDataType.pm25 => true,
        EnumAirBoxDataType.temperature => true,
        EnumAirBoxDataType.humidity => true,
        EnumAirBoxDataType.formaldehyde => false,
        EnumAirBoxDataType.voc => false,
        EnumAirBoxDataType.co2 => true,
      };

  /// 取得預設最大值（用於圖表 Y 軸）
  double get defaultMax => switch (this) {
        EnumAirBoxDataType.pm25 => 150.0,
        EnumAirBoxDataType.temperature => 40.0,
        EnumAirBoxDataType.humidity => 100.0,
        EnumAirBoxDataType.formaldehyde => 0.1,
        EnumAirBoxDataType.voc => 0.6,
        EnumAirBoxDataType.co2 => 0.15,
      };

  /// 取得預設最小值（用於圖表 Y 軸）
  double get defaultMin => switch (this) {
        EnumAirBoxDataType.pm25 => 0.0,
        EnumAirBoxDataType.temperature => 0.0,
        EnumAirBoxDataType.humidity => 0.0,
        EnumAirBoxDataType.formaldehyde => 0.0,
        EnumAirBoxDataType.voc => 0.0,
        EnumAirBoxDataType.co2 => 0.0,
      };

  static EnumAirBoxDataType fromTitle(String title) {
    return EnumAirBoxDataType.values.firstWhere(
      (type) => type.title == title,
      orElse: () => EnumAirBoxDataType.values.first,
    );
  }

  /// 取得參考級距列表
  List<ReferenceLevel> get referenceLevels => switch (this) {
        EnumAirBoxDataType.pm25 => [
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
        EnumAirBoxDataType.temperature => [
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
        EnumAirBoxDataType.humidity => [
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
        EnumAirBoxDataType.formaldehyde => [
            ReferenceLevel(
              range: '0-0.03',
              color: EnumColor.airBoxStatusGood.color,
              statusLocale: EnumLocale.airBoxFormaldehydeStatusSafe,
            ),
            ReferenceLevel(
              range: '0.03-0.05',
              color: EnumColor.accentYellow.color,
              statusLocale: EnumLocale.airBoxFormaldehydeStatusModerate,
            ),
            ReferenceLevel(
              range: '0.05-0.08',
              color: EnumColor.airBoxStatusBad.color,
              statusLocale: EnumLocale.airBoxFormaldehydeStatusExceeded,
            ),
            ReferenceLevel(
              range: '>0.08',
              color: EnumColor.airBoxStatusVeryBad.color,
              statusLocale: EnumLocale.airBoxFormaldehydeStatusDangerous,
            ),
          ],
        EnumAirBoxDataType.voc => [
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
        EnumAirBoxDataType.co2 => [
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
        dataType: EnumAirBoxDataType.pm25,
        titleLocale: EnumLocale.airBoxReferenceTitleExplainPm25,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionPm25,
        unit: EnumAirBoxDataType.pm25.unit,
        levels: EnumAirBoxDataType.pm25.referenceLevels,
      ),
      ReferenceStandard(
        dataType: EnumAirBoxDataType.temperature,
        titleLocale: EnumLocale.airBoxReferenceTitleExplainTemperature,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionTemperature,
        unit: EnumAirBoxDataType.temperature.unit,
        levels: EnumAirBoxDataType.temperature.referenceLevels,
      ),
      ReferenceStandard(
        dataType: EnumAirBoxDataType.humidity,
        titleLocale: EnumLocale.airBoxReferenceTitleExplainHumidity,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionHumidity,
        unit: EnumAirBoxDataType.humidity.unit,
        levels: EnumAirBoxDataType.humidity.referenceLevels,
      ),
      ReferenceStandard(
        dataType: EnumAirBoxDataType.formaldehyde,
        titleLocale: EnumLocale.airBoxReferenceTitleExplainFormaldehyde,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionFormaldehyde,
        unit: EnumAirBoxDataType.formaldehyde.unit,
        levels: EnumAirBoxDataType.formaldehyde.referenceLevels,
      ),
      ReferenceStandard(
        dataType: EnumAirBoxDataType.voc,
        titleLocale: EnumLocale.airBoxReferenceTitleExplainVoc,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionVoc,
        unit: EnumAirBoxDataType.voc.unit,
        levels: EnumAirBoxDataType.voc.referenceLevels,
      ),
      ReferenceStandard(
        dataType: EnumAirBoxDataType.co2,
        titleLocale: EnumLocale.airBoxReferenceTitleExplainCo2,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionCo2,
        unit: EnumAirBoxDataType.co2.unit,
        levels: EnumAirBoxDataType.co2.referenceLevels,
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
