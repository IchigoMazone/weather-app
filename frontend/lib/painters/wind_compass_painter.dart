
import 'package:flutter/material.dart';

class WindCompassPainter extends CustomPainter {
  const WindCompassPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.8;

    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, bgPaint);

    final circlePaint = Paint()..color = Colors.blue..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.6, circlePaint);

    final arrowPaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(center.dx, center.dy - radius * 0.5)
      ..lineTo(center.dx - 8, center.dy + 10)
      ..lineTo(center.dx + 8, center.dy + 10)
      ..close();
    canvas.drawPath(path, arrowPaint);
  }

  @override
  bool shouldRepaint(_) => false;
}