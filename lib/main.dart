import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/app_bloc_observer.dart';
import 'package:flutter_weather_app/blocs/city_search_bloc/city_search_bloc.dart';
import 'package:flutter_weather_app/blocs/weather_bloc/weather_bloc.dart';
import 'package:flutter_weather_app/data/data_provider/weather_data_provider.dart';
import 'package:flutter_weather_app/data/repository/city_repository.dart';
import 'package:flutter_weather_app/data/repository/weather_repository.dart';
import 'package:flutter_weather_app/ui/screens/weather_screen.dart';

void main() {
  Bloc.observer = AppBlocObserver();
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => WeatherRepository(WeatherDataProvider()),
        ),
        RepositoryProvider(
          create: (context) => CityRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          // WeatherBloc
          BlocProvider(
            // either use RepositoryProvider.of(context).read<WeatherRepository>() or below used one
            create: (context) => WeatherBloc(context.read<WeatherRepository>()),
          ),

          // CitySearch Bloc
          BlocProvider(
            create: (context) => CitySearchBloc(context.read<CityRepository>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(useMaterial3: true),
          home: WeatherScreen(),
        ),
      ),
    );
  }
}
