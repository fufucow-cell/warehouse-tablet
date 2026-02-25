import 'package:flutter/material.dart';

class SensorDataBar extends StatelessWidget {
  final List<Map<String, double?>> datas;

  const SensorDataBar({
    super.key,
    required this.datas,
  });

  String _getTitle(Map<String, double?> data) {
    final key = data.keys.first;
    return key;
  }

  String _getValue(Map<String, double?> data) {
    final value = data.values.first;
    if (value == null) {
      return '-';
    }
    return value.toStringAsFixed(1);
  }

  Widget _getImage(Map<String, double?> data) {
    final key = data.keys.first;
    switch (key) {
      case '溫度':
        return Image.asset('lib/wh/feature/warehouse/parent/assets/images/common/temperature.png');
      case '濕度':
        return Image.asset('lib/wh/feature/warehouse/parent/assets/images/common/humidity.png');
      case 'CO2':
        return Image.asset('lib/wh/feature/warehouse/parent/assets/images/common/co2.png');
      case 'PM25':
        return Image.asset('lib/wh/feature/warehouse/parent/assets/images/common/pm25.png');
      case 'HCHO':
        return Image.asset('lib/wh/feature/warehouse/parent/assets/images/common/hcho.png');
      case 'VOC':
        return Image.asset('lib/wh/feature/warehouse/parent/assets/images/common/voc.png');
      default:
        return const SizedBox.shrink();
    }
  }

  String _getUnit(Map<String, double?> data) {
    final key = data.keys.first;
    switch (key) {
      case '溫度':
        return '°C';
      case '濕度':
        return '%';
      case 'CO2':
        return 'ppm';
      case 'PM25':
        return 'μg/m³';
      case 'HCHO':
        return 'mg/m³';
      case 'VOC':
        return 'ppb';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    for (int i = 0; i < datas.length; i++) {
      final mapValue = datas[i];

      if (i > 0) {
        widgets.add(const _Divider());
      }

      widgets.add(
        _DataItem(
          title: _getTitle(mapValue),
          image: _getImage(mapValue),
          value: _getValue(mapValue),
          unit: _getUnit(mapValue),
        ),
      );
    }

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          center: Alignment.topCenter,
          radius: 15,
          colors: [Color(0x99FFFFFF), Color(0x00FBBB84)],
        ),
        border: Border.all(width: 1, color: const Color(0xFFFB9B51)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        child: Row(
          children: [const SizedBox(width: 32), ...widgets, const SizedBox(width: 32)],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 65),
      width: 1,
      height: 75,
      color: Colors.black,
    );
  }
}

class _DataItem extends StatelessWidget {
  final String title;
  final Widget image;
  final String value;
  final String unit;

  const _DataItem({
    required this.title,
    required this.image,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: image,
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '$value $unit',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF96B7E3),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
