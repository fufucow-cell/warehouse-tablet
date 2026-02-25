import 'package:flutter/material.dart';

class AirBackgroundCard extends StatelessWidget {
  final Widget child;
  final bool isBox;
  final bool isPurifier;

  const AirBackgroundCard({
    super.key,
    required this.child,
    this.isBox = false,
    this.isPurifier = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      padding: const EdgeInsets.symmetric(
        vertical: 48.0,
        horizontal: 32.0,
      ),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: const BorderRadius.all(
          Radius.circular(32.0),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/wh/feature/warehouse/parent/assets/images/light/bg_content.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/wh/feature/warehouse/parent/assets/images/common/background_wind1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            if (isBox)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 700.0,
                    height: 700.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/wh/feature/warehouse/parent/assets/images/common/background_wind2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            if (isPurifier)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 1100.0,
                  height: 1100.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/wh/feature/warehouse/parent/assets/images/common/background_wind2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 32.0,
                  right: 32.0,
                  top: 32.0,
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
