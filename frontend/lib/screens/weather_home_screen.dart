
import 'package:flutter/material.dart';
import '../models/location_model.dart';
import '../widgets/action_button.dart';
import '../widgets/forecast_card.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/weather_details_grid.dart';
import 'manage_cities_screen.dart';
import 'settings_screen.dart';
import 'five_day_forecast_screen.dart';
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

  List<Location> _locations = [
    Location(name: 'Hoài Đức', country: 'Hà Nội, Việt Nam', temp: 21, condition: 'Cloudy', min: 20, max: 24),
    Location(name: 'Hà Nội', country: 'Hà Nội, Việt Nam', temp: 24, condition: 'Rainy', min: 22, max: 27),
    Location(name: 'Đà Nẵng', country: 'Đà Nẵng, Việt Nam', temp: 31, condition: 'Sunny', min: 26, max: 33),
    Location(name: 'Hồ Chí Minh', country: 'Hồ Chí Minh, Việt Nam', temp: 22, condition: 'Cloudy', min: 19, max: 25),
    Location(name: 'Thanh Hóa', country: 'Thanh Hóa, Việt Nam', temp: 23, condition: 'Cloudy', min: 21, max: 24),
    Location(name: 'Ninh Bình', country: 'Ninh Bình, Việt Nam', temp: 18, condition: 'Cloudy', min: 15, max: 22),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _scrollController = ScrollController();
    _pageController.addListener(_pageListener);
  }

  void _pageListener() {
    final next = (_pageController.page?.round() ?? 0);
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
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _translateCondition(String condition, AppLocalizations loc) {
    switch (condition) {
      case 'Cloudy': return loc.translate('cloudy');
      case 'Sunny': return loc.translate('sunny');
      case 'Rainy': return loc.translate('rainy');
      case 'Partly Cloudy': return loc.translate('partly_cloudy');
      default: return condition;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF1E88E5)]
                : [Color(0xFF1E90FF), Color(0xFF87CEEB), Color(0xFFE0F7FA)],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: isDark ? Colors.black.withOpacity(0.08) : Colors.white.withOpacity(0.08),
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
                  final translatedCondition = _translateCondition(location.condition, loc);

                  return RepaintBoundary(
                    child: SingleChildScrollView(
                      controller: isCurrentPage ? _scrollController : null,
                      physics: isCurrentPage
                          ? const AlwaysScrollableScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
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
                                        width: 90, 
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: _locations.length,
                                          itemBuilder: (context, i) {
                                            
                                            final distance = (i - _currentPage).abs();
                                            if (_locations.length > 6 && distance > 2 && i != _currentPage) {
                                              return const SizedBox.shrink(); 
                                            }

                                            final isActive = i == _currentPage;
                                            return AnimatedContainer(
                                              duration: const Duration(milliseconds: 300),
                                              curve: Curves.easeOutCubic,
                                              margin: const EdgeInsets.symmetric(horizontal: 3.5),
                                              width: isActive ? 10 : 7,
                                              height: isActive ? 10 : 7,
                                              decoration: BoxDecoration(
                                                color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
                                                shape: BoxShape.circle,
                                                boxShadow: isActive
                                                    ? [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))]
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                  Text(
                                    '${location.temp}°',
                                    style: TextStyle(
                                      fontSize: 170,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      height: 0.9,
                                      shadows: [Shadow(color: Colors.black38, blurRadius: 8, offset: Offset(3, 4))],
                                    ),
                                  ),
                                  Text(
                                    '$translatedCondition • ${location.max}° / ${location.min}°',
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white70,
                                      letterSpacing: 0.8,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  ForecastCard(
                                    location: location,
                                    onFiveDayPressed: () {
                                      final theme = Theme.of(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FiveDayForecastScreen(
                                            location: location,
                                            theme: theme,
                                            loc: loc,
                                          ),
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