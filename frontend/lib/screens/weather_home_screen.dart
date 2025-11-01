
import 'package:flutter/material.dart';
import '../models/location_model.dart';
import '../widgets/action_button.dart';
import '../widgets/forecast_card.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/weather_details_grid.dart';
import 'manage_cities_screen.dart';
import 'settings_screen.dart';
import '../localization/app_localizations.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  late final PageController _pageController;
  late final ScrollController _scrollController;
  int _currentPage = 0;

  // 20 ĐỊA ĐIỂM ĐỂ TEST
  List<Location> _locations = [
    Location(name: 'Hoài Đức', country: 'Hà Nội, Việt Nam', temp: 21, condition: 'Cloudy', min: 20, max: 24),
    Location(name: 'Hà Nội', country: 'Hà Nội, Việt Nam', temp: 23, condition: 'Cloudy', min: 21, max: 24),
    Location(name: 'Buôn Ma Thuột', country: 'Đắk Lắk, Việt Nam', temp: 28, condition: 'Cloudy', min: 21, max: 28),
    Location(name: 'Cẩm Phả', country: 'Quảng Ninh, Việt Nam', temp: 26, condition: 'Cloudy', min: 21, max: 26),
    Location(name: 'Hải Phòng', country: 'Hải Phòng, Việt Nam', temp: 25, condition: 'Cloudy', min: 21, max: 25),
    Location(name: 'Đà Nẵng', country: 'Đà Nẵng, Việt Nam', temp: 30, condition: 'Sunny', min: 25, max: 32),
    Location(name: 'Nha Trang', country: 'Khánh Hòa, Việt Nam', temp: 31, condition: 'Sunny', min: 26, max: 33),
    Location(name: 'Vũng Tàu', country: 'Bà Rịa - Vũng Tàu, Việt Nam', temp: 29, condition: 'Partly Cloudy', min: 24, max: 30),
    Location(name: 'Cần Thơ', country: 'Cần Thơ, Việt Nam', temp: 27, condition: 'Rainy', min: 23, max: 29),
    Location(name: 'Đà Lạt', country: 'Lâm Đồng, Việt Nam', temp: 18, condition: 'Cloudy', min: 15, max: 22),
    Location(name: 'Huế', country: 'Thừa Thiên Huế, Việt Nam', temp: 24, condition: 'Rainy', min: 22, max: 27),
    Location(name: 'Hội An', country: 'Quảng Nam, Việt Nam', temp: 29, condition: 'Sunny', min: 25, max: 31),
    Location(name: 'Phú Quốc', country: 'Kiên Giang, Việt Nam', temp: 32, condition: 'Sunny', min: 27, max: 34),
    Location(name: 'Nam Định', country: 'Nam Định, Việt Nam', temp: 22, condition: 'Cloudy', min: 19, max: 25),
    Location(name: 'Hạ Long', country: 'Quảng Ninh, Việt Nam', temp: 24, condition: 'Partly Cloudy', min: 20, max: 27),
    Location(name: 'Thái Nguyên', country: 'Thái Nguyên, Việt Nam', temp: 20, condition: 'Cloudy', min: 18, max: 23),
    Location(name: 'Vinh', country: 'Nghệ An, Việt Nam', temp: 26, condition: 'Rainy', min: 23, max: 28),
    Location(name: 'Biên Hòa', country: 'Đồng Nai, Việt Nam', temp: 28, condition: 'Partly Cloudy', min: 24, max: 30),
    Location(name: 'Long Xuyên', country: 'An Giang, Việt Nam', temp: 27, condition: 'Rainy', min: 23, max: 29),
    Location(name: 'Cao Bằng', country: 'Cao Bằng, Việt Nam', temp: 19, condition: 'Cloudy', min: 16, max: 22),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _scrollController = ScrollController();
    _pageController.addListener(_pageListener);
  }

  void _pageListener() {
    final next = _pageController.page?.round() ?? 0;
    if (_currentPage != next) {
      setState(() => _currentPage = next);
      if (_scrollController.hasClients) _scrollController.jumpTo(0);
    }
  }

  void _openManageCities() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManageCitiesScreen(
          allLocations: _locations,
          currentLocation: _locations.first,
          onLocationRemoved: (location) {
            setState(() {
              final removedIndex = _locations.indexOf(location);
              _locations.remove(location);
              if (_currentPage == removedIndex) {
                _currentPage = 0;
              } else if (_currentPage > removedIndex) {
                _currentPage--;
              }
              _pageController.jumpToPage(_currentPage);
            });
          },
          onLocationAdded: (location) {
            setState(() {
              _locations.add(location);
              _currentPage = _locations.length - 1;
              _pageController.jumpToPage(_currentPage);
            });
          },
          onLocationSelected: (location) {
            setState(() {
              final index = _locations.indexWhere((l) => l.name == location.name);
              if (index != -1) {
                _currentPage = index;
                _pageController.jumpToPage(_currentPage);
              }
            });
          },
          onBack: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

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
              ? [Color(0xFF1E90FF), Color(0xFF87CEEB), Color(0xFFE0F7FA)]
              : [Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF1E88E5)],
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
              child: PageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: _locations.length,
                itemBuilder: (context, index) {
                  final location = _locations[index];
                  final isCurrentPage = index == _currentPage;

                  return RepaintBoundary(
                    child: SingleChildScrollView(
                      controller: isCurrentPage ? _scrollController : null,
                      physics: isCurrentPage ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ActionButton(icon: Icons.add, onTap: _openManageCities),
                                      const SizedBox(width: 16),
                                      ActionButton(isMenu: true, onTap: _openSettings),
                                    ],
                                  ),
                                  const SizedBox(height: 30),

                                  Text(
                                    location.name,
                                    style: TextStyle(
                                      fontSize: 34,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 1.0,
                                      shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(1, 2))],
                                    ),
                                  ),

                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: SizedBox(
                                        height: 10,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: _locations.length > 6 ? 6 : _locations.length,
                                          itemBuilder: (context, i) {
                                            int actualIndex;
                                            if (_locations.length <= 6) {
                                              actualIndex = i;
                                            } else {
                                              actualIndex = _currentPage - (5 - i);
                                              if (actualIndex < 0) actualIndex = 0;
                                              if (actualIndex >= _locations.length) actualIndex = _locations.length - 1;
                                            }
                                            final bool isActive = actualIndex == _currentPage;

                                            return AnimatedContainer(
                                              duration: const Duration(milliseconds: 200),
                                              curve: Curves.easeOut,
                                              margin: const EdgeInsets.symmetric(horizontal: 2.5),
                                              width: isActive ? 9 : 6,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
                                                borderRadius: BorderRadius.circular(4),
                                                boxShadow: isActive
                                                    ? [const BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 1))]
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 28),
                                  Text('${location.temp}°', style: TextStyle(fontSize: 170, color: Colors.white, fontWeight: FontWeight.w100, height: 0.9, shadows: [Shadow(color: Colors.black38, blurRadius: 8, offset: Offset(3, 4))])),
                                  Text('${location.condition} • ${location.max}° / ${location.min}°', style: TextStyle(fontSize: 19, color: Colors.white70, letterSpacing: 0.8, fontWeight: FontWeight.w500)),
                                  const Spacer(),
                                  ForecastCard(location: location),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}