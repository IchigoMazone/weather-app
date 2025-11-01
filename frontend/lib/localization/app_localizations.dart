
import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'manage_cities': 'Manage cities',
      'enter_location': 'Enter location',
      'current_location': 'Current location',
      'added_locations': 'Added locations',
      'no_added_locations': 'No added locations yet',
      'cancel': 'Cancel',
      'add': 'Add',
      'today': 'Today',
      'tomorrow': 'Tomorrow',
      'uv': 'UV',
      'humidity': 'Humidity',
      'real_feel': 'Real feel',
      'wind': 'Wind',
      'sunset': 'Sunset',
      'pressure': 'Pressure',
      'moderate': 'Moderate',
      'northeast': 'Northeast',
      'force': 'Force',
      'settings': 'Settings',
      'theme': 'Theme',
      'language': 'Language',
      'light': 'Light',
      'dark': 'Dark',
      'vietnamese': 'Vietnamese',
      'english': 'English',
      '5_day_forecast': '5-day forecast',
      '24_hour_forecast': '24-hour forecast',
    },
    'vi': {
      'manage_cities': 'Quản lý thành phố',
      'enter_location': 'Nhập địa điểm',
      'current_location': 'Vị trí hiện tại',
      'added_locations': 'Địa điểm đã thêm',
      'no_added_locations': 'Chưa có địa điểm nào',
      'cancel': 'Hủy',
      'add': 'Thêm',
      'today': 'Hôm nay',
      'tomorrow': 'Ngày mai',
      'uv': 'UV',
      'humidity': 'Độ ẩm',
      'real_feel': 'Cảm giác thực',
      'wind': 'Gió',
      'sunset': 'Hoàng hôn',
      'pressure': 'Áp suất',
      'moderate': 'Vừa phải',
      'northeast': 'Đông Bắc',
      'force': 'Cấp',
      'settings': 'Cài đặt',
      'theme': 'Chủ đề',
      'language': 'Ngôn ngữ',
      'light': 'Sáng',
      'dark': 'Tối',
      'vietnamese': 'Tiếng Việt',
      'english': 'Tiếng Anh',
      '5_day_forecast': 'Dự báo 5 ngày',
      '24_hour_forecast': 'Dự báo 24 giờ',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  String tr(String key) => translate(key);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}