import 'package:engo_terminal_app3/wh/feature/circuit_breaker/ui/cust_toggle_switch.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/ui/first_background_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CircuitBreakerAlertSettingPage extends StatefulWidget {
  const CircuitBreakerAlertSettingPage({super.key});

  @override
  State<CircuitBreakerAlertSettingPage> createState() => _CircuitBreakerAlertSettingPageState();
}

class _CircuitBreakerAlertSettingPageState extends State<CircuitBreakerAlertSettingPage> {
  final List<AlertSettingItem> _settings = [
    AlertSettingItem(
      title: '高溫',
      unit: '°C',
      valueController: TextEditingController(text: '60.0'),
      alertStatus: true,
      circuitStatus: false,
    ),
    AlertSettingItem(
      title: '高功率',
      unit: 'W',
      valueController: TextEditingController(text: '2000.0'),
      alertStatus: true,
      circuitStatus: true,
    ),
    AlertSettingItem(
      title: '過電流',
      unit: 'A',
      valueController: TextEditingController(text: '15.0'),
      alertStatus: true,
      circuitStatus: true,
    ),
    AlertSettingItem(
      title: '110V 過壓警報',
      unit: 'V',
      valueController: TextEditingController(text: '125.0'),
      alertStatus: false,
      circuitStatus: false,
    ),
    AlertSettingItem(
      title: '220V 過壓警報',
      unit: 'V',
      valueController: TextEditingController(text: '240.0'),
      alertStatus: false,
      circuitStatus: true,
    ),
    AlertSettingItem(
      title: '110V 欠壓警報',
      unit: 'V',
      valueController: TextEditingController(text: '95.0'),
      alertStatus: false,
      circuitStatus: false,
    ),
    AlertSettingItem(
      title: '220V 欠壓警報',
      unit: 'V',
      valueController: TextEditingController(text: '200.0'),
      alertStatus: false,
      circuitStatus: false,
    ),
  ];

  @override
  void dispose() {
    for (var setting in _settings) {
      setting.valueController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstBackgroundCard(
        child: Column(
          children: [
            _TopBar(onBack: () => Navigator.of(context).pop()),
            const SizedBox(height: 12.6),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 22.4),
                itemCount: _settings.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.8),
                    child: _AlertSettingCard(
                      item: _settings[index],
                      onAlertStatusChanged: (value) {
                        setState(() => _settings[index].alertStatus = value);
                      },
                      onCircuitStatusChanged: (value) {
                        setState(() => _settings[index].circuitStatus = value);
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12.6),
            _RemoveDeviceButton(
              onTap: () {},
            ),
            const SizedBox(height: 12.6),
          ],
        ),
      ),
    );
  }
}

class AlertSettingItem {
  final String title;
  final String unit;
  final TextEditingController valueController;
  bool alertStatus;
  bool circuitStatus;

  AlertSettingItem({
    required this.title,
    required this.unit,
    required this.valueController,
    required this.alertStatus,
    required this.circuitStatus,
  });
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

class _AlertSettingCard extends StatelessWidget {
  final AlertSettingItem item;
  final Function(bool) onAlertStatusChanged;
  final Function(bool) onCircuitStatusChanged;

  const _AlertSettingCard({
    required this.item,
    required this.onAlertStatusChanged,
    required this.onCircuitStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.8,
        vertical: 22.4,
      ),
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          center: Alignment.topLeft,
          radius: 1.5,
          colors: [Color(0x99FFFFFF), Color(0x00FBBB84)],
        ),
        border: Border.all(
          width: 0.7,
          color: const Color(0xFFFB9B51),
        ),
        borderRadius: BorderRadius.circular(8.4),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 264.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 22.4,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF292929),
                  ),
                ),
                const SizedBox(height: 11.2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '設定值',
                      style: TextStyle(
                        fontSize: 18.2,
                        color: Color(0xFF292929),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 135.8,
                          child: TextField(
                            controller: item.valueController,
                            style: const TextStyle(
                              fontSize: 18.2,
                              color: Color(0xFFFB9B51),
                            ),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 9.8,
                                vertical: 12.6,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.2),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE0E0E0),
                                  width: 0.7,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.2),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE0E0E0),
                                  width: 0.7,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.2),
                                borderSide: const BorderSide(
                                  color: Color(0xFFFB9B51),
                                  width: 0.7,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 11.2),
                        Text(
                          item.unit,
                          style: const TextStyle(
                            fontSize: 18.2,
                            color: Color(0xFF292929),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 89.6),
          Row(
            children: [
              const Text(
                '發送警報',
                style: TextStyle(
                  fontSize: 18.2,
                  color: Color(0xFF292929),
                ),
              ),
              const SizedBox(width: 11.2),
              CustToggleSwitch(
                value: item.alertStatus,
                onTap: () => onAlertStatusChanged(!item.alertStatus),
              ),
            ],
          ),
          const SizedBox(width: 89.6),
          Row(
            children: [
              const Text(
                '斷路器跳閘',
                style: TextStyle(
                  fontSize: 18.2,
                  color: Color(0xFF292929),
                ),
              ),
              const SizedBox(width: 11.2),
              CustToggleSwitch(
                value: item.circuitStatus,
                onTap: () => onCircuitStatusChanged(!item.circuitStatus),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RemoveDeviceButton extends StatelessWidget {
  final VoidCallback onTap;

  const _RemoveDeviceButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 420.0,
        padding: const EdgeInsets.symmetric(vertical: 16.8),
        decoration: BoxDecoration(
          color: const Color(0xFFFDB874),
          borderRadius: BorderRadius.circular(8.4),
          border: Border.all(
            width: 0.7,
            color: Colors.black,
          ),
        ),
        child: const Center(
          child: Text(
            '移除裝置',
            style: TextStyle(
              fontSize: 22.4,
              color: Color(0xFF292929),
            ),
          ),
        ),
      ),
    );
  }
}
