
class Weather {
  final Location location;
  final CurrentWeather currentWeather;
  final List<FiveDayForecast> fiveDayForecast;
  final List<TwentyFourHourForecast> twentyFourHourForecast;
  final String dataFetchedAt;

  Weather({
    required this.location,
    required this.currentWeather,
    required this.fiveDayForecast,
    required this.twentyFourHourForecast,
    required this.dataFetchedAt,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: Location.fromJson(json['location']),
      currentWeather: CurrentWeather.fromJson(json['currentWeather']),
      fiveDayForecast: (json['fiveDayForecast'] as List)
          .map((e) => FiveDayForecast.fromJson(e))
          .toList(),
      twentyFourHourForecast: (json['twentyFourHourForecast'] as List)
          .map((e) => TwentyFourHourForecast.fromJson(e))
          .toList(),
      dataFetchedAt: json['dataFetchedAt'],
    );
  }
}

class Location {
  final String city;
  final String country;
  final String latitude;
  final String longitude;

  Location({
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['city'],
      country: json['country'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class CurrentWeather {
  final int temperature;
  final String unit;
  final int humidity;
  final int pressure;
  final int maxTemperature;
  final int minTemperature;
  final int uvIndex;
  final int feelsLike;
  final Wind wind;
  final int cloudCover;
  final String weatherDescription;
  final String sunrise;
  final String sunset;

  CurrentWeather({
    required this.temperature,
    required this.unit,
    required this.humidity,
    required this.pressure,
    required this.maxTemperature,
    required this.minTemperature,
    required this.uvIndex,
    required this.feelsLike,
    required this.wind,
    required this.cloudCover,
    required this.weatherDescription,
    required this.sunrise,
    required this.sunset,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: json['temperature'],
      unit: json['unit'],
      humidity: json['humidity'],
      pressure: json['pressure'],
      maxTemperature: json['maxTemperature'],
      minTemperature: json['minTemperature'],
      uvIndex: json['uvIndex'],
      feelsLike: json['feelsLike'],
      wind: Wind.fromJson(json['wind']),
      cloudCover: json['cloudCover'],
      weatherDescription: json['weatherDescription'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}

class Wind {
  final String speed;
  final String unit;
  final String direction;

  Wind({
    required this.speed,
    required this.unit,
    required this.direction,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'],
      unit: json['unit'],
      direction: json['direction'],
    );
  }
}

class FiveDayForecast {
  final String date;
  final int maxTemperature;
  final int minTemperature;
  final String weatherDescription;

  FiveDayForecast({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    required this.weatherDescription,
  });

  factory FiveDayForecast.fromJson(Map<String, dynamic> json) {
    return FiveDayForecast(
      date: json['date'],
      maxTemperature: json['maxTemperature'],
      minTemperature: json['minTemperature'],
      weatherDescription: json['weatherDescription'],
    );
  }
}

class TwentyFourHourForecast {
  final String time;
  final int feelsLike;

  TwentyFourHourForecast({
    required this.time,
    required this.feelsLike,
  });

  factory TwentyFourHourForecast.fromJson(Map<String, dynamic> json) {
    return TwentyFourHourForecast(
      time: json['time'],
      feelsLike: json['feelsLike'],
    );
  }
}