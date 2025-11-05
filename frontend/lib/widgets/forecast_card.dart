
// import 'package:flutter/material.dart';
// import '../models/location_model.dart';

// class ForecastCard extends StatelessWidget {
//   final Location location;
//   final VoidCallback? onFiveDayPressed; 

//   const ForecastCard({
//     super.key,
//     required this.location,
//     this.onFiveDayPressed, 
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.22),
//         borderRadius: BorderRadius.circular(32),
//         border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.2),
//         boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 8))],
//       ),
//       child: Column(
//         children: [
//           _buildForecastRow('Today', Icons.wb_sunny, location.min, location.max),
//           const Divider(height: 1.5, color: Colors.white54, thickness: 1),
//           _buildForecastRow('Tomorrow', Icons.wb_cloudy, location.min, location.max + 1),
//           const Divider(height: 1.5, color: Colors.white54, thickness: 1),
//           _buildForecastRow('Th 4', Icons.wb_sunny_outlined, location.min, location.max - 1),
//           const SizedBox(height: 22),
//           SizedBox(
//             width: double.infinity,
//             height: 54,
//             child: ElevatedButton(
//               onPressed: onFiveDayPressed, 
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white.withOpacity(0.35),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                   side: const BorderSide(color: Colors.white54, width: 1.5),
//                 ),
//               ),
//               child: const Text(
//                 '5-day forecast',
//                 style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildForecastRow(String day, IconData icon, int min, int max) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SizedBox(
//             width: 92,
//             child: Text(day, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
//           ),
//           Icon(icon, color: Colors.yellow[600], size: 30),
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text('$min°', style: const TextStyle(color: Colors.white70, fontSize: 16)),
//                 const SizedBox(width: 14),
//                 Container(
//                   width: 96,
//                   height: 7,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     gradient: LinearGradient(colors: [Colors.orange.shade400, Colors.yellow.shade600]),
//                   ),
//                 ),
//                 const SizedBox(width: 14),
//                 Text('$max°', style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }











// lib/widgets/forecast_card.dart
import 'package:flutter/material.dart';
import '../models/location_model.dart';
import '../localization/app_localizations.dart';

class ForecastCard extends StatelessWidget {
  final Location location;
  final VoidCallback? onFiveDayPressed;

  const ForecastCard({
    super.key,
    required this.location,
    this.onFiveDayPressed,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
      decoration: BoxDecoration(
        color: isDark 
            ? Colors.white.withOpacity(0.12) 
            : Colors.white.withOpacity(0.22),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.4),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.4 : 0.26),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildForecastRow(
            loc.translate('today'),
            Icons.wb_sunny,
            location.min,
            location.max,
            isDark,
          ),
          Divider(height: 1.5, color: Colors.white.withOpacity(isDark ? 0.3 : 0.54), thickness: 1),
          _buildForecastRow(
            loc.translate('tomorrow'),
            Icons.wb_cloudy,
            location.min,
            location.max + 1,
            isDark,
          ),
          Divider(height: 1.5, color: Colors.white.withOpacity(isDark ? 0.3 : 0.54), thickness: 1),
          _buildForecastRow(
            loc.translate('thu'),
            Icons.wb_sunny_outlined,
            location.min,
            location.max - 1,
            isDark,
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: onFiveDayPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark 
                    ? Colors.white.withOpacity(0.2) 
                    : Colors.white.withOpacity(0.35),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: Colors.white.withOpacity(isDark ? 0.4 : 0.54),
                    width: 1.5,
                  ),
                ),
                elevation: 0,
              ),
              child: Text(
                loc.translate('5_day_forecast'),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastRow(
    String day,
    IconData icon,
    int min,
    int max,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 92,
            child: Text(
              day,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(icon, color: Colors.yellow[600], size: 30),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '$min°',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 14),
                Container(
                  width: 96,
                  height: 7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      colors: [Colors.orange.shade400, Colors.yellow.shade600],
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  '$max°',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}