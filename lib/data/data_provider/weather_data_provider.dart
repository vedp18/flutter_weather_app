import 'package:flutter_weather_app/secrets.dart';
import 'package:http/http.dart' as http;


class WeatherDataProvider {
  
  Future<String> getCurrentWeatherData(String cityName) async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=$cityName,in&APPID=$weatherAPI'));

    print('WeatherDataProvided');
     return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

}