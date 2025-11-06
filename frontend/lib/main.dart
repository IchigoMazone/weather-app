
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'screens/weather_home_screen.dart';
import 'screens/splash_screen.dart'; 
import 'services/theme_service.dart';
import 'services/language_service.dart';
import 'localization/app_localizations.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeService()),
        ChangeNotifierProvider(create: (_) => LanguageService()),
      ],
      child: Consumer2<ThemeService, LanguageService>(
        builder: (context, themeService, langService, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather App',
            locale: langService.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('vi'),
            ],
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: const Color(0xFF1E90FF),
              scaffoldBackgroundColor: Colors.white,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: const Color(0xFF0D47A1),
              scaffoldBackgroundColor: Colors.black,
            ),
            themeMode: themeService.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(), 
          );
        },
      ),
    );
  }
}