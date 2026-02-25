import 'package:flutter/material.dart';

class FirstBackgroundCard extends StatelessWidget {
  final Widget child;

  const FirstBackgroundCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      padding: const EdgeInsets.only(
        top: 12.0,
      ),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: const BorderRadius.all(
          Radius.circular(32.0),
        ),
        child: Container(
          padding: const EdgeInsets.only(
            left: 32.0,
            right: 32.0,
            top: 32.0,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/wh/feature/warehouse/parent/assets/images/light/bg_content.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
