
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  static const String _baseUrl = 'http://localhost:3000/api/weather/address';

  Future<Weather?> getWeatherByCity(String city) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?address=$city'));
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Thành phố không tìm thấy');
      } else {
        throw Exception('Lỗi khi gọi API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  Future<Weather?> getWeatherByLatLon(double lat, double lon) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?lat=$lat&lon=$lon'));
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        throw Exception('Tọa độ không hợp lệ');
      } else {
        throw Exception('Lỗi khi gọi API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }
}