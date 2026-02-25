import 'package:engo_terminal_app3/wh/feature/circuit_breaker/ui/cust_empty_widget.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/ui/first_background_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CircuitBreakerDataRecordPage extends StatefulWidget {
  const CircuitBreakerDataRecordPage({super.key});

  @override
  State<CircuitBreakerDataRecordPage> createState() => _CircuitBreakerDataRecordPageState();
}

class _CircuitBreakerDataRecordPageState extends State<CircuitBreakerDataRecordPage> {
  String _selectedTimeFilter = '日';
  DateTime _selectedDate = DateTime.now();

  List<ChartDataPoint> get _chartData {
    final data = <ChartDataPoint>[];
    if (_selectedTimeFilter == '日') {
      for (int i = 0; i < 24; i++) {
        data.add(
          ChartDataPoint(
            date: DateTime.now().subtract(Duration(hours: 23 - i)),
            value: (i * 0.5) + (i % 3) * 2.0,
          ),
        );
      }
    } else if (_selectedTimeFilter == '月') {
      for (int i = 0; i < 30; i++) {
        data.add(
          ChartDataPoint(
            date: DateTime.now().subtract(Duration(days: 29 - i)),
            value: (i * 1.2) + (i % 5) * 3.0,
          ),
        );
      }
    } else {
      for (int i = 0; i < 12; i++) {
        data.add(
          ChartDataPoint(
            date: DateTime(DateTime.now().year, i + 1),
            value: (i * 10.0) + (i % 4) * 15.0,
          ),
        );
      }
    }
    return data;
  }

  double get _totalPower {
    return _chartData.fold(0.0, (sum, item) => sum + item.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstBackgroundCard(
        child: Column(
          children: [
            _TopBar(
              onBack: () => Navigator.of(context).pop(),
              onSettings: () {},
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  children: [
                    _TimeFilter(
                      selectedFilter: _selectedTimeFilter,
                      onFilterChanged: (filter) {
                        setState(() => _selectedTimeFilter = filter);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    _StatisticsSection(
                      totalPower: _totalPower,
                      selectedDate: _selectedDate,
                      selectedTimeFilter: _selectedTimeFilter,
                      onDateTap: () => _showDatePicker(),
                    ),
                    const SizedBox(height: 20.0),
                    Expanded(
                      child: _ChartSection(
                        chartData: _chartData,
                        timeFilter: _selectedTimeFilter,
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

class ChartDataPoint {
  final DateTime date;
  final double value;

  ChartDataPoint({required this.date, required this.value});
}

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onSettings;

  const _TopBar({
    required this.onBack,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onBack,
          child: Image.asset(
            'lib/wh/feature/warehouse/parent/assets/images/common/arrow_left.png',
            width: 56.0,
            height: 56.0,
            color: const Color(0xFFFB9B51),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              '數據紀錄',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF292929),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onSettings,
          child: Image.asset(
            'lib/wh/feature/warehouse/parent/assets/images/common/setting.png',
            width: 43.4,
            height: 43.4,
            color: const Color(0xFF292929),
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
          width: 0.7,
          color: const Color(0xFFFB9B51),
        ),
        borderRadius: BorderRadius.circular(5.6),
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
          const SizedBox(width: 33.6),
          Expanded(
            child: _FilterTab(
              title: '月',
              isSelected: selectedFilter == '月',
              onTap: () => onFilterChanged('月'),
            ),
          ),
          const SizedBox(width: 33.6),
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
        padding: const EdgeInsets.all(10.5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFB9B51) : Colors.transparent,
          borderRadius: BorderRadius.circular(5.6),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 22.4,
            color: isSelected ? const Color(0xFFFFFFFF) : const Color(0xFF666666),
          ),
        ),
      ),
    );
  }
}

class _StatisticsSection extends StatelessWidget {
  final double totalPower;
  final DateTime selectedDate;
  final String selectedTimeFilter;
  final VoidCallback onDateTap;

  const _StatisticsSection({
    required this.totalPower,
    required this.selectedDate,
    required this.selectedTimeFilter,
    required this.onDateTap,
  });

  String _getDateText() {
    if (selectedTimeFilter == '日') {
      return DateFormat('yyyy/MM/dd').format(selectedDate);
    } else if (selectedTimeFilter == '月') {
      return DateFormat('yyyy/MM').format(selectedDate);
    } else {
      return DateFormat('yyyy').format(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '總用電量',
                style: TextStyle(
                  fontSize: 18.2,
                  color: Color(0xFF292929),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    totalPower.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 56.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFB9B51),
                    ),
                  ),
                  const Text(
                    ' kWh',
                    style: TextStyle(
                      fontSize: 18.2,
                      color: Color(0xFF292929),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: onDateTap,
            child: Container(
              width: 298.2,
              height: 61.6,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.8,
                vertical: 11.2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.6),
                color: const Color(0xFFFB9B51),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getDateText(),
                    style: const TextStyle(
                      fontSize: 22.4,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    'lib/wh/feature/warehouse/parent/assets/images/common/arrow_down.png',
                    width: 28.0,
                    height: 28.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartSection extends StatelessWidget {
  final List<ChartDataPoint> chartData;
  final String timeFilter;

  const _ChartSection({
    required this.chartData,
    required this.timeFilter,
  });

  @override
  Widget build(BuildContext context) {
    if (chartData.isEmpty) {
      return const Center(child: CustEmptyWidget());
    }

    final maxY = chartData.map((e) => e.value).reduce((a, b) => a > b ? a : b) * 1.2;
    final yAxisInterval = maxY / 5;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          child: Text(
            'kWh',
            style: TextStyle(
              fontSize: 16.8,
              color: Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY,
              minY: 0,
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (timeFilter == '日' && value.toInt() % 4 == 0) {
                        return Text('${value.toInt()}:00', style: const TextStyle(fontSize: 16.8));
                      } else if (timeFilter == '月' && (value.toInt() + 1) % 5 == 1) {
                        return Text('${value.toInt() + 1}', style: const TextStyle(fontSize: 16.8));
                      } else if (timeFilter == '年') {
                        return Text('${value.toInt() + 1}', style: const TextStyle(fontSize: 16.8));
                      }
                      return const SizedBox.shrink();
                    },
                    reservedSize: 28.0,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 42.0,
                    interval: yAxisInterval,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(fontSize: 16.8, color: Color(0xFF666666)),
                        textAlign: TextAlign.right,
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
                  return const FlLine(color: Color(0xFFE0E0E0), strokeWidth: 0.7);
                },
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: const Color(0xFFE0E0E0), width: 0.7),
              ),
              barGroups: List.generate(
                chartData.length,
                (index) => BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: chartData[index].value,
                      color: const Color(0xFFFB9B51),
                      width: 12.0,
                      borderRadius: BorderRadius.circular(2.8),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
