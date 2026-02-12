import 'package:flutter/material.dart';

class CustToggleSwitch extends StatelessWidget {
  final bool value;
  final VoidCallback onTap;

  const CustToggleSwitch({
    super.key,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 75,
        height: 40,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: value ? const Color(0xFFFB9B51) : const Color(0xFF7C7C7C),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: value ? 40 : 5,
              top: 5,
              child: Container(
                width: 30,
                height: 30,
                decoration: const ShapeDecoration(
                  color: Color(0xFFFFFFFF),
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: Color(0x1F292929),
                      blurRadius: 6.0,
                      offset: Offset(0, 5.0),
                      spreadRadius: 0,
                    ),
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
