
import 'package:flutter/material.dart';
import '../models/location_model.dart';

class ForecastCard extends StatelessWidget {
  final Location location;

  const ForecastCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.22),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.2),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 8))],
      ),
      child: Column(
        children: [
          _buildForecastRow('Today', Icons.wb_sunny, location.min, location.max),
          const Divider(height: 1.5, color: Colors.white54, thickness: 1),
          _buildForecastRow('Tomorrow', Icons.wb_cloudy, location.min, location.max + 1),
          const Divider(height: 1.5, color: Colors.white54, thickness: 1),
          _buildForecastRow('Th 4', Icons.wb_sunny_outlined, location.min, location.max - 1),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () => print('Xem dự báo 5 ngày'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.35),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: Colors.white54, width: 1.5)),
              ),
              child: const Text('5-day forecast', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastRow(String day, IconData icon, int min, int max) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 92, child: Text(day, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600))),
          Icon(icon, color: Colors.yellow[600], size: 30),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('$min°', style: const TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(width: 14),
                Container(width: 96, height: 7, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), gradient: LinearGradient(colors: [Colors.orange.shade400, Colors.yellow.shade600]))),
                const SizedBox(width: 14),
                Text('$max°', style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}