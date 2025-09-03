class MeteoHourly {
  final DateTime dateTime;
  final double temperature;  // en K ou convertie en °C
  final double pression;
  final double humidite;
  final double ventMoyen;
  final double ventDirection;

  MeteoHourly({
    required this.dateTime,
    required this.temperature,
    required this.pression,
    required this.humidite,
    required this.ventMoyen,
    required this.ventDirection,
  });

  factory MeteoHourly.fromJson(String key, Map<String, dynamic> json) {
    return MeteoHourly(
      dateTime: DateTime.parse(key),
      temperature: (json['temperature']?['2m'] ?? 0).toDouble(),
      pression: (json['pression']?['niveau_de_la_mer'] ?? 0).toDouble(),
      humidite: (json['humidite']?['2m'] ?? 0).toDouble(),
      ventMoyen: (json['vent_moyen']?['10m'] ?? 0).toDouble(),
      ventDirection: (json['vent_direction']?['10m'] ?? 0).toDouble(),
    );
  }
}
