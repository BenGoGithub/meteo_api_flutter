import 'package:flutter/material.dart';
import 'meteo_api.dart';
import 'widgets/meteo_hourly_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Météo Grenoble')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: MeteoApi.fetchMeteoCancelable(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final hourlyList = MeteoApi.parseHourly(snapshot.data!);
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: hourlyList.length,
              itemBuilder: (context, index) {
                return MeteoHourlyWidget(hour: hourlyList[index]);
              },
            );
          }
          return const Center(child: Text('Aucune donnée'));
        },
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: HomePage()));
