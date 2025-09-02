import 'dart:convert';
import 'package:http/http.dart' as http;

class MeteoApi {
  static Future<Map<String, dynamic>> fetchMeteo() async {
    final url = Uri.parse('http://www.infoclimat.fr/public-api/gfs/json?_ll=48.85341,2.3488&_auth=VU9UQ1EvXH5UeVZhAXcKI1M7DzpaLAUiAn4HZFs%2BVClWPQNiDm5dOwRqA34AL1VjUn8EZwswATEDaFYuCngEZVU%2FVDhROlw7VDtWMwEuCiFTfQ9uWnoFIgJjB35bMVQpVjQDYw5lXSEEbANiAC9VflJgBGMLMQE%2FA2hWMQphBGZVNVQ5US1cIVQ9VjwBYwo4UzIPPVozBW8CYAczW2VUZlZjA2EOc108BG4DaAA1VWRSaARmCzYBJgN%2FVkgKFAR6VXZUclFnXHhUJlZhAW8Kag%3D%3D&_c=a679cdbe54cb9e4c97787772ebd57685');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erreur de chargement météo');
    }
  }
}
