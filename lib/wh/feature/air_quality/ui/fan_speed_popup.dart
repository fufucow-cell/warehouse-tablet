import 'package:flutter/material.dart';

class FanSpeedPopup extends StatelessWidget {
  final String currentSpeed;
  final Function(String) onSpeedSelected;
  final VoidCallback onClose;

  const FanSpeedPopup({
    super.key,
    required this.currentSpeed,
    required this.onSpeedSelected,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              left: 16.0,
              top: 98.0,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 400.0,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xF0EEEEEE), Color(0xF0FBBB84)],
                    ),
                    border: Border.all(
                      width: 1.0,
                      color: const Color(0xFFFB9B51),
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      FanSpeedOption(
                        title: '微風',
                        onTap: () => onSpeedSelected('微風'),
                      ),
                      const _Divider(),
                      FanSpeedOption(
                        title: '弱風',
                        onTap: () => onSpeedSelected('弱風'),
                      ),
                      const _Divider(),
                      FanSpeedOption(
                        title: '強風',
                        onTap: () => onSpeedSelected('強風'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FanSpeedOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const FanSpeedOption({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        padding: const EdgeInsets.all(
          24.0,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 24.0,
            color: Color(0xFF292929),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Divider(
        height: 1.0,
        thickness: 1.0,
        color: Color(0xFF292929),
      ),
    );
  }
}
