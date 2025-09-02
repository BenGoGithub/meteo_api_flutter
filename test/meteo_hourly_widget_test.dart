import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meteo_api_flutter/widgets/meteo_hourly_widget.dart';
import 'package:meteo_api_flutter/meteo_hourly.dart';

void main() {
  testWidgets('MeteoHourlyWidget displays correct info', (WidgetTester tester) async {
    // Données fictives pour test
    final meteoTest = MeteoHourly(
      dateTime: DateTime.parse('2025-09-02 05:00:00'),
      temperature: 286.7,
      pression: 101020,
      humidite: 81.7,
      ventMoyen: 10.2,
    );

    // Construire le widget dans le test environment
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MeteoHourlyWidget(hour: meteoTest),
      ),
    ));

    // Recherche les textes affichés dans le widget
    expect(find.text('5h - 2/9'), findsOneWidget);
    expect(find.textContaining('T°: 13.6'), findsOneWidget); // 286.7 - 273.15 = 13.55 arrondi à 13.6
    expect(find.textContaining('Pression: 101020'), findsOneWidget);
    expect(find.textContaining('Vent moyen: 10.2'), findsOneWidget);
  });
}
