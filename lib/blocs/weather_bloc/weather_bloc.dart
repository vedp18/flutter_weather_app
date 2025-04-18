
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/data/repository/weather_repository.dart';
import 'package:flutter_weather_app/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetchedEvent>(_onWeatherFetchedEvent);
  }

  // event handler
  void _onWeatherFetchedEvent(
    WeatherFetchedEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weather =
          await weatherRepository.getCurrentWeatherData(event.cityId);
      emit(WeatherSuccess(weatherModel: weather));
    } catch (e) {
      emit(WeatherFailure(
          "Please Check your internet Connection. Make sure you're connected to internet."));
    }
  }
}
