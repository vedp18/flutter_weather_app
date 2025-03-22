import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/blocs/city_search_bloc/city_search_bloc.dart';
import 'package:flutter_weather_app/blocs/weather_bloc/weather_bloc.dart';
import 'package:flutter_weather_app/models/city_model.dart';

class CitySearchBar extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  CitySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<CityModel> cities = [];

    return BlocBuilder<CitySearchBloc, CitySearchState>(
      builder: (context, state) {
        print("Bloc builder build");
        if (state is CitySearchResults) {
          print("state is result: - ${state.cities.length}");
          cities = state.cities;
        }
        return Column(
          children: [
            Autocomplete<CityModel>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                print("options builder - text:${textEditingValue.text}");
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<CityModel>.empty();
                }
                return cities
                    .where((city) => city.name
                        .toLowerCase()
                        .startsWith(textEditingValue.text.trim().toLowerCase()))
                    .toList();
              },
              displayStringForOption: (CityModel city) => city.name,
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextField(
                  onTap: () {
                    context.read<CitySearchBloc>().add(CitySearchBarTapped());
                  },
                  controller: textEditingController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: "Search City",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  // onChanged: (query) {
                  //   context
                  //       .read<CitySearchBloc>()
                  //       .add(CitySearchTextChanged(query: query));
                  // },
                );
              },
              onSelected: (CityModel selectedCity) {
                _controller.text = selectedCity.name;
                context
                    .read<CitySearchBloc>()
                    .add(CitySearchCitySelectedEvent(city: selectedCity));


                context.read<WeatherBloc>().add(WeatherFetchedEvent(cityId: selectedCity.id));
                print("selectedcity: ${selectedCity.id}");
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<CityModel> onSelected,
                  Iterable<CityModel> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      constraints: BoxConstraints(maxHeight: 170),
                      child: ListView.builder(
                        padding: EdgeInsets.all(5),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final CityModel city = options.elementAt(index);
                          return ListTile(
                            tileColor: Colors.grey[800],
                            title: Text(city.name),
                            onTap: () {
                              onSelected(city);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_weather_app/blocs/city_search_bloc/city_search_bloc.dart';

// class CitySearchBar extends StatelessWidget {
//   final TextEditingController _controller = TextEditingController();

//   CitySearchBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // SizedBox(
//         //   height: 12,
//         // ),
//         Container(
//           decoration: BoxDecoration(
//             // color: Colors.white,
//             border: Border.all(color: Colors.white),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: TextField(
//             controller: _controller,
//             decoration: InputDecoration(
//               labelText: "Search City",
//               labelStyle: TextStyle(color: Colors.white),
//               border: InputBorder.none,
//               //   borderSide: BorderSide(color: Colors.white),
//               //   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//               // ),
//             ),
//             onChanged: (query) {
//               context
//                   .read<CitySearchBloc>()
//                   .add(CitySearchTextChanged(query: query));
//             },
//           ),
//         ),
//         // SizedBox(height: 8),
//         BlocBuilder<CitySearchBloc, CitySearchState>(
//           builder: (context, state) {
//             if (state is CitySearchResults && state.cities.isNotEmpty) {
//               return Container(
//                 constraints: BoxConstraints(maxHeight: 50),
//                 decoration: BoxDecoration(
//                     // borderRadius:
//                     //     BorderRadius.vertical(bottom: Radius.circular(20)),
//                     // color: Colors.white,
//                     // border: Border.all(color: Colors.white),
//                     ),
//                 child: ListView.builder(
//                   itemCount: state.cities.length,
//                   itemBuilder: (context, index) {
//                     final city = state.cities[index];
//                     return ListTile(
//                       tileColor: index.isEven ? Colors.grey : Colors.red,
//                       title: Text(city.name),
//                       onTap: () {
//                         _controller.text = city.name;
//                         context
//                             .read<CitySearchBloc>()
//                             .add(CitySearchCitySelectedEvent(city: city));
//                       },
//                     );
//                   },
//                 ),
//               );
//             }
//             return SizedBox.shrink();
//           },
//         ),
//       ],
//     );
//   }
// }
