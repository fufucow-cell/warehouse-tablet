import 'package:engo_terminal_app3/wh/feature/circuit_breaker/ui/first_background_card.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/gateway_children_page.dart';
import 'package:flutter/material.dart';

class GatewayMainPage extends StatefulWidget {
  const GatewayMainPage({super.key});

  @override
  State<GatewayMainPage> createState() => _GatewayMainPageState();
}

class _GatewayMainPageState extends State<GatewayMainPage> {
  String _gatewayName = '智慧閘道器';
  final int _devicesCount = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstBackgroundCard(
        child: Column(
          children: [
            _TopBar(
              gatewayName: _gatewayName,
              onBack: () => Navigator.pop(context),
              onEdit: () {
                // Edit gateway name
              },
              onSettings: () {
                // Open settings
              },
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 602.0,
                    height: 602.0,
                    child: Image.asset(
                      'lib/wh/feature/warehouse/parent/assets/images/common/gateway_circle.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  _CenterText(devicesCount: _devicesCount),
                ],
              ),
            ),
            _BottomButton(
              devicesCount: _devicesCount,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GatewayChildrenPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 22.4),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final String gatewayName;
  final VoidCallback onBack;
  final VoidCallback onEdit;
  final VoidCallback onSettings;

  const _TopBar({
    required this.gatewayName,
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
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'lib/wh/feature/warehouse/parent/assets/images/common/arrow_left.png',
                width: 56.0,
                height: 56.0,
                color: const Color(0xFFFB9B51),
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                gatewayName,
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(width: 11.2),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onEdit,
                  customBorder: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.asset(
                      'lib/wh/feature/warehouse/parent/assets/images/common/pencil_line.png',
                      width: 35.0,
                      height: 35.0,
                      color: const Color(0xFF333333),
                    ),
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
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'lib/wh/feature/warehouse/parent/assets/images/common/setting.png',
                width: 43.4,
                height: 43.4,
                color: const Color(0xFF333333),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CenterText extends StatelessWidget {
  final int devicesCount;

  const _CenterText({required this.devicesCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '網路狀態良好',
          style: TextStyle(
            fontSize: 22.4,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 33.6),
        Text(
          '在線子裝置數: $devicesCount 台',
          style: const TextStyle(
            fontSize: 18.2,
            fontWeight: FontWeight.normal,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}

class _BottomButton extends StatelessWidget {
  final int devicesCount;
  final VoidCallback onTap;

  const _BottomButton({
    required this.devicesCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.7,
          color: const Color(0xFF999999),
        ),
        borderRadius: BorderRadius.circular(8.4),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.4),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22.4,
              vertical: 16.8,
            ),
            child: Row(
              children: [
                const Text(
                  '子裝置',
                  style: TextStyle(
                    fontSize: 22.4,
                    color: Color(0xFF333333),
                  ),
                ),
                const Spacer(),
                Text(
                  '共 $devicesCount 台',
                  style: const TextStyle(
                    fontSize: 22.4,
                    color: Color(0xFF999999),
                  ),
                ),
                const SizedBox(width: 11.2),
                Image.asset(
                  'lib/wh/feature/warehouse/parent/assets/images/common/arrow_right.png',
                  width: 31.5,
                  height: 31.5,
                  color: const Color(0xFF333333),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
