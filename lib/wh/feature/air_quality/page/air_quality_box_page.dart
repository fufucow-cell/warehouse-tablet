import 'package:engo_terminal_app3/wh/feature/air_quality/page/air_quality_record_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/ui/air_background_card.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/ui/sensor_data_bar.dart';
import 'package:flutter/material.dart';

class AirQualityBoxPage extends StatefulWidget {
  const AirQualityBoxPage({super.key});

  @override
  State<AirQualityBoxPage> createState() => _AirQualityBoxPageState();
}

class _AirQualityBoxPageState extends State<AirQualityBoxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AirBackgroundCard(
        isBox: true,
        child: Column(
          children: [
            _TopBar(
              title: '空氣盒',
              onBack: () {},
              onEdit: () {},
              onSettings: () {},
            ),
            const SizedBox(height: 8),
            const Text(
              '客廳',
              style: TextStyle(fontSize: 26, color: Colors.black),
            ),
            const _MainDisplay(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SensorDataBar(
                      datas: [
                        {'溫度': 24.5},
                        {'濕度': 55.0},
                        {'HCHO': 0.05},
                        {'VOC': 250.0},
                        {'CO2': 650.0},
                      ],
                    ),
                    const SizedBox(height: 20),
                    _DataRecordSection(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AirQualityRecordPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
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
  final String title;
  final VoidCallback onBack;
  final VoidCallback onEdit;
  final VoidCallback onSettings;

  const _TopBar({
    required this.title,
    required this.onBack,
    required this.onEdit,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onBack,
            child: Image.asset(
              'lib/wh/parent/assets/images/common/arrow_left.png',
              width: 40,
              height: 40,
              color: const Color(0xFFFDB874),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 16),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onEdit,
                  child: Image.asset(
                    'lib/wh/parent/assets/images/common/pencil_line.png',
                    width: 30,
                    height: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onSettings,
            child: Image.asset(
              'lib/wh/parent/assets/images/common/setting.png',
              width: 30,
              height: 30,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }
}

class _MainDisplay extends StatelessWidget {
  const _MainDisplay();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/wh/parent/assets/images/common/pm25.png',
                width: 50,
                height: 50,
                color: const Color(0xFF41CF5F),
              ),
              const SizedBox(width: 20),
              const Text(
                'PM2.5',
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFF41CF5F),
                ),
              ),
            ],
          ),
          const Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '12.5',
                style: TextStyle(
                  fontSize: 120,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF96B7E3),
                ),
              ),
              SizedBox(width: 14),
              Text(
                '良好',
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFF96B7E3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DataRecordSection extends StatelessWidget {
  final VoidCallback onTap;

  const _DataRecordSection({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: const Color(0xFF7C7C7C),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  '資料紀錄',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Image.asset(
                'lib/wh/parent/assets/images/common/arrow_right.png',
                width: 30,
                height: 30,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
