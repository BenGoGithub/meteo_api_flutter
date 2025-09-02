import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'dart:io';

class MeteoApi {
  static Future<Map<String, dynamic>>? _currentRequest;

  // Client natif selon plateforme (mobile/desktop ou web)
  static http.Client getClient() {
    if (!kIsWeb) {
      return IOClient(HttpClient());
    }
    return http.Client();
  }

  // Méthode interne pour fetcher la météo avec retry
  static Future<Map<String, dynamic>> _fetchMeteoWithRetry({int retries = 3, Duration delay = const Duration(seconds: 2)}) async {
    for (int attempt = 1; attempt <= retries; attempt++) {
      try {
        final client = getClient();
        final url = Uri.parse('http://www.infoclimat.fr/public-api/gfs/json?_ll=48.85341,2.3488&_auth=VU9UQ1EvXH5UeVZhAXcKI1M7DzpaLAUiAn4HZFs%2BVClWPQNiDm5dOwRqA34AL1VjUn8EZwswATEDaFYuCngEZVU%2FVDhROlw7VDtWMwEuCiFTfQ9uWnoFIgJjB35bMVQpVjQDYw5lXSEEbANiAC9VflJgBGMLMQE%2FA2hWMQphBGZVNVQ5US1cIVQ9VjwBYwo4UzIPPVozBW8CYAczW2VUZlZjA2EOc108BG4DaAA1VWRSaARmCzYBJgN%2FVkgKFAR6VXZUclFnXHhUJlZhAW8Kag%3D%3D&_c=a679cdbe54cb9e4c97787772ebd57685');
        final response = await client.get(url);
        if (response.statusCode == 200) {
          return json.decode(response.body);
        }
        throw Exception('Erreur HTTP : ${response.statusCode}');
      } catch (e) {
        if (attempt == retries) rethrow; // toutes tentatives échouées
        await Future.delayed(delay * attempt); // délai avant tentative suivante
      }
    }
    throw Exception('Impossible d’obtenir la météo');
  }

  // Méthode publique avec annulation/ignoration des requêtes concurrentes
  static Future<Map<String, dynamic>> fetchMeteoCancelable() {
    if (_currentRequest != null) {
      // Ignore la nouvelle requête si une autre est en cours
      return _currentRequest!;
    }
    _currentRequest = _fetchMeteoWithRetry().whenComplete(() {
      _currentRequest = null; // reset la requête en cours quand terminée
    });
    return _currentRequest!;
  }
}