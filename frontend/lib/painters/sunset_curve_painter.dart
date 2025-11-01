
import 'package:flutter/material.dart';

class SunsetCurvePainter extends CustomPainter {
  const SunsetCurvePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(colors: [Colors.orange.shade300, Colors.purple.shade300])
          .createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(size.width / 2, 0, size.width, size.height * 0.7);
    canvas.drawPath(path, paint);

    final dotPaint = Paint()..color = Colors.orange.shade300..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.2), 6, dotPaint);
  }

  @override
  bool shouldRepaint(_) => false;
}