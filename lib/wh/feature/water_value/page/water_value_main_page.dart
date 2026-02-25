import 'package:engo_terminal_app3/wh/feature/warehouse/ui/first_background_card.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/water_value_timer_list_page.dart';
import 'package:flutter/material.dart';

class WaterValueMainPage extends StatefulWidget {
  const WaterValueMainPage({super.key});

  @override
  State<WaterValueMainPage> createState() => _WaterValueMainPageState();
}

class _WaterValueMainPageState extends State<WaterValueMainPage> {
  final String _title = '水閥';
  bool _isSwitchOn = false;

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
              onToggle: (value) {
                setState(() => _isSwitchOn = value);
              },
            ),
            const SizedBox(height: 89.6),
            _FunctionCards(
              onTimerTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WaterValueTimerListPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 50.4),
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
            'lib/wh/feature/warehouse/parent/assets/images/common/arrow_left.png',
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
                  'lib/wh/feature/warehouse/parent/assets/images/common/pencil_line.png',
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

class _SwitchControl extends StatelessWidget {
  final bool isOn;
  final Function(bool) onToggle;

  const _SwitchControl({
    required this.isOn,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 366.1,
          height: 224.0,
          child: Stack(
            children: [
              Image.asset(
                isOn
                    ? 'lib/wh/feature/warehouse/parent/assets/images/light/water_value_on.png'
                    : 'lib/wh/feature/warehouse/parent/assets/images/light/water_value_off.png',
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        const SizedBox(height: 33.6),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AnimatedButton(
              isSelected: !isOn,
              onTap: () => onToggle(false),
              child: Container(
                width: 140.0,
                height: 140.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 14.0,
                ),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 2.1,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFFFB9B51),
                    ),
                    borderRadius: BorderRadius.circular(70.0),
                  ),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '關閉',
                      style: TextStyle(
                        fontSize: 22.4,
                        color: Color(0xFF292929),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 89.6),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 100.8,
                  child: Text(
                    '狀態',
                    style: TextStyle(
                      fontSize: 16.8,
                      color: Color(0xFF292929),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 6.3),
                Text(
                  isOn ? '開啟中' : '關閉中',
                  style: TextStyle(
                    fontSize: 33.6,
                    fontWeight: FontWeight.bold,
                    color: isOn ? const Color(0xFFFB9B51) : const Color(0xFFAAAAAA),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(width: 89.6),
            _AnimatedButton(
              isSelected: isOn,
              onTap: () => onToggle(true),
              child: Container(
                width: 140.0,
                height: 140.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 14.0,
                ),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 2.1,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFFFB9B51),
                    ),
                    borderRadius: BorderRadius.circular(70.0),
                  ),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '開啟',
                      style: TextStyle(
                        fontSize: 22.4,
                        color: Color(0xFF292929),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AnimatedButton extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;

  const _AnimatedButton({
    required this.isSelected,
    required this.onTap,
    required this.child,
  });

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}

class _FunctionCards extends StatelessWidget {
  final VoidCallback onTimerTap;

  const _FunctionCards({required this.onTimerTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTimerTap,
      child: Container(
        width: 280.0,
        padding: const EdgeInsets.symmetric(
          horizontal: 61.6,
          vertical: 11.2,
        ),
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xF0EEEEEE), Color(0xF0FBBB84)],
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(0xFFFB9B51),
            ),
            borderRadius: BorderRadius.circular(8.4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'lib/wh/feature/warehouse/parent/assets/images/common/clock.png',
              width: 49.0,
              height: 49.0,
              color: const Color(0xFF292929),
            ),
            const SizedBox(width: 11.2),
            const Text(
              '定時',
              style: TextStyle(
                fontSize: 22.4,
                color: Color(0xFF292929),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
