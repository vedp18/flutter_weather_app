
import 'package:flutter/material.dart';

class HourlyForecastingData extends StatelessWidget {

  final String time;
  final String temperature;
  final IconData icon;

  const HourlyForecastingData({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
    });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 85,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              // overflow: TextOverflow.ellipsis,
            ),

            //spaces
            const SizedBox(
              height: 6,
            ),

            Icon(
              icon,
              size: 28,
            ),

            //spaces
            const SizedBox(
              height: 6,
            ),

            Text(
              "$temperature°C",
            )
          ],
        ),
      ),
    );
  }
}