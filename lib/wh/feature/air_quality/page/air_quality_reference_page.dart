import 'package:engo_terminal_app3/wh/feature/air_quality/ui/air_background_card.dart';
import 'package:flutter/material.dart';

class AirQualityReferencePage extends StatefulWidget {
  const AirQualityReferencePage({super.key});

  @override
  State<AirQualityReferencePage> createState() => _AirQualityReferencePageState();
}

class _AirQualityReferencePageState extends State<AirQualityReferencePage> {
  String _selectedDataType = 'PM2.5';
  final List<String> _dataTypes = ['PM2.5', '溫度', '濕度', 'HCHO', 'VOC', 'CO2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AirBackgroundCard(
        child: Column(
          children: [
            _TopBar(onBack: () => Navigator.pop(context)),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _ParameterSelector(
                      selectedDataType: _selectedDataType,
                      dataTypes: _dataTypes,
                      onValueSelected: (value) {
                        setState(() {
                          _selectedDataType = value;
                        });
                      },
                    ),
                    const SizedBox(height: 48),
                    _ParameterInfo(dataType: _selectedDataType),
                    const SizedBox(height: 48),
                    _LevelList(dataType: _selectedDataType),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;

  const _TopBar({required this.onBack});

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
              '參考標準',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(width: 80),
      ],
    );
  }
}

class _ParameterSelector extends StatelessWidget {
  final String selectedDataType;
  final List<String> dataTypes;
  final Function(String) onValueSelected;

  const _ParameterSelector({
    required this.selectedDataType,
    required this.dataTypes,
    required this.onValueSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onValueSelected,
      itemBuilder: (context) {
        return dataTypes.map((type) {
          return PopupMenuItem<String>(
            value: type,
            child: Text(type, style: const TextStyle(fontSize: 28)),
          );
        }).toList();
      },
      child: Container(
        width: 480,
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFDB874),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDataType,
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.white, size: 40),
          ],
        ),
      ),
    );
  }
}

class _ParameterInfo extends StatelessWidget {
  final String dataType;

  const _ParameterInfo({required this.dataType});

  Map<String, dynamic> _getDataTypeInfo() {
    switch (dataType) {
      case 'PM2.5':
        return {
          'title': 'PM2.5 細懸浮微粒',
          'description': '指懸浮在空氣中粒徑小於或等於2.5微米的粒子。',
          'icon': 'lib/wh/feature/warehouse/parent/assets/images/common/pm25.png',
        };
      case '溫度':
        return {
          'title': '溫度',
          'description': '環境溫度測量。',
          'icon': 'lib/wh/feature/warehouse/parent/assets/images/common/temperature.png',
        };
      case '濕度':
        return {
          'title': '濕度',
          'description': '環境相對濕度測量。',
          'icon': 'lib/wh/feature/warehouse/parent/assets/images/common/humidity.png',
        };
      case 'HCHO':
        return {
          'title': 'HCHO 甲醛',
          'description': '甲醛濃度測量。',
          'icon': 'lib/wh/feature/warehouse/parent/assets/images/common/hcho.png',
        };
      case 'VOC':
        return {
          'title': 'VOC 揮發性有機化合物',
          'description': 'VOC濃度測量。',
          'icon': 'lib/wh/feature/warehouse/parent/assets/images/common/voc.png',
        };
      case 'CO2':
        return {
          'title': 'CO2 二氧化碳',
          'description': '二氧化碳濃度測量。',
          'icon': 'lib/wh/feature/warehouse/parent/assets/images/common/co2.png',
        };
      default:
        return {
          'title': dataType,
          'description': '',
          'icon': 'lib/wh/feature/warehouse/parent/assets/images/common/pm25.png',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = _getDataTypeInfo();
    return SizedBox(
      width: 768,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                info['icon'] as String,
                width: 42,
                height: 42,
                color: Colors.black,
              ),
              const SizedBox(width: 16),
              Text(
                info['title'] as String,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 768,
            child: Text(
              info['description'] as String,
              style: const TextStyle(
                fontSize: 26,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelList extends StatelessWidget {
  final String dataType;

  const _LevelList({required this.dataType});

  List<Map<String, dynamic>> _getLevels() {
    switch (dataType) {
      case 'PM2.5':
        return [
          {'range': '0 - 15', 'status': '良好', 'color': const Color(0xFF4CAF50)},
          {'range': '16 - 35', 'status': '普通', 'color': const Color(0xFFFFC107)},
          {'range': '36 - 54', 'status': '對敏感族群不健康', 'color': const Color(0xFFFF9800)},
          {'range': '55 - 150', 'status': '不健康', 'color': const Color(0xFFF44336)},
          {'range': '151 - 250', 'status': '非常不健康', 'color': const Color(0xFF9C27B0)},
          {'range': '>250', 'status': '危害', 'color': const Color(0xFF880E4F)},
        ];
      case '溫度':
        return [
          {'range': '< 18°C', 'status': '偏冷', 'color': const Color(0xFF2196F3)},
          {'range': '18 - 26°C', 'status': '舒適', 'color': const Color(0xFF4CAF50)},
          {'range': '> 26°C', 'status': '偏熱', 'color': const Color(0xFFF44336)},
        ];
      case '濕度':
        return [
          {'range': '< 40%', 'status': '乾燥', 'color': const Color(0xFFFFC107)},
          {'range': '40 - 60%', 'status': '舒適', 'color': const Color(0xFF4CAF50)},
          {'range': '> 60%', 'status': '潮濕', 'color': const Color(0xFF2196F3)},
        ];
      case 'CO₂':
        return [
          {'range': '< 600 ppm', 'status': '良好', 'color': const Color(0xFF4CAF50)},
          {'range': '600 - 1000 ppm', 'status': '普通', 'color': const Color(0xFFFFC107)},
          {'range': '> 1000 ppm', 'status': '不佳', 'color': const Color(0xFFF44336)},
        ];
      default:
        return [
          {'range': '低', 'status': '良好', 'color': const Color(0xFF4CAF50)},
          {'range': '中', 'status': '普通', 'color': const Color(0xFFFFC107)},
          {'range': '高', 'status': '不佳', 'color': const Color(0xFFF44336)},
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final levels = _getLevels();
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 683),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: levels
            .map(
              (level) => _LevelItem(
                range: level['range'] as String,
                status: level['status'] as String,
                color: level['color'] as Color,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _LevelItem extends StatelessWidget {
  final String range;
  final String status;
  final Color color;

  const _LevelItem({
    required this.range,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 33,
                    height: 33,
                    decoration: ShapeDecoration(
                      color: color,
                      shape: const OvalBorder(),
                    ),
                  ),
                  const SizedBox(width: 48),
                  Text(
                    range,
                    style: const TextStyle(fontSize: 32, color: Colors.black),
                  ),
                ],
              ),
              Text(
                status,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.black,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
