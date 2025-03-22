import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_weather_app/models/city_model.dart';

class CityRepository {
  List<CityModel> cities = [];
  Future<List<CityModel>> getCityList() async {
    try {
      if (cities.isEmpty) {
        final String response =
            await rootBundle.loadString('assets/json_data/indCityList.json');
        print("file readed as string");
        final List<dynamic> jsonData = json.decode(response);
        print("decoded sa json");
        // print("decoded --> \n $jsonData");

        cities =
            jsonData.map((cityJson) => CityModel.fromMap(cityJson)).toList();
        print("decode as list of citymodel");
      }

      print("returning cities");
      return cities;
    } catch (e) {
      throw Exception("Error loading city list -$e");
    }
  }
}
