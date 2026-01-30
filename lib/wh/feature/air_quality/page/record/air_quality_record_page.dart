import 'package:engo_terminal_app3/wh/feature/air_quality/page/record/air_quality_record_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/record/air_quality_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/reference/air_quality_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/children/ui/icon_button.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/data_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_dropdown_menu_button.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_empty_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_shimmer_widget.dart' show ShimmerWidget;
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/first_background_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirQualityRecordPage extends GetView<AirQualityRecordPageController> {
  final AirQualityRecordPageRouterData routerData;
  const AirQualityRecordPage({super.key, required this.routerData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirQualityRecordPageController>(
      init: AirQualityRecordPageController(routerData),
      builder: (controller) {
        return Scaffold(
          body: FirstBackgroundCard(
            child: Column(
              children: [
                _TopBar(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(50.0.scale),
                    child: Column(
                      children: [
                        _TimeFilter(),
                        SizedBox(height: 48.0.scale),
                        _StatisticsSection(),
                        SizedBox(height: 48.0.scale),
                        Expanded(child: _ChartSection()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityRecordPageController>();
    return Row(
      children: [
        CustIconButton(
          icon: EnumImage.cArrowLeft,
          size: 80.0.scale,
          color: EnumColor.engoBackgroundOrange400.color,
          onTap: () {
            controller.interactive(EnumAirQualityRecordPageInteractive.tapBackButton);
          },
        ),
        Expanded(
          child: Center(
            child: CustTextWidget(
              EnumLocale.airBoxDataRecord.tr,
              size: 40.0.scale,
              weightType: EnumFontWeightType.bold,
              color: EnumColor.textPrimary.color,
            ),
          ),
        ),
        CustIconButton(
          icon: EnumImage.cHelp,
          size: 62.0.scale,
          color: EnumColor.engoTextPrimary.color,
          onTap: () {
            controller.interactive(EnumAirQualityRecordPageInteractive.tapHelpButton);
          },
        ),
      ],
    );
  }
}

class _TimeFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityRecordPageController>();
    const eDay = EnumTimeFilter.day;
    const eMonth = EnumTimeFilter.month;
    const eYear = EnumTimeFilter.year;
    return Obx(
      () {
        final selectedFilter = controller.selectedTimeFilterRx.value;
        return Container(
          decoration: BoxDecoration(
            color: EnumColor.engoTabBarBackground.color,
            border: Border.all(
              width: 1.0.scale,
              color: EnumColor.engoButtonBorderReverse.color,
            ),
            borderRadius: BorderRadius.circular(8.0.scale),
          ),
          child: Row(
            children: [
              Expanded(
                child: _FilterTab(
                  title: eDay.title,
                  isSelected: selectedFilter == eDay,
                  onTap: () {
                    controller.interactive(
                      EnumAirQualityRecordPageInteractive.tapTimeFilter,
                      data: eDay,
                    );
                  },
                ),
              ),
              SizedBox(width: 48.0.scale),
              Expanded(
                child: _FilterTab(
                  title: eMonth.title,
                  isSelected: selectedFilter == eMonth,
                  onTap: () {
                    controller.interactive(
                      EnumAirQualityRecordPageInteractive.tapTimeFilter,
                      data: eMonth,
                    );
                  },
                ),
              ),
              SizedBox(width: 48.0.scale),
              Expanded(
                child: _FilterTab(
                  title: eYear.title,
                  isSelected: selectedFilter == eYear,
                  onTap: () {
                    controller.interactive(
                      EnumAirQualityRecordPageInteractive.tapTimeFilter,
                      data: eYear,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterTab({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.0.scale),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? EnumColor.engoBackgroundOrange400.color : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0.scale),
        ),
        child: CustTextWidget(
          title,
          size: 32.0.scale,
          weightType: EnumFontWeightType.regular,
          color: isSelected ? EnumColor.engoTextPrimary.color : EnumColor.engoTextSecondary.color,
        ),
      ),
    );
  }
}

class _StatisticsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityRecordPageController>();
    return Obx(
      () {
        controller.selectedDateRx.value;
        controller.selectedDataTypeRx.value;
        final selectedType = controller.selectedDataTypeRx.value;
        final options = controller.dataTypeList.map((e) => e.title).toList();

        return Container(
          padding: EdgeInsets.symmetric(vertical: 32.0.scale),
          child: Row(
            children: [
              CustDropdownMenuButton.popupMenuButton(
                width: 480.0.scale,
                height: 80.0.scale,
                selectedValue: selectedType.title,
                values: options,
                onValueSelected: (value) {
                  controller.interactive(
                    EnumAirQualityRecordPageInteractive.tapDataTypeFilter,
                    data: value,
                  );
                },
                fontSize: 32.0.scale,
                buttonTextColor: EnumColor.textPrimary.color,
              ),
              const Spacer(),
              _DatePicker(),
            ],
          ),
        );
      },
    );
  }
}

class _DataTypeFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityRecordPageController>();
    return Obx(
      () {
        final selectedType = controller.selectedDataTypeRx.value;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1.0.scale,
              color: EnumColor.engoButtonBorderReverse.color,
            ),
            borderRadius: BorderRadius.circular(8.0.scale),
          ),
          child: Row(
            children: [
              Expanded(
                child: _DataTypeTab(
                  title: EnumLocale.airBoxRecordTabTemperature.tr,
                  isSelected: selectedType == EnumAirQualityDataType.temperature,
                  onTap: () {
                    controller.interactive(
                      EnumAirQualityRecordPageInteractive.tapDataTypeFilter,
                      data: EnumAirQualityDataType.temperature,
                    );
                  },
                ),
              ),
              SizedBox(width: 48.0.scale),
              Expanded(
                child: _DataTypeTab(
                  title: EnumLocale.airBoxRecordTabHumidity.tr,
                  isSelected: selectedType == EnumAirQualityDataType.humidity,
                  onTap: () {
                    controller.interactive(
                      EnumAirQualityRecordPageInteractive.tapDataTypeFilter,
                      data: EnumAirQualityDataType.humidity,
                    );
                  },
                ),
              ),
              SizedBox(width: 48.0.scale),
              Expanded(
                child: _DataTypeTab(
                  title: EnumLocale.airBoxRecordTabPm25.tr,
                  isSelected: selectedType == EnumAirQualityDataType.pm25,
                  onTap: () {
                    controller.interactive(
                      EnumAirQualityRecordPageInteractive.tapDataTypeFilter,
                      data: EnumAirQualityDataType.pm25,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DataTypeTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _DataTypeTab({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.0.scale),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? EnumColor.engoBackgroundOrange400.color : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0.scale),
        ),
        child: CustTextWidget(
          title,
          size: 32.0.scale,
          weightType: EnumFontWeightType.regular,
          color: isSelected ? EnumColor.textWhite.color : EnumColor.textSecondary.color,
        ),
      ),
    );
  }
}

class _DatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityRecordPageController>();
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.interactive(EnumAirQualityRecordPageInteractive.tapDatePicker);
        },
        child: Container(
          width: 480.0.scale,
          height: 80.0.scale,
          padding: EdgeInsets.symmetric(
            horizontal: 24.0.scale,
            vertical: 16.0.scale,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0.scale),
            color: EnumColor.engoBackgroundButton.color,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustTextWidget(
                controller.getDateText,
                size: 32.0.scale,
                weightType: EnumFontWeightType.regular,
                color: EnumColor.textPrimary.color,
              ),
              const Spacer(),
              EnumImage.cArrowDown.image(
                size: Size.square(40.0.scale),
                color: EnumColor.textPrimary.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChartSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityRecordPageController>();
    return Obx(
      () {
        final chartData = controller.chartDataRx.value;

        if (chartData == null) {
          return ShimmerWidget(
            width: double.infinity,
            height: 424.0.scale,
          );
        }

        if (chartData.isEmpty) {
          return const CustEmptyWidget();
        }

        final timeFilter = controller.selectedTimeFilterRx.value;
        final dataType = controller.selectedDataTypeRx.value;
        final yAxisMax = controller.getMaxYAxisValue;
        final yAxisMin = controller.getMinYAxisValue;
        final yAxisInterval = (yAxisMax - yAxisMin) / 5;
        final unit = controller.getUnit;
        // 橫軸以整數為單位：日=每4小時、月=每5天、年=每1月
        final xAxisInterval = timeFilter == EnumTimeFilter.day
            ? 4.0
            : timeFilter == EnumTimeFilter.month
                ? 5.0
                : 1.0;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: CustTextWidget(
                unit,
                size: 24.0.scale,
                color: EnumColor.textSecondary.color,
                align: TextAlign.center,
              ),
            ),
            Expanded(
              child: LineChart(
                LineChartData(
                  maxY: yAxisMax,
                  minY: yAxisMin,
                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final idx = spot.x.toInt();
                          if (idx < 0 || idx >= chartData.length) {
                            return LineTooltipItem(
                              '${spot.y.toStringAsFixed(dataType.isIntegerType ? 0 : 2)} $unit',
                              TextStyle(
                                color: EnumColor.textPrimary.color,
                                fontSize: 24.0.scale,
                              ),
                            );
                          }
                          final item = chartData[idx];
                          final valueStr = dataType.isIntegerType ? item.number.toInt().toString() : item.number.toStringAsFixed(2);
                          String dateStr = '';

                          if (timeFilter == EnumTimeFilter.day) {
                            dateStr = EnumTimeFilter.hourMinute.dateFormat.format(item.date);
                            dateStr += ' - $valueStr $unit';
                          } else if (timeFilter == EnumTimeFilter.month) {
                            const timeUnit = EnumTimeFilter.day;
                            dateStr = timeUnit.dateFormat.format(item.date);
                            dateStr += '${timeUnit.title} - $valueStr $unit';
                          } else if (timeFilter == EnumTimeFilter.year) {
                            const timeUnit = EnumTimeFilter.month;
                            dateStr = timeUnit.dateFormat.format(item.date);
                            dateStr += '${timeUnit.title} - $valueStr $unit';
                          }

                          return LineTooltipItem(
                            dateStr,
                            TextStyle(
                              color: EnumColor.textPrimary.color,
                              fontSize: 24.0.scale,
                            ),
                          );
                        }).toList();
                      },
                      tooltipPadding: EdgeInsets.symmetric(horizontal: 12.0.scale, vertical: 8.0.scale),
                      tooltipMargin: 8.0.scale,
                      getTooltipColor: (_) => EnumColor.backgroundPrimary.color,
                      tooltipBorder: BorderSide(color: EnumColor.lineBorder.color, width: 1.0.scale),
                      tooltipRoundedRadius: 8.0.scale,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      axisNameWidget: Padding(
                        padding: EdgeInsets.only(top: 8.0.scale),
                        child: CustTextWidget(
                          timeFilter == EnumTimeFilter.day
                              ? EnumTimeFilter.hourMinute.title
                              : timeFilter == EnumTimeFilter.month
                                  ? EnumTimeFilter.day.title
                                  : EnumTimeFilter.month.title,
                          size: 24.0.scale,
                          color: EnumColor.textSecondary.color,
                          align: TextAlign.center,
                        ),
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: xAxisInterval,
                        getTitlesWidget: (value, meta) {
                          if (timeFilter == EnumTimeFilter.day) {
                            final hour = value.toInt();
                            if (hour >= 0 && hour < 24 && hour % 4 == 0) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8.0.scale),
                                child: CustTextWidget(
                                  '${hour.toString().padLeft(2, '0')}:00',
                                  size: 24.0.scale,
                                  color: EnumColor.textSecondary.color,
                                ),
                              );
                            }
                          } else if (timeFilter == EnumTimeFilter.month) {
                            final day = value.toInt() + 1;
                            if (day >= 1 && day <= 31 && day % 5 == 1) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8.0.scale),
                                child: CustTextWidget(
                                  day.toString(),
                                  size: 24.0.scale,
                                  color: EnumColor.textSecondary.color,
                                ),
                              );
                            }
                          } else if (timeFilter == EnumTimeFilter.year) {
                            final month = value.toInt() + 1;
                            if (month >= 1 && month <= 12) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8.0.scale),
                                child: CustTextWidget(
                                  month.toString(),
                                  size: 24.0.scale,
                                  color: EnumColor.textSecondary.color,
                                ),
                              );
                            }
                          }

                          return const SizedBox.shrink();
                        },
                        reservedSize: 40.0.scale,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60.0.scale,
                        interval: yAxisInterval,
                        getTitlesWidget: (value, meta) {
                          // 根據數據類型決定小數位數
                          final displayValue = dataType.isIntegerType ? value.toInt().toString() : value.toStringAsFixed(2);
                          return Padding(
                            padding: EdgeInsets.only(right: 8.0.scale),
                            child: CustTextWidget(
                              displayValue,
                              size: 24.0.scale,
                              color: EnumColor.textSecondary.color,
                              align: TextAlign.right,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: yAxisInterval,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: EnumColor.lineDivider.color,
                        strokeWidth: 1.0.scale,
                      );
                    },
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: EnumColor.lineBorder.color,
                      width: 1.0.scale,
                    ),
                  ),
                  lineBarsData: controller.getLineChartBars,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
