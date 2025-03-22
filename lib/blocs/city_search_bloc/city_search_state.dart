part of 'city_search_bloc.dart';

@immutable
sealed class CitySearchState {}

final class CitySearchInitial extends CitySearchState {}

final class CitySearchResults extends CitySearchState {
  final List<CityModel> cities;

  CitySearchResults({required this.cities});
}

final class CitySearchCitySelected extends CitySearchState {
  final CityModel city;

  CitySearchCitySelected({required this.city});
}
