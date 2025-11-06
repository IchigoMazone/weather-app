// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';
import 'weather_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 10), vsync: this);
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const WeatherHomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF0D47A1), const Color(0xFF1565C0), const Color(0xFF1E88E5)]
                : [const Color(0xFF1E90FF), const Color(0xFF87CEEB), const Color(0xFFE3F2FD)],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(color: isDark ? Colors.black.withOpacity(0.08) : Colors.white.withOpacity(0.08)),
            ),

            // ĐÁM MÂY
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Center(
                child: Icon(Icons.cloud, size: 220, color: Colors.white, shadows: [
                  Shadow(color: Colors.black.withOpacity(0.3), blurRadius: 30, offset: const Offset(0, 15))
                ]),
              ),
            ),

            // THÔNG TIN NHÓM – MÔN TÔ ĐẬM + BỎ NGÀY
            Positioned(
              top: 320,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    // TÊN APP
                    Text(
                      loc.translate('app_name'),
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        shadows: [Shadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3))],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Nhom
                    _buildInfoRow(loc.translate('group'), '', loc.translate('27'), ''),

                    // Mon hoc
                    _buildBoldRow(loc.translate('course')),

                    // Lop + Ma Course 
                    _buildInfoRow(loc.translate('class'), '', loc.translate('N04'), loc.translate('1-1-2025')),

                    // Thanh Vien
                    _buildInfoRow(loc.translate('member'), '', loc.translate('Trịnh Như Nhất'), ''),

                    // Ma Sinh Vien
                    _buildInfoRow(loc.translate('student_id'), '', loc.translate('23010600'), ''),

                    // Nganh
                    _buildInfoRow(loc.translate('major'), '', loc.translate('Khoa Học Máy Tính & Trí Tuệ Nhân Tạo'), ''),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 80,
              left: 40,
              right: 40,
              child: Column(
                children: [
                  Text(loc.translate('loading_app'), style: const TextStyle(fontSize: 16, color: Colors.white70, fontStyle: FontStyle.italic)),
                  const SizedBox(height: 12),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) => Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: _progressAnimation.value,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            valueColor: const AlwaysStoppedAnimation(Colors.white),
                            minHeight: 9,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(_progressAnimation.value * 100).toInt()}%',
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, shadows: [
                            Shadow(color: Colors.black38, blurRadius: 4, offset: Offset(0, 1))
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // DÒNG THƯỜNG (title + value)
  Widget _buildInfoRow(String titleKey, String subtitleKey, String titleValue, String subtitleValue) {
    final loc = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 15.5, color: Colors.white),
          children: [
            if (titleKey.isNotEmpty) TextSpan(text: '${loc.translate(titleKey)} ', style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5)),
            if (titleValue.isNotEmpty) TextSpan(text: '$titleValue ', style: const TextStyle(fontWeight: FontWeight.bold)),
            if (subtitleKey.isNotEmpty) TextSpan(text: loc.translate(subtitleKey), style: const TextStyle(fontWeight: FontWeight.w400)),
            if (subtitleValue.isNotEmpty) TextSpan(text: ' $subtitleValue', style: const TextStyle(fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }

  // DÒNG TÔ ĐẬM TOÀN BỘ (DÀNH CHO MÔN HỌC)
  Widget _buildBoldRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15.5,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}