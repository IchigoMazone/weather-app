
import 'package:flutter/material.dart';
import 'dart:math' show pi, cos, sin;

class PressureArcPainter extends CustomPainter {
  const PressureArcPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;

    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi * 0.7,
      pi * 1.4,
      false,
      bgPaint,
    );

    final fillPath = Path()
      ..addArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi * 0.7,
        pi * 0.8,
      );

    final fillPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    final pathMetrics = fillPath.computeMetrics().first;
    final startPoint = pathMetrics.getTangentForOffset(0)!.position;
    final endPoint = pathMetrics.getTangentForOffset(pathMetrics.length)!.position;

    fillPaint.shader = const LinearGradient(
      colors: [Colors.purpleAccent, Colors.deepPurple, Colors.indigo],
    ).createShader(Rect.fromPoints(startPoint, endPoint));

    canvas.drawPath(fillPath, fillPaint);

    final currentAngle = -pi * 0.7 + pi * 0.8;
    final logoX = center.dx + radius * cos(currentAngle);
    final logoY = center.dy + radius * sin(currentAngle);

   
    canvas.drawCircle(
      Offset(logoX, logoY),
      14, 
      Paint()
        ..color = Colors.white.withOpacity(0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );

   
    canvas.drawCircle(
      Offset(logoX, logoY),
      9, 
      Paint()..color = Colors.purpleAccent,
    );

   
    canvas.drawCircle(
      Offset(logoX, logoY),
      2, 
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant PressureArcPainter old) => false;
}