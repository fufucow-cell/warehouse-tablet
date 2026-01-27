import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirBoxReferencePageModel {
  AirBoxReferencePageRouterData? routerData;
  BuildContext? nestedNavigatorContext;
  final selectedDataType = EnumAirBoxDataType.pm25.obs;
}

class AirBoxReferencePageRouterData {
  final String deviceName;
  final VoidCallback? onBackButtonTap;
  final VoidCallback? onSettingButtonTap;

  const AirBoxReferencePageRouterData({
    required this.deviceName,
    this.onBackButtonTap,
    this.onSettingButtonTap,
  });
}

/// 级距标准模型
class ReferenceLevel {
  final String range;
  final Color color;
  final EnumLocale statusLocale;

  const ReferenceLevel({
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
            const ReferenceLevel(
              range: '0-35',
              color: Color(0xFF40CE5F),
              statusLocale: EnumLocale.airBoxStatusGood,
            ),
            const ReferenceLevel(
              range: '36-53',
              color: Color(0xFFFFCF21),
              statusLocale: EnumLocale.airBoxStatusModerate,
            ),
            const ReferenceLevel(
              range: '54-70',
              color: Color(0xFFF88125),
              statusLocale: EnumLocale.airBoxStatusBad,
            ),
            const ReferenceLevel(
              range: '71-150',
              color: Color(0xFFEF4425),
              statusLocale: EnumLocale.airBoxStatusVeryBad,
            ),
          ],
        EnumAirBoxDataType.temperature => [
            const ReferenceLevel(
              range: '22-26',
              color: Color(0xFF40CE5F),
              statusLocale: EnumLocale.airBoxTemperatureStatusComfortable,
            ),
            const ReferenceLevel(
              range: '18-22|26-28',
              color: Color(0xFFFFCF21),
              statusLocale: EnumLocale.airBoxTemperatureStatusModerate,
            ),
            const ReferenceLevel(
              range: '16-18|28-30',
              color: Color(0xFFF88125),
              statusLocale: EnumLocale.airBoxTemperatureStatusUncomfortable,
            ),
            const ReferenceLevel(
              range: '<16|>30',
              color: Color(0xFFEF4425),
              statusLocale: EnumLocale.airBoxTemperatureStatusVeryUncomfortable,
            ),
          ],
        EnumAirBoxDataType.humidity => [
            const ReferenceLevel(
              range: '40-60',
              color: Color(0xFF40CE5F),
              statusLocale: EnumLocale.airBoxHumidityStatusGood,
            ),
            const ReferenceLevel(
              range: '30-40|60-70',
              color: Color(0xFFFFCF21),
              statusLocale: EnumLocale.airBoxHumidityStatusModerate,
            ),
            const ReferenceLevel(
              range: '20-30|70-80',
              color: Color(0xFFF88125),
              statusLocale: EnumLocale.airBoxHumidityStatusBad,
            ),
            const ReferenceLevel(
              range: '<20|>80',
              color: Color(0xFFEF4425),
              statusLocale: EnumLocale.airBoxHumidityStatusVeryBad,
            ),
          ],
        EnumAirBoxDataType.formaldehyde => [
            const ReferenceLevel(
              range: '0-0.03',
              color: Color(0xFF40CE5F),
              statusLocale: EnumLocale.airBoxStatusGood,
            ),
            const ReferenceLevel(
              range: '0.03-0.05',
              color: Color(0xFFFFCF21),
              statusLocale: EnumLocale.airBoxStatusModerate,
            ),
            const ReferenceLevel(
              range: '0.05-0.08',
              color: Color(0xFFF88125),
              statusLocale: EnumLocale.airBoxStatusBad,
            ),
            const ReferenceLevel(
              range: '>0.08',
              color: Color(0xFFEF4425),
              statusLocale: EnumLocale.airBoxStatusVeryBad,
            ),
          ],
        EnumAirBoxDataType.voc => [
            const ReferenceLevel(
              range: '0-0.3',
              color: Color(0xFF40CE5F),
              statusLocale: EnumLocale.airBoxStatusGood,
            ),
            const ReferenceLevel(
              range: '0.3-0.5',
              color: Color(0xFFFFCF21),
              statusLocale: EnumLocale.airBoxStatusModerate,
            ),
            const ReferenceLevel(
              range: '0.5-0.6',
              color: Color(0xFFF88125),
              statusLocale: EnumLocale.airBoxStatusBad,
            ),
            const ReferenceLevel(
              range: '>0.6',
              color: Color(0xFFEF4425),
              statusLocale: EnumLocale.airBoxStatusVeryBad,
            ),
          ],
        EnumAirBoxDataType.co2 => [
            const ReferenceLevel(
              range: '0-0.05',
              color: Color(0xFF40CE5F),
              statusLocale: EnumLocale.airBoxStatusGood,
            ),
            const ReferenceLevel(
              range: '0.05-0.08',
              color: Color(0xFFFFCF21),
              statusLocale: EnumLocale.airBoxStatusModerate,
            ),
            const ReferenceLevel(
              range: '0.08-0.10',
              color: Color(0xFFF88125),
              statusLocale: EnumLocale.airBoxStatusBad,
            ),
            const ReferenceLevel(
              range: '>0.10',
              color: Color(0xFFEF4425),
              statusLocale: EnumLocale.airBoxStatusVeryBad,
            ),
          ],
      };

  /// 获取级距标准
  static List<ReferenceStandard> getReferenceStandards() {
    return [
      ReferenceStandard(
        dataType: EnumAirBoxDataType.pm25,
        titleLocale: EnumLocale.airBoxReferenceTitlePm25,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionPm25,
        unit: EnumAirBoxDataType.pm25.unit,
        levels: EnumAirBoxDataType.pm25.referenceLevels,
      ),
      ReferenceStandard(
        dataType: EnumAirBoxDataType.temperature,
        titleLocale: EnumLocale.airBoxReferenceTitleTemperature,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionTemperature,
        unit: EnumAirBoxDataType.temperature.unit,
        levels: EnumAirBoxDataType.temperature.referenceLevels,
      ),
      ReferenceStandard(
        dataType: EnumAirBoxDataType.humidity,
        titleLocale: EnumLocale.airBoxReferenceTitleHumidity,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionHumidity,
        unit: EnumAirBoxDataType.humidity.unit,
        levels: EnumAirBoxDataType.humidity.referenceLevels,
      ),
      ReferenceStandard(
        dataType: EnumAirBoxDataType.formaldehyde,
        titleLocale: EnumLocale.airBoxReferenceTitleFormaldehyde,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionFormaldehyde,
        unit: EnumAirBoxDataType.formaldehyde.unit,
        levels: EnumAirBoxDataType.formaldehyde.referenceLevels,
      ),
      ReferenceStandard(
        dataType: EnumAirBoxDataType.voc,
        titleLocale: EnumLocale.airBoxReferenceTitleVoc,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionVoc,
        unit: EnumAirBoxDataType.voc.unit,
        levels: EnumAirBoxDataType.voc.referenceLevels,
      ),
      ReferenceStandard(
        dataType: EnumAirBoxDataType.co2,
        titleLocale: EnumLocale.airBoxReferenceTitleCo2,
        descriptionLocale: EnumLocale.airBoxReferenceDescriptionCo2,
        unit: EnumAirBoxDataType.co2.unit,
        levels: EnumAirBoxDataType.co2.referenceLevels,
      ),
    ];
  }
}
