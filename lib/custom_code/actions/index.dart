export 'get_film_name_from_id.dart' show getFilmNameFromId;
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getMovieDetails(String movieId) async {
  final apiKey = '81678c3f61130b7140ec8c6c51cab856';
  final url = 'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey&language=fr-FR';
  
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  } catch (e) {
    print('Erreur getMovieDetails: $e');
  }
  return {};
}