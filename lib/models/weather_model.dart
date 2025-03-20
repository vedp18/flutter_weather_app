// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class WeatherModel {
  final double currentTemperature;
  final String currentSky;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final List<Map<String, dynamic>> hourlyForecastList;
  const WeatherModel({
    required this.currentTemperature,
    required this.currentSky,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.hourlyForecastList,
  });


  WeatherModel copyWith({
    double? currentTemperature,
    String? currentSky,
    int? pressure,
    int? humidity,
    double? windSpeed,
    List<Map<String, dynamic>>? hourlyForecastList,
  }) {
    return WeatherModel(
      currentTemperature: currentTemperature ?? this.currentTemperature,
      currentSky: currentSky ?? this.currentSky,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      hourlyForecastList: hourlyForecastList ?? this.hourlyForecastList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemperature': currentTemperature,
      'currentSky': currentSky,
      'pressure': pressure,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'hourlyForecastList': hourlyForecastList,
    };
  }
  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];

    return WeatherModel(
      currentTemperature: (currentWeatherData['main']['temp'] ?? 0.0) as double,
      currentSky: (currentWeatherData['weather'][0]['main'] ?? '') as String,
      pressure: (currentWeatherData['main']['pressure'] ?? 0.0),
      humidity: (currentWeatherData['main']['humidity'] ?? 0.0),
      windSpeed: (currentWeatherData['wind']['speed'] ?? 0.0) as double,
      hourlyForecastList: List<Map<String, dynamic>>.from(((map['list'] ?? const <Map<String, dynamic>>[]) as List).map<Map<String, dynamic>>((x) {return x;}),),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) => WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(currentTemperature: $currentTemperature, currentSky: $currentSky, pressure: $pressure, humidity: $humidity, windSpeed: $windSpeed, hourlyForecastList: $hourlyForecastList)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.currentTemperature == currentTemperature &&
      other.currentSky == currentSky &&
      other.pressure == pressure &&
      other.humidity == humidity &&
      other.windSpeed == windSpeed &&
      listEquals(other.hourlyForecastList, hourlyForecastList);
  }

  @override
  int get hashCode {
    return currentTemperature.hashCode ^
      currentSky.hashCode ^
      pressure.hashCode ^
      humidity.hashCode ^
      windSpeed.hashCode ^
      hourlyForecastList.hashCode;
  }
}
