import 'package:engo_terminal_app3/wh/feature/air_conditioner/ui/first_background_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AirConditionerEnergyMonitoringPage extends StatefulWidget {
  const AirConditionerEnergyMonitoringPage({super.key});

  @override
  State<AirConditionerEnergyMonitoringPage> createState() => _AirConditionerEnergyMonitoringPageState();
}

class _AirConditionerEnergyMonitoringPageState extends State<AirConditionerEnergyMonitoringPage> {
  // Hard code values
  String selectedTimeFilter = '日'; // 日, 月, 年
  DateTime selectedDate = DateTime.now();

  Future<void> _showDatePicker() async {
    if (selectedTimeFilter == '日') {
      // 完整日期選擇
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        locale: const Locale('zh', 'TW'),
      );

      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    } else {
      // 年月選擇（月和年都使用這個模式）
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        initialDatePickerMode: DatePickerMode.year,
        locale: const Locale('zh', 'TW'),
      );

      if (picked != null) {
        setState(() {
          if (selectedTimeFilter == '月') {
            selectedDate = DateTime(picked.year, picked.month, 1);
          } else {
            selectedDate = DateTime(picked.year, 1, 1);
          }
        });
      }
    }
  }

  List<FlSpot> get chartData {
    if (selectedTimeFilter == '日') {
      // 0 ~ 23 hr (日用電量較小，範圍 0.5-4 kWh)
      return List.generate(24, (index) {
        final y = 1.5 + (index % 5) * 0.3 + (index % 3) * 0.2 + (index % 7) * 0.15;
        return FlSpot(index.toDouble(), y);
      });
    } else if (selectedTimeFilter == '月') {
      // 1 ~ 31 日 (月累積用電量中等，範圍 30-100 kWh)
      return List.generate(31, (index) {
        final y = 40.0 + (index % 7) * 5.0 + (index % 4) * 4.0 + (index % 3) * 3.0;
        return FlSpot(index.toDouble(), y);
      });
    } else {
      // 1 ~ 12 月 (年累積用電量最大，範圍 800-1500 kWh)
      return List.generate(12, (index) {
        final y = 900.0 + (index % 4) * 80.0 + (index % 3) * 60.0 + (index % 5) * 40.0;
        return FlSpot(index.toDouble(), y);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstBackgroundCard(
        child: Column(
          children: [
            const _TopBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  children: [
                    _TimeFilter(
                      selectedFilter: selectedTimeFilter,
                      onFilterChanged: (filter) {
                        setState(() {
                          selectedTimeFilter = filter;
                        });
                      },
                    ),
                    const SizedBox(height: 24.0),
                    _StatisticsSection(
                      selectedTimeFilter: selectedTimeFilter,
                      selectedDate: selectedDate,
                      onDateTap: _showDatePicker,
                    ),
                    const SizedBox(height: 24.0),
                    Expanded(
                      child: _ChartSection(
                        chartData: chartData,
                        selectedTimeFilter: selectedTimeFilter,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'lib/wh/feature/warehouse/parent/assets/images/common/arrow_left.png',
                color: const Color(0xFFFB9B51),
              ),
            ),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              '能源監測',
              style: TextStyle(
                color: Color(0xFF292929),
                fontSize: 40,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ),
        ),
        const SizedBox(width: 80),
      ],
    );
  }
}

class _TimeFilter extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const _TimeFilter({
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1.0,
            color: const Color(0xFFFB9B51),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: _FilterTab(
                title: '日',
                isSelected: selectedFilter == '日',
                onTap: () => onFilterChanged('日'),
              ),
            ),
            Expanded(
              child: _FilterTab(
                title: '月',
                isSelected: selectedFilter == '月',
                onTap: () => onFilterChanged('月'),
              ),
            ),
            Expanded(
              child: _FilterTab(
                title: '年',
                isSelected: selectedFilter == '年',
                onTap: () => onFilterChanged('年'),
              ),
            ),
          ],
        ),
      ),
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
        padding: const EdgeInsets.all(15.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFB9B51) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w400,
            color: isSelected ? Colors.white : const Color(0xFF7C7C7C),
            height: 1.2,
          ),
        ),
      ),
    );
  }
}

class _StatisticsSection extends StatelessWidget {
  final String selectedTimeFilter;
  final DateTime selectedDate;
  final VoidCallback onDateTap;

  const _StatisticsSection({
    required this.selectedTimeFilter,
    required this.selectedDate,
    required this.onDateTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50.0),
      child: Row(
        children: [
          const Spacer(),
          _DatePicker(
            selectedTimeFilter: selectedTimeFilter,
            selectedDate: selectedDate,
            onTap: onDateTap,
          ),
        ],
      ),
    );
  }
}

class _DatePicker extends StatelessWidget {
  final String selectedTimeFilter;
  final DateTime selectedDate;
  final VoidCallback onTap;

  const _DatePicker({
    required this.selectedTimeFilter,
    required this.selectedDate,
    required this.onTap,
  });

  String _getDateText() {
    if (selectedTimeFilter == '日') {
      return '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}';
    } else if (selectedTimeFilter == '月') {
      return '${selectedDate.year}/${selectedDate.month}';
    } else {
      return '${selectedDate.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 400,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFFDB874),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _getDateText(),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w400,
                color: Color(0xFF292929),
                height: 1.2,
              ),
            ),
            const Spacer(),
            Image.asset(
              'lib/wh/feature/warehouse/parent/assets/images/common/arrow_down.png',
              width: 40,
              height: 40,
              color: const Color(0xFF292929),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartSection extends StatelessWidget {
  final List<FlSpot> chartData;
  final String selectedTimeFilter;

  const _ChartSection({
    required this.chartData,
    required this.selectedTimeFilter,
  });

  @override
  Widget build(BuildContext context) {
    if (chartData.isEmpty) {
      return const Center(
        child: Text(
          '暫時沒有資料',
          style: TextStyle(
            fontSize: 26,
            color: Color(0xFF7C7C7C),
          ),
        ),
      );
    }

    final maxY = chartData.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    final yAxisMax = maxY;
    const yAxisMin = 0.0;
    final yAxisInterval = yAxisMax / 5;

    // 根據時間篩選器設定 X 軸間隔
    final xAxisInterval = selectedTimeFilter == '日'
        ? 4.0
        : selectedTimeFilter == '月'
            ? 5.0
            : 1.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.translate(
          offset: const Offset(-10, 0),
          child: const SizedBox(
            child: Text(
              'kWh',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF7C7C7C),
              ),
              textAlign: TextAlign.center,
            ),
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
                      String timeLabel = '';
                      if (selectedTimeFilter == '日') {
                        final hour = spot.x.toInt();
                        timeLabel = '${hour.toString().padLeft(2, '0')}:00 - ';
                      } else if (selectedTimeFilter == '月') {
                        final day = spot.x.toInt() + 1;
                        timeLabel = '$day日 - ';
                      } else if (selectedTimeFilter == '年') {
                        final month = spot.x.toInt() + 1;
                        timeLabel = '$month月 - ';
                      }

                      return LineTooltipItem(
                        '$timeLabel${spot.y.toStringAsFixed(2)} kWh',
                        const TextStyle(
                          color: Color(0xFF292929),
                          fontSize: 24,
                        ),
                      );
                    }).toList();
                  },
                  tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  tooltipMargin: 8,
                  getTooltipColor: (_) => Colors.white,
                  tooltipBorder: const BorderSide(color: Color(0xFF7C7C7C), width: 1),
                  tooltipRoundedRadius: 8,
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  axisNameWidget: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      selectedTimeFilter == '日'
                          ? '時:分'
                          : selectedTimeFilter == '月'
                              ? '日'
                              : '月',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color(0xFF7C7C7C),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: xAxisInterval,
                    getTitlesWidget: (value, meta) {
                      if (selectedTimeFilter == '日') {
                        final hour = value.toInt();
                        if (hour >= 0 && hour < 24 && hour % 4 == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              '${hour.toString().padLeft(2, '0')}:00',
                              style: const TextStyle(
                                fontSize: 24,
                                color: Color(0xFF7C7C7C),
                              ),
                            ),
                          );
                        }
                      } else if (selectedTimeFilter == '月') {
                        final day = value.toInt() + 1;
                        if (day >= 1 && day <= 31 && day % 5 == 1) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              day.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                color: Color(0xFF7C7C7C),
                              ),
                            ),
                          );
                        }
                      } else if (selectedTimeFilter == '年') {
                        final month = value.toInt() + 1;
                        if (month >= 1 && month <= 12) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              month.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                color: Color(0xFF7C7C7C),
                              ),
                            ),
                          );
                        }
                      }
                      return const SizedBox.shrink();
                    },
                    reservedSize: 40,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 80,
                    interval: yAxisInterval,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          value.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 24,
                            color: Color(0xFF7C7C7C),
                          ),
                          textAlign: TextAlign.right,
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
                  return const FlLine(
                    color: Color(0xFFE0E0E0),
                    strokeWidth: 1,
                  );
                },
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  left: BorderSide(color: Color(0xFF7C7C7C), width: 1),
                  bottom: BorderSide(color: Color(0xFF7C7C7C), width: 1),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: chartData,
                  isCurved: true,
                  color: const Color(0xFFFB9B51),
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 4,
                        color: const Color(0xFFFB9B51),
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                      );
                    },
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    color: const Color(0xFFFB9B51).withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
