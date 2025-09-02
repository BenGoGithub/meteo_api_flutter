import 'package:flutter/material.dart';
import '../meteo_hourly.dart';

class MeteoHourlyWidget extends StatelessWidget {
  final MeteoHourly hour;

  const MeteoHourlyWidget({super.key, required this.hour});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        title: Text('${hour.dateTime.hour}h - ${hour.dateTime.day}/${hour.dateTime.month}'),
        subtitle: Text('T°: ${(hour.temperature - 273.15).toStringAsFixed(1)} °C, '
            'Pression: ${hour.pression} hPa, '
            'Vent: ${hour.ventMoyen} km/h'),
      ),
    );
  }
}
