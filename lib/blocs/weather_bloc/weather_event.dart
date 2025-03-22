part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

final class WeatherFetchedEvent extends WeatherEvent {
  // final String cityName;
  final int cityId;

  WeatherFetchedEvent({required this.cityId});
}
