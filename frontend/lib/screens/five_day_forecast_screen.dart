
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/location_model.dart';

class FiveDayForecastScreen extends StatefulWidget {
  final Location location;
  const FiveDayForecastScreen({super.key, required this.location});

  @override
  State<FiveDayForecastScreen> createState() => _FiveDayForecastScreenState();
}

class _FiveDayForecastScreenState extends State<FiveDayForecastScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<Map<String, dynamic>> _forecast = [
    {'day': 'Today', 'date': '11/4', 'icon': Icons.cloud, 'min': 18, 'max': 22, 'force': 2},
    {'day': 'Tomorrow', 'date': '11/5', 'icon': Icons.cloud_queue, 'min': 19, 'max': 23, 'force': 1},
    {'day': 'Th 5', 'date': '11/6', 'icon': Icons.wb_cloudy, 'min': 22, 'max': 25, 'force': 1},
    {'day': 'Th 6', 'date': '11/7', 'icon': Icons.wb_sunny, 'min': 23, 'max': 24, 'force': 1},
    {'day': 'Th 7', 'date': '11/8', 'icon': Icons.cloud, 'min': 23, 'max': 26, 'force': 2},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1400));
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "5-day forecast",
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0.5),
        ),
        centerTitle: false,
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Opacity(
                opacity: _animation.value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - _animation.value)),
                  child: _buildFullScrollableTable(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFullScrollableTable() {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = 40; 
    final double availableWidth = screenWidth - padding - 32; 
    final double itemWidth = availableWidth / 4.2;
    final double totalWidth = itemWidth * _forecast.length;

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          width: totalWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: _forecast.map((day) => _buildHeaderItem(day, itemWidth)).toList(),
              ),
              SizedBox(height: 20),

              // Bieu do
              SizedBox(
                height: 200,
                child: CustomPaint(
                  painter: TemperatureGraphPainter(
                    data: _forecast,
                    itemWidth: itemWidth,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Footer
              Row(
                children: _forecast.map((day) => _buildFooterItem(day, itemWidth)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderItem(Map<String, dynamic> day, double width) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(day['day'], style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400)),
          SizedBox(height: 4),
          Text(day['date'], style: TextStyle(color: Colors.white60, fontSize: 13)),
          SizedBox(height: 8),
          Icon(day['icon'], color: Colors.white70, size: 32),
        ],
      ),
    );
  }

  Widget _buildFooterItem(Map<String, dynamic> day, double width) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(day['icon'], color: Colors.white60, size: 28),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_drop_up, color: Colors.white38, size: 18),
              Text("Force ${day['force']}", style: TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class TemperatureGraphPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final double itemWidth;

  TemperatureGraphPainter({required this.data, required this.itemWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final maxTemps = data.map((e) => e['max'] as int).toList();
    final minTemps = data.map((e) => e['min'] as int).toList();

    final double maxTemp = maxTemps.reduce(math.max).toDouble();
    final double minTemp = minTemps.reduce(math.min).toDouble();
    final double tempRange = maxTemp - minTemp;
    final double heightPerDegree = tempRange > 0 ? size.height * 0.6 / tempRange : 0.0;


    final double startX = -2 * itemWidth;

    _drawCurve(
      canvas: canvas,
      size: size,
      temps: maxTemps,
      color: Color(0xFFC7A740),
      dotColor: Color(0xFFC7A740),
      textColor: Colors.white,
      heightPerDegree: heightPerDegree,
      minTemp: minTemp,
      startX: startX,
      itemWidth: itemWidth,
      labelOffset: -30,
    );

    _drawCurve(
      canvas: canvas,
      size: size,
      temps: minTemps,
      color: Color(0xFF5A6270),
      dotColor: Color(0xFF5A6270),
      textColor: Colors.white70,
      heightPerDegree: heightPerDegree,
      minTemp: minTemp,
      startX: startX,
      itemWidth: itemWidth,
      labelOffset: 25,
    );
  }

  void _drawCurve({
    required Canvas canvas,
    required Size size,
    required List<int> temps,
    required Color color,
    required Color dotColor,
    required Color textColor,
    required double heightPerDegree,
    required double minTemp,
    required double startX,
    required double itemWidth,
    required double labelOffset,
  }) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()..color = dotColor;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final path = Path();
    final points = <Offset>[];

    for (int i = 0; i < temps.length; i++) {
      final double x = startX + i * itemWidth;
      final double y = size.height - 50 - (temps[i] - minTemp) * heightPerDegree;
      points.add(Offset(x, y));

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prev = points[i - 1];
        final cp1 = Offset(prev.dx + itemWidth * 0.4, prev.dy);
        final cp2 = Offset(x - itemWidth * 0.4, y);
        path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, x, y);
      }
    }

    canvas.drawPath(path, paint);

    for (int i = 0; i < temps.length; i++) {
      final point = points[i];
      canvas.drawCircle(point, 4.5, dotPaint);
      textPainter.text = TextSpan(
        text: "${temps[i]}°",
        style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w500),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(point.dx - textPainter.width / 2, point.dy + labelOffset),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}