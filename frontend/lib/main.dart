
import 'package:flutter/material.dart';
import 'package:frontend/services/weather_service.dart';
import 'package:frontend/models/weather.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  String _errorMessage = '';
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lonController = TextEditingController();

  void _fetchWeatherByCity() async {
    setState(() {
      _errorMessage = '';
      _weather = null;
    });
    try {
      final weather = await _weatherService.getWeatherByCity(_cityController.text);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  void _fetchWeatherByLatLon() async {
    setState(() {
      _errorMessage = '';
      _weather = null;
    });
    try {
      final lat = double.parse(_latController.text);
      final lon = double.parse(_lonController.text);
      final weather = await _weatherService.getWeatherByLatLon(lat, lon);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'Nhập tên thành phố (ví dụ: Ha Noi)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _fetchWeatherByCity,
                child: const Text('Lấy thời tiết theo thành phố'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _latController,
                decoration: const InputDecoration(
                  labelText: 'Nhập vĩ độ (lat)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _lonController,
                decoration: const InputDecoration(
                  labelText: 'Nhập kinh độ (lon)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _fetchWeatherByLatLon,
                child: const Text('Lấy thời tiết theo tọa độ'),
              ),
              const SizedBox(height: 20),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              if (_weather != null) ...[
                const Text(
                  'Vị trí:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('Thành phố: ${_weather!.location.city}'),
                Text('Quốc gia: ${_weather!.location.country}'),
                Text('Vĩ độ: ${_weather!.location.latitude}'),
                Text('Kinh độ: ${_weather!.location.longitude}'),
                const SizedBox(height: 10),
                const Text(
                  'Thời tiết hiện tại:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('Nhiệt độ: ${_weather!.currentWeather.temperature} ${_weather!.currentWeather.unit}'),
                Text('Nhiệt độ cảm giác: ${_weather!.currentWeather.feelsLike} ${_weather!.currentWeather.unit}'),
                Text('Nhiệt độ cao nhất: ${_weather!.currentWeather.maxTemperature} ${_weather!.currentWeather.unit}'),
                Text('Nhiệt độ thấp nhất: ${_weather!.currentWeather.minTemperature} ${_weather!.currentWeather.unit}'),
                Text('Độ ẩm: ${_weather!.currentWeather.humidity}%'),
                Text('Áp suất: ${_weather!.currentWeather.pressure} hPa'),
                Text('Chỉ số UV: ${_weather!.currentWeather.uvIndex}'),
                Text('Độ che phủ mây: ${_weather!.currentWeather.cloudCover}%'),
                Text('Mô tả thời tiết: ${_weather!.currentWeather.weatherDescription}'),
                Text('Gió: Tốc độ ${_weather!.currentWeather.wind.speed} ${_weather!.currentWeather.wind.unit}, Hướng ${_weather!.currentWeather.wind.direction}'),
                Text('Mặt trời mọc: ${_weather!.currentWeather.sunrise}'),
                Text('Mặt trời lặn: ${_weather!.currentWeather.sunset}'),
                const SizedBox(height: 10),
                const Text(
                  'Dự báo 5 ngày:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                for (var forecast in _weather!.fiveDayForecast)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ngày: ${forecast.date}'),
                      Text('Mô tả: ${forecast.weatherDescription}'),
                      Text('Nhiệt độ cao nhất: ${forecast.maxTemperature}°C'),
                      Text('Nhiệt độ thấp nhất: ${forecast.minTemperature}°C'),
                      const SizedBox(height: 5),
                    ],
                  ),
                const SizedBox(height: 10),
                const Text(
                  'Dự báo 24 giờ:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                for (var hour in _weather!.twentyFourHourForecast)
                  Text('Thời gian: ${hour.time}, Nhiệt độ cảm giác: ${hour.feelsLike}°C'),
                const SizedBox(height: 10),
                Text('Thời gian lấy dữ liệu: ${_weather!.dataFetchedAt}'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}