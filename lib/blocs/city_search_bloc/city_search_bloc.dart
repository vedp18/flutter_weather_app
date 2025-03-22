import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/data/repository/city_repository.dart';
import 'package:flutter_weather_app/models/city_model.dart';

part 'city_search_event.dart';
part 'city_search_state.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final CityRepository cityRepository;
  List<CityModel> cities=[];

  CitySearchBloc(this.cityRepository) : super(CitySearchInitial()) {
    on<CitySearchTextChanged>(_onCitySearchTextChanged);
    on<CitySearchCitySelectedEvent>(_onCitySearchCitySelectedEvent);
    on<CitySearchBarTapped>(_onCitySearchBarTapped);
  }

  void _onCitySearchTextChanged(
    CitySearchTextChanged event,
    Emitter<CitySearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(CitySearchInitial());
    } else {
      final cities = await cityRepository.getCityList();
      final filteredCities = cities
          .where((city) =>
              city.name.toLowerCase().startsWith(event.query.toLowerCase()))
          .toList();

      emit(CitySearchResults(cities: filteredCities));
    }
  }

  void _onCitySearchCitySelectedEvent(
    CitySearchCitySelectedEvent event,
    Emitter<CitySearchState> emit,
  ) {
    emit(CitySearchCitySelected(city: event.city));
  }



  void _onCitySearchBarTapped(CitySearchBarTapped event, Emitter<CitySearchState> emit) async {
    
    cities = await cityRepository.getCityList();

    emit(CitySearchResults(cities: cities));
  }
}
