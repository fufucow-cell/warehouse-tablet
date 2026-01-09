import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';

/// 虛線邊框容器
class DashedBorderContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius borderRadius;
  final Widget child;
  final _borderWidth = 1.0;
  final _dashWidth = 10.0;
  final _dashSpace = 5.0;

  const DashedBorderContainer({
    super.key,
    this.width,
    this.height,
    required this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          child,
          IgnorePointer(
            child: CustomPaint(
              size: Size(
                width ?? double.infinity,
                height ?? double.infinity,
              ),
              painter: _DashedBorderPainter(
                borderRadius: borderRadius,
                borderColor: EnumColor.lineBorder.color,
                borderWidth: _borderWidth.scale,
                dashWidth: _dashWidth.scale,
                dashSpace: _dashSpace.scale,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 虛線邊框繪製器
class _DashedBorderPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final Color borderColor;
  final double borderWidth;
  final double dashWidth;
  final double dashSpace;

  _DashedBorderPainter({
    required this.borderRadius,
    required this.borderColor,
    required this.borderWidth,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    final topLeft = borderRadius.topLeft;
    final topRight = borderRadius.topRight;
    final bottomRight = borderRadius.bottomRight;
    final bottomLeft = borderRadius.bottomLeft;

    // 繪製上邊
    _drawDashedLine(
      canvas,
      paint,
      Offset(topLeft.x, borderWidth / 2),
      Offset(size.width - topRight.x, borderWidth / 2),
    );

    // 繪製右上角圓角
    if (topRight.x > 0 && topRight.y > 0) {
      _drawDashedArc(
        canvas,
        paint,
        Rect.fromLTWH(
          size.width - topRight.x * 2,
          0,
          topRight.x * 2,
          topRight.y * 2,
        ),
        0,
        -1.5708, // -90 degrees
      );
    }

    // 繪製右邊
    _drawDashedLine(
      canvas,
      paint,
      Offset(size.width - borderWidth / 2, topRight.y),
      Offset(size.width - borderWidth / 2, size.height - bottomRight.y),
    );

    // 繪製右下角圓角
    if (bottomRight.x > 0 && bottomRight.y > 0) {
      _drawDashedArc(
        canvas,
        paint,
        Rect.fromLTWH(
          size.width - bottomRight.x * 2,
          size.height - bottomRight.y * 2,
          bottomRight.x * 2,
          bottomRight.y * 2,
        ),
        1.5708, // 90 degrees
        -1.5708, // -90 degrees
      );
    }

    // 繪製下邊
    _drawDashedLine(
      canvas,
      paint,
      Offset(size.width - bottomRight.x, size.height - borderWidth / 2),
      Offset(bottomLeft.x, size.height - borderWidth / 2),
    );

    // 繪製左下角圓角
    if (bottomLeft.x > 0 && bottomLeft.y > 0) {
      _drawDashedArc(
        canvas,
        paint,
        Rect.fromLTWH(
          0,
          size.height - bottomLeft.y * 2,
          bottomLeft.x * 2,
          bottomLeft.y * 2,
        ),
        3.14159, // 180 degrees
        -1.5708, // -90 degrees
      );
    }

    // 繪製左邊
    _drawDashedLine(
      canvas,
      paint,
      Offset(borderWidth / 2, size.height - bottomLeft.y),
      Offset(borderWidth / 2, topLeft.y),
    );

    // 繪製左上角圓角
    if (topLeft.x > 0 && topLeft.y > 0) {
      _drawDashedArc(
        canvas,
        paint,
        Rect.fromLTWH(
          0,
          0,
          topLeft.x * 2,
          topLeft.y * 2,
        ),
        4.71239, // 270 degrees
        -1.5708, // -90 degrees
      );
    }
  }

  void _drawDashedLine(Canvas canvas, Paint paint, Offset start, Offset end) {
    final distance = (end - start).distance;
    if (distance <= 0) {
      return;
    }

    final direction = (end - start) / distance;
    final totalDashLength = dashWidth + dashSpace;
    final dashCount = (distance / totalDashLength).floor();

    for (int i = 0; i < dashCount; i++) {
      final dashStart = start + direction * (i * totalDashLength);
      final dashEnd = dashStart + direction * dashWidth;
      canvas.drawLine(dashStart, dashEnd, paint);
    }
  }

  void _drawDashedArc(
    Canvas canvas,
    Paint paint,
    Rect rect,
    double startAngle,
    double sweepAngle,
  ) {
    final radius = rect.width / 2;
    if (radius <= 0) {
      return;
    }

    // 計算圓角弧線的實際周長（考慮邊框寬度）
    final actualRadius = radius - borderWidth / 2;
    if (actualRadius <= 0) {
      return;
    }

    final circumference = actualRadius * (sweepAngle.abs());
    final totalDashLength = dashWidth + dashSpace;
    final dashCount = (circumference / totalDashLength).ceil();

    for (int i = 0; i < dashCount; i++) {
      // 計算當前虛線段的起始角度
      final currentOffset = i * totalDashLength;
      final angle = startAngle +
          (currentOffset / actualRadius) * (sweepAngle > 0 ? 1 : -1);

      // 計算剩餘的弧長
      final remainingLength = circumference - currentOffset;
      final remainingAngle =
          (remainingLength / actualRadius) * (sweepAngle > 0 ? 1 : -1);

      // 計算當前虛線段的角度（不超過剩餘角度）
      final dashAngle = (sweepAngle > 0 ? 1 : -1) *
          (remainingAngle.abs() < (dashWidth / actualRadius)
              ? remainingAngle.abs()
              : (dashWidth / actualRadius));

      if (dashAngle.abs() > 0.001) {
        final path = Path()..addArc(rect, angle, dashAngle);
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
