import 'package:engo_terminal_app3/wh/feature/circuit_breaker/ui/first_background_card.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/ui/device_management_bottom_sheet.dart';
import 'package:flutter/material.dart';

class GatewayChildrenPage extends StatefulWidget {
  const GatewayChildrenPage({super.key});

  @override
  State<GatewayChildrenPage> createState() => _GatewayChildrenPageState();
}

class _GatewayChildrenPageState extends State<GatewayChildrenPage> {
  final List<ChildDevice> _devices = [
    ChildDevice(
      id: '1',
      name: '客廳智慧插座',
      location: '1F 客廳',
      isSwitchOn: true,
    ),
    ChildDevice(
      id: '2',
      name: '臥室智慧燈泡',
      location: '2F 主臥',
      isSwitchOn: false,
    ),
    ChildDevice(
      id: '3',
      name: '廚房感應器',
      location: '1F 廚房',
      isSwitchOn: null,
    ),
    ChildDevice(
      id: '4',
      name: '陽台攝影機',
      location: '1F 陽台',
      isSwitchOn: true,
    ),
    ChildDevice(
      id: '5',
      name: '書房溫度計',
      location: '2F 書房',
      isSwitchOn: null,
    ),
    ChildDevice(
      id: '6',
      name: '車庫門控制器',
      location: 'B1 車庫',
      isSwitchOn: false,
    ),
  ];

  void _toggleDeviceSwitch(ChildDevice device) {
    setState(() {
      final index = _devices.indexWhere((d) => d.id == device.id);
      if (index != -1 && _devices[index].isSwitchOn != null) {
        _devices[index] = ChildDevice(
          id: device.id,
          name: device.name,
          location: device.location,
          isSwitchOn: !_devices[index].isSwitchOn!,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstBackgroundCard(
        child: Column(
          children: [
            _TopBar(
              onBack: () => Navigator.pop(context),
            ),
            const SizedBox(height: 70.0),
            Expanded(
              child: _DeviceList(
                devices: _devices,
                onToggleSwitch: _toggleDeviceSwitch,
                onDeviceMore: (device) {
                  // Handle more options
                },
              ),
            ),
            const SizedBox(height: 28.0),
            _BottomButton(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const DeviceManagementBottomSheet(),
                );
              },
            ),
            const SizedBox(height: 70.0),
          ],
        ),
      ),
    );
  }
}

class ChildDevice {
  final String id;
  final String name;
  final String? location;
  final bool? isSwitchOn;

  ChildDevice({
    required this.id,
    required this.name,
    this.location,
    this.isSwitchOn,
  });
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
        const Expanded(
          child: Center(
            child: Text(
              '子裝置',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ),
        const SizedBox(width: 56.0),
      ],
    );
  }
}

class _DeviceList extends StatelessWidget {
  final List<ChildDevice> devices;
  final Function(ChildDevice) onToggleSwitch;
  final Function(ChildDevice) onDeviceMore;

  const _DeviceList({
    required this.devices,
    required this.onToggleSwitch,
    required this.onDeviceMore,
  });

  @override
  Widget build(BuildContext context) {
    if (devices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/wh/feature/warehouse/parent/assets/images/common/empty.png',
              width: 140.0,
              height: 140.0,
            ),
            const SizedBox(height: 14.0),
            const Text(
              '尚無資料',
              style: TextStyle(
                fontSize: 22.4,
                color: Color(0xFF999999),
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(11.2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 22.4,
        mainAxisSpacing: 22.4,
        childAspectRatio: 1.7,
      ),
      itemCount: devices.length,
      itemBuilder: (context, index) => _ChildDeviceCard(
        device: devices[index],
        onToggleSwitch: () => onToggleSwitch(devices[index]),
        onMore: () => onDeviceMore(devices[index]),
      ),
    );
  }
}

class _ChildDeviceCard extends StatelessWidget {
  final ChildDevice device;
  final VoidCallback onToggleSwitch;
  final VoidCallback onMore;

  const _ChildDeviceCard({
    required this.device,
    required this.onToggleSwitch,
    required this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.4),
        border: Border.all(
          width: 2.1,
          color: Colors.white,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF5F5F5),
            Color(0xFFE8E8E8),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.8,
          vertical: 11.2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'lib/wh/feature/warehouse/parent/assets/images/common/gateway_device.png',
                  width: 86.8,
                  height: 49.0,
                  color: const Color(0xFF333333),
                ),
                const Spacer(),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onMore,
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Image.asset(
                        'lib/wh/feature/warehouse/parent/assets/images/common/gateway_more.png',
                        width: 49.0,
                        height: 49.0,
                        color: const Color(0xFF333333),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (device.location != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          device.name,
                          style: const TextStyle(
                            fontSize: 22.4,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF333333),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5.6),
                        Text(
                          device.location ?? '',
                          style: const TextStyle(
                            fontSize: 15.4,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF999999),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                else
                  Expanded(
                    child: Text(
                      device.name,
                      style: const TextStyle(
                        fontSize: 22.4,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF333333),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                if (device.isSwitchOn != null) ...[
                  const SizedBox(width: 8.0),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onToggleSwitch,
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          device.isSwitchOn!
                              ? 'lib/wh/feature/warehouse/parent/assets/images/common/gateway_status_on.png'
                              : 'lib/wh/feature/warehouse/parent/assets/images/common/gateway_status_off.png',
                          width: 49.0,
                          height: 49.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BottomButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFDB874),
      borderRadius: BorderRadius.circular(8.4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.4),
        child: Container(
          width: 420.0,
          padding: const EdgeInsets.all(
            16.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.7,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(8.4),
          ),
          child: const Center(
            child: Text(
              '裝置管理',
              style: TextStyle(
                fontSize: 22.4,
                fontWeight: FontWeight.normal,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
