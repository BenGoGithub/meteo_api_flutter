import 'package:flutter/material.dart';
import 'package:flutter_json_viewer/flutter_json_viewer.dart';
import 'meteo_api.dart';

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
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: JsonViewer(snapshot.data!),
            );
          }
          return const Center(child: Text('Aucune donnée'));
        },
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: HomePage()));
