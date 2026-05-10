import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getWeatherWithPrecaution(String ville) async {
  const apiKey = 'f30874a9d31218b439a29e45a2a7fc3c';
  
  final url = Uri.parse(
    'https://api.openweathermap.org/data/2.5/weather?q=$ville&appid=$apiKey&units=metric&lang=fr'
  );
  
  try {
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      
      final temp = (data['main']['temp'] as num).toDouble();
      final condition = data['weather'][0]['description'] as String;
      final humidity = data['main']['humidity'];
      final windSpeed = data['wind']['speed'];
      final villeReelle = data['name'] as String;
      
      String messagePrecaution = '';
      String couleur = '#2196F3';
      String icone = '🌤️';
      
      if (temp <= 5) {
        messagePrecaution = '❄️ FROID INTENSE : Couvrez-vous bien avant de sortir !';
        couleur = '#00BCD4';
        icone = '❄️';
      } else if (temp >= 35) {
        messagePrecaution = '☀️ CANICULE : Hydratez-vous avant d\'aller au cinéma !';
        couleur = '#FF9800';
        icone = '☀️';
      } else if (condition.contains('pluie') || condition.contains('averse')) {
        messagePrecaution = '☔ PLUIE : Prenez un parapluie pour aller au cinéma !';
        couleur = '#4FC3F7';
        icone = '☔';
      } else if (condition.contains('orage')) {
        messagePrecaution = '⚡ ORAGE : Restez en sécurité, différez votre sortie !';
        couleur = '#F44336';
        icone = '⚡';
      } else if (windSpeed >= 15) {
        messagePrecaution = '💨 VENT FORT : Soyez prudent sur la route !';
        couleur = '#9E9E9E';
        icone = '💨';
      } else if (humidity >= 80) {
        messagePrecaution = '💧 AIR HUMIDE : Prévoyez une veste légère.';
        couleur = '#29B6F6';
        icone = '💧';
      } else if (temp >= 25 && temp <= 30) {
        messagePrecaution = '✅ Conditions parfaites pour le cinéma !';
        couleur = '#4CAF50';
        icone = '✅';
      } else if (condition.contains('soleil') || condition.contains('ciel dégagé')) {
        messagePrecaution = '😎 Beau temps ! Parfait pour une séance.';
        couleur = '#FFC107';
        icone = '😎';
      } else if (condition.contains('nuage')) {
        messagePrecaution = '☁️ Temps couvert mais parfait pour le cinéma !';
        couleur = '#78909C';
        icone = '☁️';
      } else {
        messagePrecaution = '🎬 Bonne séance de cinéma !';
        couleur = '#E50914';
        icone = '🎬';
      }
      
      return {
        'success': true,
        'ville': villeReelle,
        'temperature': temp.round(),
        'temperature_ressentie': (data['main']['feels_like'] as num).round(),
        'condition': condition,
        'humidite': humidity,
        'vent': windSpeed,
        'message': messagePrecaution,
        'couleur': couleur,
        'icone': icone,
        'icone_code': data['weather'][0]['icon'],
      };
    } else {
      return {
        'success': false,
        'message': '⚠️ Météo non disponible',
        'couleur': '#757575',
        'icone': '⚠️',
      };
    }
  } catch (e) {
    return {
      'success': false,
      'message': '❌ Erreur de connexion',
      'couleur': '#F44336',
      'icone': '❌',
    };
  }
}