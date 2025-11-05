
import 'package:flutter/material.dart';
import 'dart:math' show pi, cos, sin;

class RealFeelGaugePainter extends CustomPainter {
  final double realFeel;
  final double minTemp;
  final double maxTemp;

  const RealFeelGaugePainter({
    required this.realFeel,
    required this.minTemp,
    required this.maxTemp,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;
    final progress = ((realFeel - minTemp) / (maxTemp - minTemp)).clamp(0.0, 1.0);

    final gradient = SweepGradient(
      colors: [Colors.cyan, Colors.blue, Colors.green, Colors.yellow, Colors.orange, Colors.red],
      stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
    );

    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    const startAngle = 3 * pi / 4;
    const fullSweep = 3 * pi / 2;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, fullSweep, false, bgPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, fullSweep * progress, false, progressPaint);

    final needleLength = radius * 0.7;
    final angle = startAngle + fullSweep * progress;
    final endX = center.dx + needleLength * cos(angle);
    final endY = center.dy + needleLength * sin(angle);

    final needlePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, Offset(endX, endY), needlePaint);
    canvas.drawCircle(center, 6, Paint()..color = Colors.white);
    canvas.drawCircle(center, 3, Paint()..color = const Color(0xFF2196F3));
  }

  @override
  bool shouldRepaint(covariant RealFeelGaugePainter old) => old.realFeel != realFeel;
}