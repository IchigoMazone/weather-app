// lib/painters/sunset_curve_painter.dart
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class SunsetCurvePainter extends CustomPainter {
  const SunsetCurvePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    // Tạo đường cong mềm mại hơn
    final path = Path()
      ..moveTo(center.dx - radius, center.dy)
      ..quadraticBezierTo(
        center.dx,
        center.dy - radius * 1.3, // Đẩy điểm điều khiển lên cao hơn
        center.dx + radius,
        center.dy,
      );

    // Tạo paint với gradient theo đúng chiều đường cong
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8 // Tăng độ dày cho đẹp
      ..strokeCap = StrokeCap.round;

    // Tạo gradient dọc theo đường cong
    final pathMetrics = path.computeMetrics().first;
    final tangentStart = pathMetrics.getTangentForOffset(0)!;
    final tangentEnd = pathMetrics.getTangentForOffset(pathMetrics.length)!;

    paint.shader = LinearGradient(
      colors: const [Colors.orange, Colors.deepOrange, Colors.red],
      begin: Alignment(tangentStart.position.dx, tangentStart.position.dy),
      end: Alignment(tangentEnd.position.dx, tangentEnd.position.dy),
    ).createShader(path.getBounds());

    canvas.drawPath(path, paint);

    // Vẽ mặt trời ở cuối đường cong
    final sunOffset = pathMetrics.getTangentForOffset(pathMetrics.length * 0.85)!
        .position;
    canvas.drawCircle(
      sunOffset,
      12,
      Paint()
        ..color = Colors.yellow
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
  }

  @override
  bool shouldRepaint(covariant SunsetCurvePainter old) => false;
}