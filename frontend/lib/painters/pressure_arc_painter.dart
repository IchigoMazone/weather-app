
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class PressureArcPainter extends CustomPainter {
  const PressureArcPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.5;

    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi * 0.75, pi * 1.5, false, bgPaint);

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi * 0.75, pi * 0.9, false, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}