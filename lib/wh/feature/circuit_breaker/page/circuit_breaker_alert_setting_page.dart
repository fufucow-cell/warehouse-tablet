import 'package:engo_terminal_app3/wh/feature/circuit_breaker/ui/cust_toggle_switch.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/ui/first_background_card.dart';
import 'package:flutter/material.dart';

class CircuitBreakerAlertSettingPage extends StatefulWidget {
  const CircuitBreakerAlertSettingPage({super.key});

  @override
  State<CircuitBreakerAlertSettingPage> createState() => _CircuitBreakerAlertSettingPageState();
}

class _CircuitBreakerAlertSettingPageState extends State<CircuitBreakerAlertSettingPage> {
  bool _overloadAlert = true;
  bool _temperatureAlert = true;
  bool _voltageAlert = false;
  double _currentThreshold = 15.0;
  double _temperatureThreshold = 60.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstBackgroundCard(
        child: Column(
          children: [
            _TopBar(onBack: () => Navigator.of(context).pop()),
            const SizedBox(height: 35.0),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                children: [
                  _SettingItem(
                    title: '過載警報',
                    value: _overloadAlert,
                    onChanged: (value) => setState(() => _overloadAlert = value),
                  ),
                  const SizedBox(height: 22.4),
                  _SettingItem(
                    title: '溫度警報',
                    value: _temperatureAlert,
                    onChanged: (value) => setState(() => _temperatureAlert = value),
                  ),
                  const SizedBox(height: 22.4),
                  _SettingItem(
                    title: '電壓異常警報',
                    value: _voltageAlert,
                    onChanged: (value) => setState(() => _voltageAlert = value),
                  ),
                  const SizedBox(height: 33.6),
                  const Text(
                    '電流門檻設定',
                    style: TextStyle(
                      fontSize: 22.4,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF292929),
                    ),
                  ),
                  const SizedBox(height: 16.8),
                  Text(
                    '${_currentThreshold.toStringAsFixed(1)} A',
                    style: const TextStyle(
                      fontSize: 28.0,
                      color: Color(0xFFFB9B51),
                    ),
                  ),
                  Slider(
                    value: _currentThreshold,
                    min: 0,
                    max: 30,
                    divisions: 60,
                    onChanged: (value) => setState(() => _currentThreshold = value),
                  ),
                  const SizedBox(height: 33.6),
                  const Text(
                    '溫度門檻設定',
                    style: TextStyle(
                      fontSize: 22.4,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF292929),
                    ),
                  ),
                  const SizedBox(height: 16.8),
                  Text(
                    '${_temperatureThreshold.toStringAsFixed(1)} °C',
                    style: const TextStyle(
                      fontSize: 28.0,
                      color: Color(0xFFFB9B51),
                    ),
                  ),
                  Slider(
                    value: _temperatureThreshold,
                    min: 30,
                    max: 80,
                    divisions: 50,
                    onChanged: (value) => setState(() => _temperatureThreshold = value),
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
  final VoidCallback onBack;

  const _TopBar({required this.onBack});

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
              '警報設定',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF292929),
              ),
            ),
          ),
        ),
        const SizedBox(width: 56.0),
      ],
    );
  }
}

class _SettingItem extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const _SettingItem({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22.4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(5.6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22.4,
              color: Color(0xFF292929),
            ),
          ),
          CustToggleSwitch(
            value: value,
            onTap: () => onChanged(!value),
          ),
        ],
      ),
    );
  }
}
