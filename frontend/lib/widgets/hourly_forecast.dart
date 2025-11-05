// // // lib/widgets/hourly_forecast.dart
// // import 'package:flutter/material.dart';
// // import 'dart:math' as math;

// // class HourlyForecast extends StatefulWidget {
// //   const HourlyForecast({super.key});

// //   @override
// //   State<HourlyForecast> createState() => _HourlyForecastState();
// // }

// // class _HourlyForecastState extends State<HourlyForecast>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;
// //   late Animation<double> _animation;
// //   final ScrollController _scrollController = ScrollController();

// //   List<Map<String, dynamic>> get _hourlyData {
// //     final now = DateTime.now();
// //     final currentHour = now.hour;

// //     final fixedTemps = [
// //       24, 23, 23, 23, 22, 21, 19, 20, 21, 21, 20, 20,
// //       21, 21, 20, 21, 21, 23, 24, 24, 23, 24, 23, 25
// //     ];

// //     return List.generate(24, (index) {
// //       final hour = (currentHour + index) % 24;
// //       final temp = fixedTemps[index];
// //       final isDay = hour >= 6 && hour < 18;
// //       final isSunset = hour == 17;
// //       return {
// //         'time': _formatTime24h(hour),
// //         'temp': temp,
// //         'icon': _getWeatherIcon(hour, isDay),
// //         'force': 2,
// //         'isSunset': isSunset,
// //         'isNow': index == 0,
// //       };
// //     });
// //   }

// //   String _formatTime24h(int hour) {
// //     return '${hour.toString().padLeft(2, '0')}h';
// //   }

// //   IconData _getWeatherIcon(int hour, bool isDay) {
// //     if (hour >= 6 && hour < 18) {
// //       if (hour == 17) return Icons.wb_cloudy;
// //       return Icons.wb_sunny;
// //     }
// //     return Icons.nights_stay;
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1400));
// //     _animation = Tween<double>(begin: 0, end: 1).animate(
// //       CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart),
// //     );
// //     _controller.forward();

// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _scrollToCurrentHour();
// //     });
// //   }

// //   void _scrollToCurrentHour() {
// //     if (!_scrollController.hasClients) return;

// //     final screenWidth = MediaQuery.of(context).size.width;
// //     final containerPadding = 60.0;
// //     final outerMargin = 32.0;
// //     final totalPadding = containerPadding + outerMargin;
// //     final itemWidth = (screenWidth - totalPadding) / 7;

// //     // ĐẨY VỀ BÊN TRÁI ĐỂ HIỆN THỜI GIAN HIỆN TẠI
// //     final targetOffset = 0.0;

// //     _scrollController.animateTo(
// //       targetOffset,
// //       duration: const Duration(milliseconds: 800),
// //       curve: Curves.easeOutCubic,
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     _scrollController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedBuilder(
// //       animation: _animation,
// //       builder: (context, child) {
// //         return Opacity(
// //           opacity: _animation.value,
// //           child: Transform.translate(
// //             offset: Offset(0, 20 * (1 - _animation.value)),
// //             child: _buildForecastCard(),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildForecastCard() {
// //     final screenWidth = MediaQuery.of(context).size.width;
// //     final containerPadding = 60.0;
// //     final outerMargin = 32.0;
// //     final totalPadding = containerPadding + outerMargin;
// //     final itemWidth = (screenWidth - totalPadding) / 7;
// //     final totalWidth = itemWidth * _hourlyData.length;

// //     return Container(
// //       margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
// //       padding: const EdgeInsets.all(20),
// //       decoration: BoxDecoration(
// //         color: Colors.white.withOpacity(0.22),
// //         borderRadius: BorderRadius.circular(24),
// //         border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.2),
// //         boxShadow: const [
// //           BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 8)),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             '24-hour forecast',
// //             style: TextStyle(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.w500),
// //           ),
// //           const SizedBox(height: 20),
// //           SizedBox(
// //             height: 250,
// //             child: ClipRRect(
// //               borderRadius: BorderRadius.circular(16),
// //               child: SingleChildScrollView(
// //                 controller: _scrollController,
// //                 scrollDirection: Axis.horizontal,
// //                 physics: BouncingScrollPhysics(),
// //                 child: SizedBox(
// //                   width: totalWidth,
// //                   child: Stack(
// //                     children: [
// //                       CustomPaint(
// //                         size: Size(totalWidth, 250),
// //                         painter: HourlyGraphPainter(
// //                           data: _hourlyData,
// //                           itemWidth: itemWidth,
// //                         ),
// //                       ),
// //                       Positioned(
// //                         bottom: 0,
// //                         left: 0,
// //                         right: 0,
// //                         child: Column(
// //                           children: [
// //                             Row(
// //                               children: _hourlyData
// //                                   .map((d) => _buildIconItem(d, itemWidth))
// //                                   .toList(),
// //                             ),
// //                             const SizedBox(height: 8),
// //                             Row(
// //                               children: _hourlyData
// //                                   .map((d) => _buildFooterItem(d, itemWidth))
// //                                   .toList(),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       if (_hourlyData[0]['isNow'])
// //                         Positioned(
// //                           left: itemWidth / 2 - 2,
// //                           top: 0,
// //                           child: Container(
// //                             width: 4,
// //                             height: 4,
// //                             decoration: BoxDecoration(
// //                               color: Colors.white,
// //                               shape: BoxShape.circle,
// //                               boxShadow: [
// //                                 BoxShadow(color: Colors.white, blurRadius: 4, spreadRadius: 1),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildIconItem(Map<String, dynamic> data, double width) {
// //     return SizedBox(
// //       width: width,
// //       child: Icon(
// //         data['icon'],
// //         color: data['icon'] == Icons.wb_sunny ? Colors.yellow[600] : Colors.blueGrey,
// //         size: 32,
// //       ),
// //     );
// //   }

// //   Widget _buildFooterItem(Map<String, dynamic> data, double width) {
// //     return SizedBox(
// //       width: width,
// //       child: Column(
// //         children: [
// //           Text(
// //             'Force ${data['force']}',
// //             style: TextStyle(color: Colors.white70, fontSize: 12),
// //           ),
// //           const SizedBox(height: 4),
// //           Text(
// //             data['time'],
// //             style: TextStyle(
// //               color: data['isNow'] ? Colors.white : Colors.white70,
// //               fontSize: 13,
// //               fontWeight: data['isNow'] ? FontWeight.w600 : FontWeight.normal,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // PAINTER: NHÃN VẼ TRƯỚC → ĐƯỜNG SAU → KHÔNG BAO GIỜ BỊ CHE
// // class HourlyGraphPainter extends CustomPainter {
// //   final List<Map<String, dynamic>> data;
// //   final double itemWidth;

// //   HourlyGraphPainter({required this.data, required this.itemWidth});

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     if (data.isEmpty) return;

// //     final temps = data.map((e) => e['temp'] as int).toList();
// //     final maxTemp = temps.reduce(math.max).toDouble();
// //     final minTemp = temps.reduce(math.min).toDouble();
// //     final tempRange = maxTemp - minTemp;
// //     final heightPerDegree = tempRange > 0 ? size.height * 0.35 / tempRange : 0.0;

// //     final textPainter = TextPainter(textDirection: TextDirection.ltr);
// //     final points = <Offset>[];

// //     // BƯỚC 1: TÍNH TỌA ĐỘ ĐIỂM (ĐẨY XUỐNG THẤP HƠN ĐỂ CÓ KHÔNG GIAN CHO NHÃN)
// //     for (int i = 0; i < temps.length; i++) {
// //       final x = itemWidth / 2 + i * itemWidth;
// //       final y = size.height - 110 - (temps[i] - minTemp) * heightPerDegree + 20;
// //       points.add(Offset(x, y));
// //     }

// //     // BƯỚC 2: VẼ NHÃN TRƯỚC (SỐ NHIỆT ĐỘ + SUNSET) - ĐẢM BẢO LUÔN Ở TRÊN ĐƯỜNG
// //     for (int i = 0; i < temps.length; i++) {
// //       final point = points[i];

// //       // LUÔN ĐẶT PHÍA TRÊN ĐIỂM 50PX
// //       final double labelY = point.dy - 50;

// //       textPainter.text = TextSpan(
// //         text: "${temps[i]}°",
// //         style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
// //       );
// //       textPainter.layout();
// //       textPainter.paint(
// //         canvas,
// //         Offset(point.dx - textPainter.width / 2, labelY),
// //       );

// //       if (data[i]['isSunset']) {
// //         textPainter.text = TextSpan(
// //           text: "Sunset",
// //           style: TextStyle(color: Colors.white70, fontSize: 13),
// //         );
// //         textPainter.layout();
// //         textPainter.paint(
// //           canvas,
// //           Offset(point.dx - textPainter.width / 2, labelY - 25),
// //         );
// //       }
// //     }

// //     // BƯỚC 3: VẼ ĐƯỜNG + ĐIỂM SAU → KHÔNG ĐÈ LÊN NHÃN
// //     final paint = Paint()
// //       ..color = Color(0xFFFFD54F)
// //       ..strokeWidth = 3.0
// //       ..style = PaintingStyle.stroke
// //       ..strokeCap = StrokeCap.round;

// //     final dotPaint = Paint()..color = Color(0xFFFFD54F);
// //     final path = Path();

// //     for (int i = 0; i < points.length; i++) {
// //       final point = points[i];
// //       canvas.drawCircle(point, 4.0, dotPaint);

// //       if (i == 0) {
// //         path.moveTo(point.dx, point.dy);
// //       } else {
// //         final prev = points[i - 1];
// //         final cp1 = Offset(prev.dx + itemWidth * 0.4, prev.dy);
// //         final cp2 = Offset(point.dx - itemWidth * 0.4, point.dy);
// //         path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, point.dx, point.dy);
// //       }
// //     }

// //     canvas.drawPath(path, paint);

// //     // ĐƯỜNG "NOW"
// //     final nowX = itemWidth / 2;
// //     final dashPaint = Paint()
// //       ..color = Colors.white.withOpacity(0.6)
// //       ..strokeWidth = 1.4;
// //     for (double y = 0; y < size.height - 100; y += 8) {
// //       canvas.drawLine(Offset(nowX, y), Offset(nowX, y + 4), dashPaint);
// //     }
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter old) => false;
// // }



// // lib/widgets/hourly_forecast.dart
// import 'package:flutter/material.dart';
// import 'dart:math' as math;
// import '../localization/app_localizations.dart';

// class HourlyForecast extends StatefulWidget {
//   const HourlyForecast({super.key});

//   @override
//   State<HourlyForecast> createState() => _HourlyForecastState();
// }

// class _HourlyForecastState extends State<HourlyForecast>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   final ScrollController _scrollController = ScrollController();

//   List<Map<String, dynamic>> get _hourlyData {
//     final now = DateTime.now();
//     final currentHour = now.hour;
//     final fixedTemps = [
//       24, 23, 23, 23, 22, 21, 19, 20, 21, 21, 20, 20,
//       21, 21, 20, 21, 21, 23, 24, 24, 23, 24, 23, 25
//     ];
//     return List.generate(24, (index) {
//       final hour = (currentHour + index) % 24;
//       final temp = fixedTemps[index];
//       final isDay = hour >= 6 && hour < 18;
//       final isSunset = hour == 17;
//       return {
//         'time': _formatTime24h(hour),
//         'temp': temp,
//         'icon': _getWeatherIcon(hour, isDay),
//         'force': 2,
//         'isSunset': isSunset,
//         'isNow': index == 0,
//       };
//     });
//   }

//   String _formatTime24h(int hour) {
//     return '${hour.toString().padLeft(2, '0')}h';
//   }

//   IconData _getWeatherIcon(int hour, bool isDay) {
//     if (hour >= 6 && hour < 18) {
//       if (hour == 17) return Icons.wb_cloudy;
//       return Icons.wb_sunny;
//     }
//     return Icons.nights_stay;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1400));
//     _animation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart),
//     );
//     _controller.forward();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollToCurrentHour();
//     });
//   }

//   void _scrollToCurrentHour() {
//     if (!_scrollController.hasClients) return;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final containerPadding = 60.0;
//     final outerMargin = 32.0;
//     final totalPadding = containerPadding + outerMargin;
//     final itemWidth = (screenWidth - totalPadding) / 7;
//     final targetOffset = 0.0;
//     _scrollController.animateTo(
//       targetOffset,
//       duration: const Duration(milliseconds: 800),
//       curve: Curves.easeOutCubic,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context);
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return Opacity(
//           opacity: _animation.value,
//           child: Transform.translate(
//             offset: Offset(0, 20 * (1 - _animation.value)),
//             child: _buildForecastCard(loc, isDark),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildForecastCard(AppLocalizations loc, bool isDark) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final containerPadding = 60.0;
//     final outerMargin = 32.0;
//     final totalPadding = containerPadding + outerMargin;
//     final itemWidth = (screenWidth - totalPadding) / 7;
//     final totalWidth = itemWidth * _hourlyData.length;

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: isDark 
//             ? Colors.white.withOpacity(0.12) 
//             : Colors.white.withOpacity(0.22),
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(
//           color: isDark ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.4),
//           width: 1.2,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(isDark ? 0.4 : 0.26),
//             blurRadius: 20,
//             offset: Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             loc.translate('24_hour_forecast'),
//             style: TextStyle(
//               color: isDark ? Colors.white70 : Colors.white70,
//               fontSize: 15,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 20),
//           SizedBox(
//             height: 250,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: SingleChildScrollView(
//                 controller: _scrollController,
//                 scrollDirection: Axis.horizontal,
//                 physics: BouncingScrollPhysics(),
//                 child: SizedBox(
//                   width: totalWidth,
//                   child: Stack(
//                     children: [
//                       CustomPaint(
//                         size: Size(totalWidth, 250),
//                         painter: HourlyGraphPainter(
//                           data: _hourlyData,
//                           itemWidth: itemWidth,
//                           isDark: isDark,
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         left: 0,
//                         right: 0,
//                         child: Column(
//                           children: [
//                             Row(
//                               children: _hourlyData
//                                   .map((d) => _buildIconItem(d, itemWidth, isDark))
//                                   .toList(),
//                             ),
//                             const SizedBox(height: 8),
//                             Row(
//                               children: _hourlyData
//                                   .map((d) => _buildFooterItem(d, itemWidth, loc, isDark))
//                                   .toList(),
//                             ),
//                           ],
//                         ),
//                       ),
//                       if (_hourlyData[0]['isNow'])
//                         Positioned(
//                           left: itemWidth / 2 - 2,
//                           top: 0,
//                           child: Container(
//                             width: 4,
//                             height: 4,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               shape: BoxShape.circle,
//                               boxShadow: [
//                                 BoxShadow(color: Colors.white, blurRadius: 4, spreadRadius: 1),
//                               ],
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildIconItem(Map<String, dynamic> data, double width, bool isDark) {
//     return SizedBox(
//       width: width,
//       child: Icon(
//         data['icon'],
//         color: data['icon'] == Icons.wb_sunny 
//             ? Colors.yellow[600] 
//             : (isDark ? Colors.blueGrey[300] : Colors.blueGrey),
//         size: 32,
//       ),
//     );
//   }

//   Widget _buildFooterItem(Map<String, dynamic> data, double width, AppLocalizations loc, bool isDark) {
//     return SizedBox(
//       width: width,
//       child: Column(
//         children: [
//           Text(
//             '${loc.translate('force')} ${data['force']}',
//             style: TextStyle(
//               color: isDark ? Colors.white60 : Colors.white70,
//               fontSize: 12,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             data['time'],
//             style: TextStyle(
//               color: data['isNow'] ? Colors.white : (isDark ? Colors.white60 : Colors.white70),
//               fontSize: 13,
//               fontWeight: data['isNow'] ? FontWeight.w600 : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // === PAINTER: ĐÃ DỊCH "Sunset" + THEME ===
// class HourlyGraphPainter extends CustomPainter {
//   final List<Map<String, dynamic>> data;
//   final double itemWidth;
//   final bool isDark;

//   HourlyGraphPainter({
//     required this.data,
//     required this.itemWidth,
//     required this.isDark,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     if (data.isEmpty) return;
//     final temps = data.map((e) => e['temp'] as int).toList();
//     final maxTemp = temps.reduce(math.max).toDouble();
//     final minTemp = temps.reduce(math.min).toDouble();
//     final tempRange = maxTemp - minTemp;
//     final heightPerDegree = tempRange > 0 ? size.height * 0.35 / tempRange : 0.0;
//     final textPainter = TextPainter(textDirection: TextDirection.ltr);
//     final points = <Offset>[];

//     // TÍNH TỌA ĐỘ ĐIỂM
//     for (int i = 0; i < temps.length; i++) {
//       final x = itemWidth / 2 + i * itemWidth;
//       final y = size.height - 110 - (temps[i] - minTemp) * heightPerDegree + 20;
//       points.add(Offset(x, y));
//     }

//     // VẼ NHÃN TRƯỚC
//     for (int i = 0; i < temps.length; i++) {
//       final point = points[i];
//       final double labelY = point.dy - 50;

//       // NHIỆT ĐỘ
//       textPainter.text = TextSpan(
//         text: "${temps[i]}°",
//         style: TextStyle(
//           color: isDark ? Colors.white : Colors.white,
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(point.dx - textPainter.width / 2, labelY),
//       );

//       // SUNSET
//       if (data[i]['isSunset']) {
//         textPainter.text = TextSpan(
//           text: AppLocalizations(Locale('en')).translate('sunset'), // DỊCH
//           style: TextStyle(
//             color: isDark ? Colors.white70 : Colors.white70,
//             fontSize: 13,
//           ),
//         );
//         textPainter.layout();
//         textPainter.paint(
//           canvas,
//           Offset(point.dx - textPainter.width / 2, labelY - 25),
//         );
//       }
//     }

//     // VẼ ĐƯỜNG + ĐIỂM SAU
//     final paint = Paint()
//       ..color = isDark ? Color(0xFFFFD54F) : Color(0xFFFFD54F)
//       ..strokeWidth = 3.0
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;
//     final dotPaint = Paint()..color = Color(0xFFFFD54F);
//     final path = Path();

//     for (int i = 0; i < points.length; i++) {
//       final point = points[i];
//       canvas.drawCircle(point, 4.0, dotPaint);
//       if (i == 0) {
//         path.moveTo(point.dx, point.dy);
//       } else {
//         final prev = points[i - 1];
//         final cp1 = Offset(prev.dx + itemWidth * 0.4, prev.dy);
//         final cp2 = Offset(point.dx - itemWidth * 0.4, point.dy);
//         path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, point.dx, point.dy);
//       }
//     }
//     canvas.drawPath(path, paint);

//     // ĐƯỜNG "NOW"
//     final nowX = itemWidth / 2;
//     final dashPaint = Paint()
//       ..color = Colors.white.withOpacity(isDark ? 0.6 : 0.6)
//       ..strokeWidth = 1.4;
//     for (double y = 0; y < size.height - 100; y += 8) {
//       canvas.drawLine(Offset(nowX, y), Offset(nowX, y + 4), dashPaint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter old) => false;
// }









// lib/widgets/hourly_forecast.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../localization/app_localizations.dart';

class HourlyForecast extends StatefulWidget {
  const HourlyForecast({super.key});

  @override
  State<HourlyForecast> createState() => _HourlyForecastState();
}

class _HourlyForecastState extends State<HourlyForecast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> get _hourlyData {
    final now = DateTime.now();
    final currentHour = now.hour;
    final fixedTemps = [
      24, 23, 23, 23, 22, 21, 19, 20, 21, 21, 20, 20,
      21, 21, 20, 21, 21, 23, 24, 24, 23, 24, 23, 25
    ];
    return List.generate(24, (index) {
      final hour = (currentHour + index) % 24;
      final temp = fixedTemps[index];
      final isDay = hour >= 6 && hour < 18;
      final isSunset = hour == 17;
      return {
        'time': _formatTime24h(hour),
        'temp': temp,
        'icon': _getWeatherIcon(hour, isDay),
        'force': 2,
        'isSunset': isSunset,
        'isNow': index == 0,
      };
    });
  }

  String _formatTime24h(int hour) => '${hour.toString().padLeft(2, '0')}h';

  IconData _getWeatherIcon(int hour, bool isDay) {
    if (hour >= 6 && hour < 18) {
      if (hour == 17) return Icons.wb_cloudy;
      return Icons.wb_sunny;
    }
    return Icons.nights_stay;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1400));
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart),
    );
    _controller.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToCurrentHour());
  }

  void _scrollToCurrentHour() {
    if (!_scrollController.hasClients) return;
    final screenWidth = MediaQuery.of(context).size.width;
    final totalPadding = 60.0 + 32.0;
    final itemWidth = (screenWidth - totalPadding) / 7;
    _scrollController.animateTo(0.0, duration: Duration(milliseconds: 800), curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Opacity(
        opacity: _animation.value,
        child: Transform.translate(
          offset: Offset(0, 20 * (1 - _animation.value)),
          child: _buildForecastCard(loc, isDark),
        ),
      ),
    );
  }

  Widget _buildForecastCard(AppLocalizations loc, bool isDark) {
    final screenWidth = MediaQuery.of(context).size.width;
    final totalPadding = 60.0 + 32.0;
    final itemWidth = (screenWidth - totalPadding) / 7;
    final totalWidth = itemWidth * _hourlyData.length;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 8),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.12) : Colors.white.withOpacity(0.22),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isDark ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.4), width: 1.2),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.4 : 0.26), blurRadius: 20, offset: Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(loc.translate('24_hour_forecast'), style: TextStyle(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.w500)),
          SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: SizedBox(
                  width: totalWidth,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(totalWidth, 250),
                        painter: HourlyGraphPainter(
                          data: _hourlyData,
                          itemWidth: itemWidth,
                          isDark: isDark,
                          context: context, // TRUYỀN CONTEXT
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Row(children: _hourlyData.map((d) => _buildIconItem(d, itemWidth, isDark)).toList()),
                            SizedBox(height: 8),
                            Row(children: _hourlyData.map((d) => _buildFooterItem(d, itemWidth, loc, isDark)).toList()),
                          ],
                        ),
                      ),
                      if (_hourlyData[0]['isNow'])
                        Positioned(
                          left: itemWidth / 2 - 2,
                          top: 0,
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: Colors.white, blurRadius: 4, spreadRadius: 1)],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconItem(Map<String, dynamic> data, double width, bool isDark) {
    return SizedBox(
      width: width,
      child: Icon(
        data['icon'],
        color: data['icon'] == Icons.wb_sunny ? Colors.yellow[600] : (isDark ? Colors.blueGrey[300] : Colors.blueGrey),
        size: 32,
      ),
    );
  }

  Widget _buildFooterItem(Map<String, dynamic> data, double width, AppLocalizations loc, bool isDark) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Text('${loc.translate('force')} ${data['force']}', style: TextStyle(color: isDark ? Colors.white60 : Colors.white70, fontSize: 12)),
          SizedBox(height: 4),
          Text(
            data['time'],
            style: TextStyle(
              color: data['isNow'] ? Colors.white : (isDark ? Colors.white60 : Colors.white70),
              fontSize: 13,
              fontWeight: data['isNow'] ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class HourlyGraphPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final double itemWidth;
  final bool isDark;
  final BuildContext context;

  HourlyGraphPainter({
    required this.data,
    required this.itemWidth,
    required this.isDark,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    final temps = data.map((e) => e['temp'] as int).toList();
    final maxTemp = temps.reduce(math.max).toDouble();
    final minTemp = temps.reduce(math.min).toDouble();
    final tempRange = maxTemp - minTemp;
    final heightPerDegree = tempRange > 0 ? size.height * 0.35 / tempRange : 0.0;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final points = <Offset>[];

    for (int i = 0; i < temps.length; i++) {
      final x = itemWidth / 2 + i * itemWidth;
      final y = size.height - 110 - (temps[i] - minTemp) * heightPerDegree + 20;
      points.add(Offset(x, y));
    }

    final loc = AppLocalizations.of(context);

    for (int i = 0; i < temps.length; i++) {
      final point = points[i];
      final double labelY = point.dy - 50;

      textPainter.text = TextSpan(
        text: "${temps[i]}°",
        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(point.dx - textPainter.width / 2, labelY));

      if (data[i]['isSunset']) {
        textPainter.text = TextSpan(
          text: loc.translate('sunset'), // DỊCH ĐÚNG
          style: TextStyle(color: Colors.white70, fontSize: 13),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(point.dx - textPainter.width / 2, labelY - 25));
      }
    }

    final paint = Paint()..color = Color(0xFFFFD54F)..strokeWidth = 3.0..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final dotPaint = Paint()..color = Color(0xFFFFD54F);
    final path = Path();

    for (int i = 0; i < points.length; i++) {
      final point = points[i];
      canvas.drawCircle(point, 4.0, dotPaint);
      if (i == 0) path.moveTo(point.dx, point.dy);
      else {
        final prev = points[i - 1];
        final cp1 = Offset(prev.dx + itemWidth * 0.4, prev.dy);
        final cp2 = Offset(point.dx - itemWidth * 0.4, point.dy);
        path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, point.dx, point.dy);
      }
    }
    canvas.drawPath(path, paint);

    final nowX = itemWidth / 2;
    final dashPaint = Paint()..color = Colors.white.withOpacity(0.6)..strokeWidth = 1.4;
    for (double y = 0; y < size.height - 100; y += 8) {
      canvas.drawLine(Offset(nowX, y), Offset(nowX, y + 4), dashPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}