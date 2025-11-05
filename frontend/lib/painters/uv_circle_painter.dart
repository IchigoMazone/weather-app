
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class UVCirclePainter extends CustomPainter {
  final double uvIndex;
  const UVCirclePainter({required this.uvIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;

    final colors = [
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.red,
      Colors.purple,
    ];
    final level = (uvIndex.clamp(0, 11) / 3).floor().clamp(0, 4);
    final fillColor = colors[level];

    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final uvPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    const startAngle = -pi / 2;
    final sweepAngle = 2 * pi * (uvIndex.clamp(0, 11) / 11);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, 2 * pi, false, bgPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, uvPaint);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: uvIndex.toStringAsFixed(0),
      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    );
    textPainter.layout();
    textPainter.paint(canvas, center - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant UVCirclePainter old) => old.uvIndex != uvIndex;
}