import 'package:flutter/material.dart';
import '../meteo_hourly.dart';
import 'wind_direction_icon.dart';

class MeteoHourlyWidget extends StatelessWidget {
  final MeteoHourly hour;

  const MeteoHourlyWidget({super.key, required this.hour});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade700,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: WindDirectionIcon(angleDegree: hour.ventDirection),
        title: Text('${hour.dateTime.hour}h - ${hour.dateTime.day}/${hour.dateTime.month}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('T°: ${(hour.temperature - 273.15).toStringAsFixed(1)} °C'),
            Text('Pression: ${hour.pression} hPa'),
            Text('Vent: ${hour.ventMoyen} km/h'),
            Text('Direction: ${hour.ventDirection}°'),
          ],
        ),
      ),
    );
  }
}
