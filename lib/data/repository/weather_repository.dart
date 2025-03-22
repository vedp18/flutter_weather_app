import 'dart:convert';

import 'package:flutter_weather_app/data/data_provider/weather_data_provider.dart';
import 'package:flutter_weather_app/models/weather_model.dart';

class WeatherRepository {

  final WeatherDataProvider weatherDataProvider;

  WeatherRepository(this.weatherDataProvider);

  
  Future<WeatherModel> getCurrentWeatherData(int cityId) async {
    try {
      // String cityName = "Dhansura";
      final weatherData = await weatherDataProvider.getCurrentWeatherData(cityId);

      final data = jsonDecode(weatherData);
      if (data['cod'] != '200') {
        throw 'An unexpected error occured!';
      }
      print('returning WeatherModel');
      return WeatherModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }

}