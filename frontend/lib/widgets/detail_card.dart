
import 'package:flutter/material.dart';
import '../utils/weather_detail_type.dart';
import '../painters/uv_circle_painter.dart';
import '../painters/humidity_arc_painter.dart';
import '../painters/real_feel_gauge_painter.dart';
import '../painters/wind_compass_painter.dart';
import '../painters/sunset_curve_painter.dart';
import '../painters/pressure_arc_painter.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final String value;
  final String extra;
  final WeatherDetailType type;

  const DetailCard({
    super.key,
    required this.title,
    required this.value,
    required this.extra,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.22),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.2),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          _buildDetailGraphic(),
        ],
      ),
    );
  }

  Widget _buildDetailGraphic() {
    switch (type) {
      case WeatherDetailType.uv:
        return SizedBox(height: 80, child: CustomPaint(painter: const UVCirclePainter(), child: const Center(child: Text('4', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600)))));
      case WeatherDetailType.humidity:
        return SizedBox(height: 80, child: CustomPaint(painter: const HumidityArcPainter(), child: const Center(child: Icon(Icons.water_drop, color: Colors.blue, size: 32))));
      case WeatherDetailType.realFeel:
        return const SizedBox(height: 80, child: CustomPaint(painter: RealFeelGaugePainter()));
      case WeatherDetailType.wind:
        return const SizedBox(height: 80, child: CustomPaint(painter: WindCompassPainter()));
      case WeatherDetailType.sunset:
        return SizedBox(
          height: 80,
          child: CustomPaint(
            painter: const SunsetCurvePainter(),
            child: Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('05:57', style: TextStyle(color: Colors.white60, fontSize: 11)),
                  Text('17:25', style: TextStyle(color: Colors.white60, fontSize: 11)),
                ],
              ),
            ),
          ),
        );
      case WeatherDetailType.pressure:
        return SizedBox(
          height: 80,
          child: CustomPaint(
            painter: const PressureArcPainter(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_upward, color: Colors.blue, size: 28),
                  const SizedBox(height: 4),
                  Text(extra, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
          ),
        );
    }
  }
}