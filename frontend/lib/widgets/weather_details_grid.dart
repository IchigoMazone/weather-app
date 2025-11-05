// lib/widgets/weather_details_grid.dart
import 'package:flutter/material.dart';
import 'detail_card.dart';
import '../utils/weather_detail_type.dart';

class WeatherDetailsGrid extends StatelessWidget {
  const WeatherDetailsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DetailCard(
                title: 'UV',
                value: 'Moderate',
                extra: '4',
                type: WeatherDetailType.uv,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DetailCard(
                title: 'Humidity',
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
                title: 'Real feel',
                value: '29°',
                extra: '',
                type: WeatherDetailType.realFeel,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DetailCard(
                title: 'Northeast',
                value: 'Force 3',
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
                title: 'Sunset',
                value: '17:25',
                extra: '17:25',
                type: WeatherDetailType.sunset,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DetailCard(
                title: 'Pressure',
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