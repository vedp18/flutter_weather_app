import 'package:flutter_weather_app/secrets.dart';
import 'package:http/http.dart' as http;


class WeatherDataProvider {
  
  Future<String> getCurrentWeatherData(int cityId) async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?id=$cityId&appid=$weatherAPI'));
    print('WeatherDataProvided');
     return response.body;
    } catch (e) {
      print("error in data_provideer");
      throw e.toString();
    }
  }

}

