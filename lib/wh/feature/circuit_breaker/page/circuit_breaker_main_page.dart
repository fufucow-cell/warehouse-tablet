import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/circuit_breaker_alert_setting_page.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/circuit_breaker_data_record_page.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/circuit_breaker_notification_record_page.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/ui/first_background_card.dart';
import 'package:flutter/material.dart';

class CircuitBreakerMainPage extends StatefulWidget {
  const CircuitBreakerMainPage({super.key});

  @override
  State<CircuitBreakerMainPage> createState() => _CircuitBreakerMainPageState();
}

class _CircuitBreakerMainPageState extends State<CircuitBreakerMainPage> {
  final String _title = '無熔絲開關';
  bool _isSwitchOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstBackgroundCard(
        child: Column(
          children: [
            _TopBar(
              title: _title,
              onBack: () {},
              onEdit: () {},
              onSettings: () {},
            ),
            const SizedBox(height: 50.4),
            _SwitchControl(
              isOn: _isSwitchOn,
              onToggle: () {
                setState(() => _isSwitchOn = !_isSwitchOn);
              },
            ),
            const SizedBox(height: 50.4),
            Expanded(
              child: Column(
                children: [
                  const _StatisticsCard(),
                  const SizedBox(height: 33.6),
                  Expanded(
                    child: _DataRecordSection(
                      onDataRecordTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CircuitBreakerDataRecordPage(),
                          ),
                        );
                      },
                      onNotificationRecordTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CircuitBreakerNotificationRecordPage(),
                          ),
                        );
                      },
                      onAlertSettingTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CircuitBreakerAlertSettingPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
        GestureDetector(
          onTap: onBack,
          child: Image.asset(
            'lib/wh/parent/assets/images/common/arrow_left.png',
            width: 56.0,
            height: 56.0,
            color: const Color(0xFFFB9B51),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF292929),
                ),
              ),
              const SizedBox(width: 11.2),
              GestureDetector(
                onTap: onEdit,
                child: Image.asset(
                  'lib/wh/parent/assets/images/common/pencil_line.png',
                  width: 35.0,
                  height: 35.0,
                  color: const Color(0xFF292929),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onSettings,
          child: Image.asset(
            'lib/wh/parent/assets/images/common/setting.png',
            width: 43.4,
            height: 43.4,
            color: const Color(0xFF292929),
          ),
        ),
      ],
    );
  }
}

class _SwitchControl extends StatelessWidget {
  final bool isOn;
  final VoidCallback onToggle;

  const _SwitchControl({
    required this.isOn,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 116.2,
          height: 331.1,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xF0EEEEEE), Color(0xF0FBBB84)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(5.6),
                    border: Border.all(
                      width: 0.7,
                      color: const Color(0xFFFB9B51),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                top: isOn ? 0.0 : 154.7,
                child: GestureDetector(
                  onTap: onToggle,
                  child: Padding(
                    padding: const EdgeInsets.all(12.6),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: 93.1,
                      height: 151.2,
                      decoration: BoxDecoration(
                        color: isOn
                            ? const Color(0xFFFB9B51)
                            : const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(5.6),
                      ),
                      child: Center(
                        child: TweenAnimationBuilder<Color?>(
                          duration: const Duration(milliseconds: 300),
                          tween: ColorTween(
                            begin: isOn
                                ? const Color(0xFFFB9B51)
                                : const Color(0xFF292929),
                            end: isOn
                                ? const Color(0xFF292929)
                                : const Color(0xFFFB9B51),
                          ),
                          builder: (context, color, child) {
                            return Image.asset(
                              'lib/wh/parent/assets/images/common/circuit.png',
                              width: 63.7,
                              height: 63.7,
                              color: color ?? const Color(0xFF292929),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.8),
        const Text(
          '開關',
          style: TextStyle(
            fontSize: 22.4,
            color: Color(0xFF292929),
          ),
        ),
      ],
    );
  }
}

class _StatisticsCard extends StatelessWidget {
  const _StatisticsCard();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StatisticsItem(
          title: '目前溫度',
          value: '25.6°C',
          isFirst: true,
        ),
        _DividerLine(),
        _StatisticsItem(
          title: '累計用電量',
          value: '1234 kWh',
        ),
        _DividerLine(),
        _StatisticsItem(
          title: '今日用電量',
          value: '12.5 kWh',
        ),
        _DividerLine(),
        _StatisticsItem(
          title: '功率',
          value: '2.3 kW',
        ),
        _DividerLine(),
        _StatisticsItem(
          title: '電壓',
          value: '220 V',
        ),
        _DividerLine(),
        _StatisticsItem(
          title: '電流',
          value: '10.5 A',
        ),
      ],
    );
  }
}

class _StatisticsItem extends StatelessWidget {
  final String title;
  final String value;
  final bool isFirst;

  const _StatisticsItem({
    required this.title,
    required this.value,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19.6,
            color: Color(0xFF292929),
          ),
        ),
        if (isFirst || value != '-') ...[
          const SizedBox(height: 5.6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22.4,
              fontWeight: FontWeight.bold,
              color: Color(0xFF96B7E3),
            ),
          ),
        ],
      ],
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 0.7,
      height: 56.0,
      color: const Color(0xFFE0E0E0),
    );
  }
}

class _DataRecordSection extends StatelessWidget {
  final VoidCallback onDataRecordTap;
  final VoidCallback onNotificationRecordTap;
  final VoidCallback onAlertSettingTap;

  const _DataRecordSection({
    required this.onDataRecordTap,
    required this.onNotificationRecordTap,
    required this.onAlertSettingTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _DataRecordItem(
          title: '數據紀錄',
          onTap: onDataRecordTap,
        ),
        const SizedBox(height: 16.8),
        _DataRecordItem(
          title: '通知紀錄',
          onTap: onNotificationRecordTap,
        ),
        const SizedBox(height: 16.8),
        _DataRecordItem(
          title: '警報設定',
          onTap: onAlertSettingTap,
        ),
      ],
    );
  }
}

class _DataRecordItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _DataRecordItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.4),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 22.4,
            vertical: 16.8,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.7,
              color: const Color(0xFF666666),
            ),
            borderRadius: BorderRadius.circular(8.4),
          ),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22.4,
                  color: Color(0xFF292929),
                ),
              ),
              const Spacer(),
              Image.asset(
                'lib/wh/parent/assets/images/common/arrow_right.png',
                width: 40.6,
                height: 40.6,
                color: const Color(0xFF292929),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
