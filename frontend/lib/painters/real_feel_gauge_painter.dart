
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class RealFeelGaugePainter extends CustomPainter {
  const RealFeelGaugePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 10);
    final radius = size.width / 2.5;

    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi * 0.75, pi * 1.5, false, bgPaint);

    final gradient = SweepGradient(
      startAngle: -pi * 0.75,
      endAngle: pi * 0.75,
      colors: [Colors.blue, Colors.green.shade400, Colors.orange.shade400],
    );
    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi * 0.75, pi * 0.75, false, paint);

    final needlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawLine(center, Offset(center.dx - radius * 0.7, center.dy - radius * 0.3), needlePaint);
  }

  @override
  bool shouldRepaint(_) => false;
}