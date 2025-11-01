
import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key});

  final List<Map<String, dynamic>> hourlyData = const [
    {'time': 'Now', 'temp': '28°', 'icon': Icons.wb_sunny, 'force': 'Force 3'},
    {'time': '16:00', 'temp': '28°', 'icon': Icons.wb_sunny, 'force': 'Force 1'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.22),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.2),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('24-hour forecast', style: TextStyle(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.w500)),
          const SizedBox(height: 20),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hourlyData.length,
              itemBuilder: (context, index) {
                final data = hourlyData[index];
                return Container(
                  width: 70,
                  margin: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      Text(data['temp'], style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      Icon(data['icon'], color: data['icon'] == Icons.wb_sunny ? Colors.yellow[600] : Colors.orange[300], size: 32),
                      const SizedBox(height: 12),
                      Text(data['force'], style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      const SizedBox(height: 8),
                      Text(data['time'], style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}