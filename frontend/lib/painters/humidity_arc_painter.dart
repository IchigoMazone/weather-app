
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class HumidityArcPainter extends CustomPainter {
  final double humidity;
  const HumidityArcPainter({required this.humidity});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;

    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = const Color(0xFF2196F3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    const startAngle = -pi;
    final sweepAngle = pi * humidity.clamp(0.0, 1.0);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, pi, false, bgPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, fillPaint);

    final iconPaint = Paint()..color = const Color(0xFF2196F3)..style = PaintingStyle.fill;
    final iconScale = radius * 0.7;
    final path = Path()
      ..moveTo(center.dx, center.dy - iconScale * 0.8)
      ..quadraticBezierTo(center.dx - iconScale * 0.35, center.dy - iconScale * 0.45, center.dx - iconScale * 0.17, center.dy + iconScale * 0.07)
      ..quadraticBezierTo(center.dx, center.dy + iconScale * 0.35, center.dx + iconScale * 0.17, center.dy + iconScale * 0.07)
      ..quadraticBezierTo(center.dx + iconScale * 0.35, center.dy - iconScale * 0.45, center.dx, center.dy - iconScale * 0.8)
      ..close();
    canvas.drawPath(path, iconPaint);
  }

  @override
  bool shouldRepaint(covariant HumidityArcPainter old) => old.humidity != humidity;
}