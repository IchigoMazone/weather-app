// lib/widgets/detail_card.dart
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
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailGraphic(),
        ],
      ),
    );
  }

  Widget _buildDetailGraphic() {
    switch (type) {
      case WeatherDetailType.uv:
        final uvIndex = double.tryParse(extra) ?? 0.0;
        return SizedBox(
          height: 80,
          child: CustomPaint(
            painter: UVCirclePainter(uvIndex: uvIndex),
            size: const Size(80, 80),
          ),
        );

      case WeatherDetailType.humidity:
        final humidityStr = value.replaceAll('%', '');
        final humidity = (double.tryParse(humidityStr) ?? 0.0) / 100.0;
        return SizedBox(
          height: 80,
          child: CustomPaint(
            painter: HumidityArcPainter(humidity: humidity),
            size: const Size(80, 80),
          ),
        );

      case WeatherDetailType.realFeel:
        final tempStr = value.replaceAll('°', '');
        final realFeel = double.tryParse(tempStr) ?? 25.0;
        return SizedBox(
          height: 80,
          child: CustomPaint(
            painter: RealFeelGaugePainter(
              realFeel: realFeel,
              minTemp: 0,
              maxTemp: 50,
            ),
            size: const Size(80, 80),
          ),
        );

      case WeatherDetailType.wind:
        return SizedBox(
          height: 80,
          child: CustomPaint(
            painter: const WindCompassPainter(),
            size: const Size(80, 80),
          ),
        );

      case WeatherDetailType.sunset:
        return SizedBox(
          height: 80,
          child: CustomPaint(
            painter: const SunsetCurvePainter(),
            size: const Size(80, 80),
            child: Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '05:57',
                    style: TextStyle(color: Colors.white60, fontSize: 11),
                  ),
                  Text(
                    extra.isNotEmpty ? extra : value,
                    style: const TextStyle(color: Colors.white60, fontSize: 11),
                  ),
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
            size: const Size(80, 80),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_downward, color: Colors.blue, size: 28),
                  const SizedBox(height: 4),
                  Text(
                    extra,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}