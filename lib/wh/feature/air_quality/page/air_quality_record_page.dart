import 'package:engo_terminal_app3/wh/feature/air_quality/page/air_quality_reference_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/ui/air_background_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AirQualityRecordPage extends StatefulWidget {
  const AirQualityRecordPage({super.key});

  @override
  State<AirQualityRecordPage> createState() => _AirQualityRecordPageState();
}

class _AirQualityRecordPageState extends State<AirQualityRecordPage> {
  String _selectedTimeFilter = '日';
  String _selectedDataType = 'PM2.5';
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AirBackgroundCard(
        child: Column(
          children: [
            _TopBar(
              onBack: () => Navigator.pop(context),
              onHelp: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AirQualityReferencePage(),
                  ),
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  children: [
                    _TimeFilter(
                      selectedFilter: _selectedTimeFilter,
                      onFilterChanged: (filter) {
                        setState(() {
                          _selectedTimeFilter = filter;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    _StatisticsSection(
                      selectedDataType: _selectedDataType,
                      selectedDate: _selectedDate,
                      selectedTimeFilter: _selectedTimeFilter,
                      onDataTypeChanged: (type) {
                        setState(() {
                          _selectedDataType = type;
                        });
                      },
                      onDateTap: () => _showDatePicker(),
                    ),
                    const SizedBox(height: 48),
                    Expanded(
                      child: _ChartSection(
                        selectedTimeFilter: _selectedTimeFilter,
                        selectedDate: _selectedDate,
                        selectedDataType: _selectedDataType,
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

  Future<void> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDatePickerMode: _selectedTimeFilter == '日' ? DatePickerMode.day : DatePickerMode.year,
    );

    if (picked != null) {
      setState(() {
        if (_selectedTimeFilter == '日') {
          _selectedDate = picked;
        } else if (_selectedTimeFilter == '月') {
          _selectedDate = DateTime(picked.year, picked.month, 1);
        } else {
          _selectedDate = DateTime(picked.year, 1, 1);
        }
      });
    }
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onHelp;

  const _TopBar({required this.onBack, required this.onHelp});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onBack,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'lib/wh/feature/warehouse/parent/assets/images/common/arrow_left.png',
                width: 40,
                height: 40,
                color: const Color(0xFFFDB874),
              ),
            ),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              '資料紀錄',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onHelp,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'lib/wh/feature/warehouse/parent/assets/images/common/help.png',
                width: 35,
                height: 35,
                color: Colors.lightBlue,
              ),
            ),
          ),
        ),
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: const Color(0xFFFDB874),
        ),
        borderRadius: BorderRadius.circular(8),
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
          const SizedBox(width: 48),
          Expanded(
            child: _FilterTab(
              title: '月',
              isSelected: selectedFilter == '月',
              onTap: () => onFilterChanged('月'),
            ),
          ),
          const SizedBox(width: 48),
          Expanded(
            child: _FilterTab(
              title: '年',
              isSelected: selectedFilter == '年',
              onTap: () => onFilterChanged('年'),
            ),
          ),
        ],
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
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFDB874) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 26,
            color: isSelected ? Colors.white : const Color(0xFF7C7C7C),
          ),
        ),
      ),
    );
  }
}

class _StatisticsSection extends StatelessWidget {
  final String selectedDataType;
  final DateTime selectedDate;
  final String selectedTimeFilter;
  final Function(String) onDataTypeChanged;
  final VoidCallback onDateTap;

  const _StatisticsSection({
    required this.selectedDataType,
    required this.selectedDate,
    required this.selectedTimeFilter,
    required this.onDataTypeChanged,
    required this.onDateTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          const Spacer(),
          _DatePicker(
            selectedDate: selectedDate,
            selectedTimeFilter: selectedTimeFilter,
            onTap: onDateTap,
          ),
        ],
      ),
    );
  }
}

class _DatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedTimeFilter;
  final VoidCallback onTap;

  const _DatePicker({
    required this.selectedDate,
    required this.selectedTimeFilter,
    required this.onTap,
  });

  String _getDateText() {
    if (selectedTimeFilter == '日') {
      return DateFormat('yyyy-MM-dd').format(selectedDate);
    } else if (selectedTimeFilter == '月') {
      return DateFormat('yyyy-MM').format(selectedDate);
    } else {
      return DateFormat('yyyy').format(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 380,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
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
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Image.asset(
              'lib/wh/feature/warehouse/parent/assets/images/common/arrow_down.png',
              width: 40,
              height: 40,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartSection extends StatelessWidget {
  final String selectedTimeFilter;
  final DateTime selectedDate;
  final String selectedDataType;

  const _ChartSection({
    required this.selectedTimeFilter,
    required this.selectedDate,
    required this.selectedDataType,
  });

  List<FlSpot> get _chartData {
    if (selectedTimeFilter == '日') {
      return List.generate(24, (i) {
        final value = 10 + (i % 5) * 3.0 + (i / 24) * 5;
        return FlSpot(i.toDouble(), value);
      });
    } else if (selectedTimeFilter == '月') {
      return List.generate(31, (i) {
        final value = 50 + (i % 7) * 10.0 + (i / 31) * 30;
        return FlSpot(i.toDouble(), value);
      });
    } else {
      return List.generate(12, (i) {
        final value = 200 + (i % 4) * 50.0 + (i / 12) * 100;
        return FlSpot(i.toDouble(), value);
      });
    }
  }

  double get _maxYValue {
    return _chartData.map((e) => e.y).reduce((a, b) => a > b ? a : b);
  }

  double get _xAxisInterval {
    return selectedTimeFilter == '日'
        ? 4.0
        : selectedTimeFilter == '月'
            ? 5.0
            : 1.0;
  }

  @override
  Widget build(BuildContext context) {
    final yAxisMax = _maxYValue;
    const yAxisMin = 0.0;
    final yAxisInterval = (yAxisMax - yAxisMin) / 5;
    const unit = 'μg/m³';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.translate(
          offset: const Offset(-10, 0),
          child: const SizedBox(
            child: Text(
              unit,
              style: TextStyle(fontSize: 24, color: Color(0xFF7C7C7C)),
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
                      String timeStr = '';
                      if (selectedTimeFilter == '日') {
                        timeStr = '${spot.x.toInt().toString().padLeft(2, '0')}:00';
                      } else if (selectedTimeFilter == '月') {
                        timeStr = '${(spot.x.toInt() + 1)}日';
                      } else {
                        timeStr = '${(spot.x.toInt() + 1)}月';
                      }
                      return LineTooltipItem(
                        '$timeStr - ${spot.y.toStringAsFixed(2)} $unit',
                        const TextStyle(color: Colors.white, fontSize: 24),
                      );
                    }).toList();
                  },
                  tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  tooltipMargin: 8,
                  getTooltipColor: (_) => const Color(0xFF2A2A2A),
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
                      style: const TextStyle(fontSize: 24, color: Color(0xFF7C7C7C)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: _xAxisInterval,
                    getTitlesWidget: (value, meta) {
                      if (selectedTimeFilter == '日') {
                        final hour = value.toInt();
                        if (hour >= 0 && hour < 24 && hour % 4 == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              '${hour.toString().padLeft(2, '0')}:00',
                              style: const TextStyle(fontSize: 24, color: Color(0xFF7C7C7C)),
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
                              style: const TextStyle(fontSize: 24, color: Color(0xFF7C7C7C)),
                            ),
                          );
                        }
                      } else {
                        final month = value.toInt() + 1;
                        if (month >= 1 && month <= 12) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              month.toString(),
                              style: const TextStyle(fontSize: 24, color: Color(0xFF7C7C7C)),
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
                    reservedSize: 100,
                    interval: yAxisInterval,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          value.toStringAsFixed(2),
                          style: const TextStyle(fontSize: 24, color: Color(0xFF7C7C7C)),
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
                    color: Color(0xFF3A3A3A),
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
                  spots: _chartData,
                  isCurved: true,
                  color: const Color(0xFF5DADE2),
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: const Color(0xFF5DADE2).withOpacity(0.2),
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
