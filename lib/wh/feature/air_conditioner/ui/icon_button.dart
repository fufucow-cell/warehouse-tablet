import 'package:flutter/material.dart';

class CustIconButton extends StatelessWidget {
  final Widget icon;
  final double size;
  final VoidCallback onTap;

  const CustIconButton({
    super.key,
    required this.icon,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          child: icon,
        ),
      ),
    );
  }
}
