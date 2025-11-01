
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class UVCirclePainter extends CustomPainter {
  const UVCirclePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.5;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final colors = [Colors.green, Colors.yellow, Colors.orange, Colors.red];
    for (int i = 0; i < 4; i++) {
      paint.color = colors[i];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi + (i * pi / 2),
        pi / 2,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}