
import 'package:flutter/material.dart';
import 'dart:math' show pi, cos, sin;

class WindCompassPainter extends CustomPainter {
  const WindCompassPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    final directions = [
      ('N', 0.0), ('NE', pi / 4), ('E', pi / 2), ('SE', 3 * pi / 4),
      ('S', pi), ('SW', 5 * pi / 4), ('W', 3 * pi / 2), ('NW', 7 * pi / 4),
    ];

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (final (label, angle) in directions) {
      final x = center.dx + (radius + 10) * cos(angle - pi / 2);
      final y = center.dy + (radius + 10) * sin(angle - pi / 2);
      textPainter.text = TextSpan(
        text: label,
        style: const TextStyle(color: Colors.white70, fontSize: 10),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
    }

    final windAngle = pi / 4;
    final arrowLength = radius * 0.8;
    final end = Offset(
      center.dx + arrowLength * cos(windAngle - pi / 2),
      center.dy + arrowLength * sin(windAngle - pi / 2),
    );

    final path = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(end.dx, end.dy);

    final headSize = 12.0;
    final p1 = Offset(
      end.dx - headSize * cos(windAngle - pi),
      end.dy - headSize * sin(windAngle - pi),
    );
    final p2 = Offset(
      end.dx - headSize * cos(windAngle),
      end.dy - headSize * sin(windAngle),
    );

    path
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(end.dx, end.dy)
      ..lineTo(p2.dx, p2.dy);

    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.cyan
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant WindCompassPainter old) => false;
}