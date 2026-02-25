import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/data_record/circuit_breaker_data_record_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/data_record/circuit_breaker_data_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/children/ui/icon_button.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/data_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_empty_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_shimmer_widget.dart' show ShimmerWidget;
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/first_background_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircuitBreakerDataRecordPage extends GetView<CircuitBreakerDataRecordPageController> {
  final CircuitBreakerDataRecordPageRouterData routerData;
  const CircuitBreakerDataRecordPage({super.key, required this.routerData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CircuitBreakerDataRecordPageController>(
      init: CircuitBreakerDataRecordPageController(routerData),
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
    final controller = Get.find<CircuitBreakerDataRecordPageController>();
    return Row(
      children: [
        CustIconButton(
          icon: EnumImage.cArrowLeft,
          size: 80.0.scale,
          color: EnumColor.engoBackgroundOrange400.color,
          onTap: () {
            controller.routerHandle(EnumCircuitBreakerDataRecordPageRoute.goBack);
          },
        ),
        Expanded(
          child: Center(
            child: CustTextWidget(
              EnumLocale.engoDataRecord.tr,
              size: 40.0.scale,
              weightType: EnumFontWeightType.bold,
              color: EnumColor.textPrimary.color,
            ),
          ),
        ),
        CustIconButton(
          icon: EnumImage.cSetting,
          size: 62.0.scale,
          color: EnumColor.engoTextPrimary.color,
          onTap: () {
            controller.interactive(EnumCircuitBreakerDataRecordPageInteractive.tapSettingButton);
          },
        ),
      ],
    );
  }
}

class _TimeFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CircuitBreakerDataRecordPageController>();
    return Obx(
      () {
        final selectedFilter = controller.selectedTimeFilterRx.value;
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
                child: _FilterTab(
                  title: EnumTimeFilter.day.title,
                  isSelected: selectedFilter == EnumTimeFilter.day,
                  onTap: () {
                    controller.interactive(
                      EnumCircuitBreakerDataRecordPageInteractive.tapTimeFilter,
                      data: EnumTimeFilter.day,
                    );
                  },
                ),
              ),
              SizedBox(width: 48.0.scale),
              Expanded(
                child: _FilterTab(
                  title: EnumTimeFilter.month.title,
                  isSelected: selectedFilter == EnumTimeFilter.month,
                  onTap: () {
                    controller.interactive(
                      EnumCircuitBreakerDataRecordPageInteractive.tapTimeFilter,
                      data: EnumTimeFilter.month,
                    );
                  },
                ),
              ),
              SizedBox(width: 48.0.scale),
              Expanded(
                child: _FilterTab(
                  title: EnumTimeFilter.year.title,
                  isSelected: selectedFilter == EnumTimeFilter.year,
                  onTap: () {
                    controller.interactive(
                      EnumCircuitBreakerDataRecordPageInteractive.tapTimeFilter,
                      data: EnumTimeFilter.year,
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
          color: isSelected ? EnumColor.textWhite.color : EnumColor.textSecondary.color,
        ),
      ),
    );
  }
}

class _StatisticsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CircuitBreakerDataRecordPageController>();
    return Obx(
      () {
        controller.selectedDateRx.value;
        controller.selectedTimeFilterRx.value;

        return SizedBox(
          height: 151.0.scale,
          child: Row(
            children: [
              _totalPowerWidget(controller.getTotalPower),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  controller.interactive(
                    EnumCircuitBreakerDataRecordPageInteractive.tapDatePicker,
                  );
                },
                child: Container(
                  width: 426.0.scale,
                  height: 88.0.scale,
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
            ],
          ),
        );
      },
    );
  }

  Widget _totalPowerWidget(String? number) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustTextWidget(
          EnumLocale.engoTotalPowerConsumption.tr,
          size: 26.0.scale,
          color: EnumColor.engoTextPrimary.color,
        ),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            if (number != null) ...[
              CustTextWidget(
                number,
                size: 80.0.scale,
                weightType: EnumFontWeightType.bold,
                color: EnumColor.textProduct.color,
              ),
              CustTextWidget(
                EnumLocale.engoKWhUnit.tr,
                size: 26.0.scale,
                color: EnumColor.engoTextPrimary.color,
              ),
            ] else
              ShimmerWidget(
                width: 80.0.scale,
                height: 80.0.scale,
              ),
          ],
        ),
      ],
    );
  }
}

class _ChartSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CircuitBreakerDataRecordPageController>();
    return Obx(
      () {
        final chartData = controller.chartDataRx.value;

        if (chartData == null || chartData.isEmpty) {
          if (chartData == null) {
            return ShimmerWidget(
              width: double.infinity,
              height: 424.0.scale,
            );
          }
          return const CustEmptyWidget();
        }

        final timeFilter = controller.selectedTimeFilterRx.value;
        final yAxisMax = controller.getMaxYAxisValue ?? 0.0;
        final yAxisInterval = yAxisMax / 5;
        final unit = EnumLocale.engoKWhUnit.tr;

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
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: yAxisMax,
                  minY: 0,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final idx = group.x.toInt();
                        if (idx < 0 || idx >= chartData.length) {
                          return BarTooltipItem(
                            '${rod.toY.toStringAsFixed(2)} $unit',
                            TextStyle(
                              color: EnumColor.textPrimary.color,
                              fontSize: 24.0.scale,
                            ),
                          );
                        }
                        final item = chartData[idx];
                        final valueStr = rod.toY.toStringAsFixed(2);
                        String dateStr = '';

                        if (timeFilter == EnumTimeFilter.day) {
                          dateStr = EnumTimeFilter.hourMinute.dateFormat.format(item.date);
                          dateStr += ' - $valueStr $unit';
                        } else if (timeFilter == EnumTimeFilter.month) {
                          dateStr = EnumTimeFilter.monthDay.dateFormat.format(item.date);
                          dateStr += ' - $valueStr $unit';
                        } else if (timeFilter == EnumTimeFilter.year) {
                          dateStr = EnumTimeFilter.yearMonth.dateFormat.format(item.date);
                          dateStr += ' - $valueStr $unit';
                        }

                        return BarTooltipItem(
                          dateStr,
                          TextStyle(
                            color: EnumColor.textPrimary.color,
                            fontSize: 24.0.scale,
                          ),
                        );
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
                          return Padding(
                            padding: EdgeInsets.only(right: 8.0.scale),
                            child: CustTextWidget(
                              value.toInt().toString(),
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
                  barGroups: controller.getBarGroups,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
