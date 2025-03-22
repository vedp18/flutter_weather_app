part of 'city_search_bloc.dart';

@immutable
sealed class CitySearchEvent {}


final class CitySearchBarTapped extends CitySearchEvent{}
final class CitySearchTextChanged extends CitySearchEvent {
  final String query;

  CitySearchTextChanged({required this.query});
}

final class CitySearchCitySelectedEvent extends CitySearchEvent {
  final CityModel city;

  CitySearchCitySelectedEvent({required this.city});
}
