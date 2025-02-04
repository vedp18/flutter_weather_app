import 'package:flutter/material.dart';
import 'package:flutter_weather_app/weather_screen.dart';

void main() {
  runApp(const WeatherApp());
}


class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: WeatherScreen(),
    );
  }
}