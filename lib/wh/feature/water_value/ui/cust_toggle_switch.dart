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
        width: 70.7,
        height: 40.6,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: value ? const Color(0xFFFB9B51) : const Color(0xFF666666),
                  borderRadius: BorderRadius.circular(21.0),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: value ? 35.35 : 5.117,
              top: 5.908,
              child: Container(
                width: 29.456,
                height: 29.526,
                decoration: const ShapeDecoration(
                  color: Color(0xFFFFFFFF),
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 4.2,
                      offset: Offset(0, 3.5),
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
