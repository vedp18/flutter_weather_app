import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/secrets.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_weather_app/additional_information.dart';
import 'package:flutter_weather_app/hourly_forecasting_data.dart';


class WeatherScreen extends StatefulWidget{

  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather; 


  Future<Map<String,dynamic>> getCurrentWeatherData() async {

    try {
      String cityName = "Dhansura";
      final response = await http.get(
        Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=$cityName,in&APPID=$weatherAPI'
        )
      );

      final data = jsonDecode(response.body);
      if(data['cod'] != '200') {
        throw 'An unexpected error occured!';
      }
      return data;
    } catch(e) {
      throw e.toString();
    }

  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          // instead of GestureDetector we will use IconButton 
          IconButton(
            onPressed: () {

              setState(() {
                weather = getCurrentWeatherData();

              });
            },
            icon: const Icon(Icons.refresh),
          )

          // GestureDetector(
          //   onTap: () {
          //     print("Refresh");
          //   },
          //   child: const Icon(Icons.refresh_sharp),
          // ),
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {

          // loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive()
            );
          }

          if (snapshot.hasError){
            return Center(
              child: Text(
                snapshot.error.toString()
              ),
            );
          }

          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];

          // Current Weather Data
          final currentTemperature = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];

          // Additional Informations
          final pressure = currentWeatherData['main']['pressure'];
          final humidity = currentWeatherData['main']['humidity'];
          final windSpeed = currentWeatherData['wind']['speed']; 
          
          return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              // main card or primary card
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 16,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            // Text of temperature
                            Text(
                              "${(currentTemperature - 270).toStringAsFixed(2)}°C",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        
                            //spaces
                            SizedBox(height: 12,),
                        
                            // Icon of cloud 
                            Icon(
                              currentSky == 'Clouds' || currentSky =='Rainy' 
                                ? Icons.cloud
                                : Icons.sunny,
                              size: 65,),
                        
                            //spaces
                            SizedBox(height: 8,),
                        
                            // Text 'Rain'
                            Text(
                              currentSky,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                        
                          ],  // children
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          
              // spaces 
              const SizedBox(height: 20,),
        
        
              /// Next Card -> Additional Information
              // Card Heading
              const Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        
              // spaces 
              const SizedBox(height: 8,),
        
              //additional information card
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
        
                  // Humidity
                  AdditionalInformation(
                    icon: Icons.water_drop,
                    label: "Humidity",
                    value: humidity.toString(),
                  ),
        
                  // Wind Speed
                  AdditionalInformation(
                    icon: Icons.air,
                    label: "Wind Speed",
                    value: windSpeed.toString(),
                  ),
        
                  // Pressure
                  AdditionalInformation(
                    icon: Icons.wind_power,
                    label: "Pressure",
                    value: pressure.toString(),
                  ),
                ],
              ),  
          
              // spaces 
              const SizedBox(height: 20,),
          
              // Card Heading
              const Text(
                "Hourly Forecast",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        
              // spaces 
              const SizedBox(height: 8,),
              

              /// This technique loads all cards at same time which can degrads the performances
              // weather forecasting card
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       for(int i =0; i< 5; i++)
              //         HourlyForecastingData(
              //           time: data['list'][i+1]['dt'].toString(),
              //           temperature: (data['list'][i+1]['main']['temp'] - 270).toStringAsFixed(2),
              //           icon: data['list'][i+1]['weather'][0]['main'] == 'Clouds' || data['list'][i+1]['weather'][0]['main'] == 'Rainy' 
              //             ? Icons.cloud  
              //             : Icons.sunny,
              //         ),
              //       // HourlyForecastingData(
              //       //   time: "12:00",
              //       //   temperature: "304.12",
              //       //   icon: Icons.cloud,
              //       // ), 
              //     ],
              //   ),
              // ),


              /// This technique uses listView.builder which is lazy loader 
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final hourlyForecastData = data['list'][index+1];
                    final time = DateTime.parse(hourlyForecastData['dt_txt']);
                    return HourlyForecastingData(
                      time: DateFormat.j().format(time).toString(),
                      temperature: (hourlyForecastData['main']['temp']-270).toStringAsFixed(2),
                      icon: hourlyForecastData['weather'][0]['main'] == 'Clouds' || hourlyForecastData['weather'][0]['main'] == 'Rainy' 
                            ? Icons.cloud  
                            : Icons.sunny,
                    );
                  },
                ),
              ),

            ],  // children
          ),
        );
        },
      ),
    );
  } 
}
