
import 'package:flutter/material.dart';
import 'detail_card.dart';
import '../utils/weather_detail_type.dart';
import '../localization/app_localizations.dart';

class WeatherDetailsGrid extends StatelessWidget {
  const WeatherDetailsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DetailCard(
                title: loc.translate('uv'),
                value: loc.translate('moderate'),
                extra: '4',
                type: WeatherDetailType.uv,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DetailCard(
                title: loc.translate('humidity'),
                value: '50%',
                extra: '',
                type: WeatherDetailType.humidity,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: DetailCard(
                title: loc.translate('real_feel'),
                value: '29°',
                extra: '',
                type: WeatherDetailType.realFeel,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DetailCard(
                title: loc.translate('northeast'),
                value: '${loc.translate('force')} 3',
                extra: '',
                type: WeatherDetailType.wind,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: DetailCard(
                title: loc.translate('sunset'),
                value: '17:25',
                extra: '17:25',
                type: WeatherDetailType.sunset,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DetailCard(
                title: loc.translate('pressure'),
                value: '1016',
                extra: 'hPa',
                type: WeatherDetailType.pressure,
              ),
            ),
          ],
        ),
      ],
    );
  }
}