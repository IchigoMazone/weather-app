
import 'package:flutter/material.dart';
import '../models/location_model.dart';
import '../widgets/forecast_card.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/weather_details_grid.dart';
import '../localization/app_localizations.dart';
import 'five_day_forecast_screen.dart';

class PreviewLocationScreen extends StatelessWidget {
  final Location location;
  final VoidCallback onAdd;
  final VoidCallback onCancel;

  const PreviewLocationScreen({
    super.key,
    required this.location,
    required this.onAdd,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Theme.of(context).brightness == Brightness.light
                ? [const Color(0xFF1E90FF), const Color(0xFF87CEEB), const Color(0xFFE0F7FA)]
                : [const Color(0xFF0D47A1), const Color(0xFF1565C0), const Color(0xFF1E88E5)],
            stops: const [0.0, 0.4, 1.0],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white.withOpacity(0.08)
                    : Colors.black.withOpacity(0.08),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildPreviewActionButton(
                                  icon: Icons.close,
                                  onTap: onCancel,
                                  label: loc.translate('cancel'),
                                ),
                                _buildPreviewActionButton(
                                  icon: Icons.check,
                                  onTap: onAdd,
                                  label: loc.translate('add'),
                                  isAdd: true,
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Text(
                              location.name,
                              style: const TextStyle(
                                fontSize: 34,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.0,
                                shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(1, 2))],
                              ),
                            ),
                            const SizedBox(height: 28),
                            Text(
                              '${location.temp}°',
                              style: const TextStyle(
                                fontSize: 170,
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                                height: 0.9,
                                shadows: [Shadow(color: Colors.black38, blurRadius: 8, offset: Offset(3, 4))],
                              ),
                            ),
                            Text(
                              '${location.condition} • ${location.max}° / ${location.min}°',
                              style: const TextStyle(fontSize: 19, color: Colors.white70, letterSpacing: 0.8, fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),

                            ForecastCard(
                              location: location,
                              onFiveDayPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FiveDayForecastScreen(location: location),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Column(
                        children: const [
                          HourlyForecast(),
                          SizedBox(height: 24),
                          WeatherDetailsGrid(),
                          SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewActionButton({
    required IconData icon,
    required VoidCallback onTap,
    required String label,
    bool isAdd = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: isAdd ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}