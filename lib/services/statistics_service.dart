import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ============================================================
  // 1. STATISTIQUES GLOBALES
  // ============================================================
  
  Future<Map<String, dynamic>> getGlobalStatistics() async {
    final seancesSnapshot = await _firestore.collection('seances').get();
    final seances = seancesSnapshot.docs;
    
    // Statistiques de base
    int totalSeances = seances.length;
    
    // Par format (VO/VF)
    Map<String, int> formatCount = {'VO': 0, 'VF': 0};
    
    // Par qualité (2D/3D)
    Map<String, int> qualityCount = {'2D': 0, '3D': 0};
    
    // Par salle
    Map<String, int> salleCount = {};
    
    // Par jour de semaine
    Map<String, int> jourCount = {
      'Lundi': 0, 'Mardi': 0, 'Mercredi': 0, 'Jeudi': 0,
      'Vendredi': 0, 'Samedi': 0, 'Dimanche': 0
    };
    
    // Par heure (tranches)
    Map<String, int> heureCount = {
      'Matin (8h-12h)': 0,
      'Midi (12h-14h)': 0,
      'Après-midi (14h-18h)': 0,
      'Soirée (18h-22h)': 0,
      'Nuit (22h-2h)': 0
    };
    
    // Films les plus projetés
    Map<String, int> filmCount = {};
    
    for (var doc in seances) {
      final data = doc.data();
      final dateTime = (data['dateTime'] as Timestamp?)?.toDate();
      final format = data['format'] as String? ?? 'VO';
      final quality = data['quality'] as String? ?? '2D';
      final salleName = data['salleName'] as String? ?? 'Inconnue';
      final filmName = data['filmName'] as String? ?? 'Inconnu';
      
      // Format
      formatCount[format.toUpperCase()] = (formatCount[format.toUpperCase()] ?? 0) + 1;
      
      // Qualité
      qualityCount[quality] = (qualityCount[quality] ?? 0) + 1;
      
      // Salle
      salleCount[salleName] = (salleCount[salleName] ?? 0) + 1;
      
      // Jour
      if (dateTime != null) {
        final jour = _getJourSemaine(dateTime.weekday);
        jourCount[jour] = (jourCount[jour] ?? 0) + 1;
        
        // Heure
        final heure = dateTime.hour;
        final tranche = _getTrancheHoraire(heure);
        heureCount[tranche] = (heureCount[tranche] ?? 0) + 1;
      }
      
      // Film
      filmCount[filmName] = (filmCount[filmName] ?? 0) + 1;
    }
    
    // Top 5 films
    final topFilms = filmCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top5Films = topFilms.take(5).map((e) => {'name': e.key, 'count': e.value}).toList();
    
    return {
      'totalSeances': totalSeances,
      'formatCount': formatCount,
      'qualityCount': qualityCount,
      'salleCount': salleCount,
      'jourCount': jourCount,
      'heureCount': heureCount,
      'top5Films': top5Films,
    };
  }
  
  // ============================================================
  // 2. STATISTIQUES PAR PÉRIODE
  // ============================================================
  
  Future<Map<String, dynamic>> getStatisticsByPeriod({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final seancesSnapshot = await _firestore
        .collection('seances')
        .where('dateTime', isGreaterThanOrEqualTo: startDate)
        .where('dateTime', isLessThanOrEqualTo: endDate)
        .get();
    
    final seances = seancesSnapshot.docs;
    
    // Statistiques par jour
    Map<String, int> dailyStats = {};
    
    // Répartition horaire
    Map<String, int> hourlyStats = {
      '8-10': 0, '10-12': 0, '12-14': 0, '14-16': 0,
      '16-18': 0, '18-20': 0, '20-22': 0, '22-24': 0
    };
    
    for (var doc in seances) {
      final data = doc.data();
      final dateTime = (data['dateTime'] as Timestamp?)?.toDate();
      
      if (dateTime != null) {
        final dateKey = '${dateTime.day}/${dateTime.month}';
        dailyStats[dateKey] = (dailyStats[dateKey] ?? 0) + 1;
        
        final hourKey = '${dateTime.hour}-${dateTime.hour + 2}';
        hourlyStats[hourKey] = (hourlyStats[hourKey] ?? 0) + 1;
      }
    }
    
    return {
      'totalSeances': seances.length,
      'dailyStats': dailyStats,
      'hourlyStats': hourlyStats,
      'period': '${startDate.day}/${startDate.month} - ${endDate.day}/${endDate.month}',
    };
  }
  
  // ============================================================
  // 3. DISPONIBILITÉ DES SALLES
  // ============================================================
  
  Future<Map<String, Map<String, List<Map<String, dynamic>>>>> getSallesDisponibilite({
    required DateTime date,
  }) async {
    // Récupérer toutes les salles
    final sallesSnapshot = await _firestore.collection('salles').get();
    final salles = sallesSnapshot.docs.map((doc) => {
      'id': doc.id,
      'name': doc.data()['name'] as String? ?? 'Salle ${doc.id.substring(0, 4)}',
    }).toList();
    
    // Récupérer les séances du jour
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    
    final seancesSnapshot = await _firestore
        .collection('seances')
        .where('dateTime', isGreaterThanOrEqualTo: startOfDay)
        .where('dateTime', isLessThan: endOfDay)
        .get();
    
    // Créer un planning pour chaque salle
    Map<String, Map<String, List<Map<String, dynamic>>>> planning = {};
    
    for (var salle in salles) {
      final salleId = salle['id'] as String;
      final salleName = salle['name'] as String;
      
      // Créer les créneaux horaires (8h à 23h par tranche de 1h)
      Map<String, List<Map<String, dynamic>>> horaires = {};
      
      for (int h = 8; h <= 22; h++) {
        final creneau = '$h:00 - ${h+1}:00';
        horaires[creneau] = [];
      }
      
      // Remplir avec les séances de cette salle
      for (var doc in seancesSnapshot.docs) {
        final data = doc.data();
        final salleRef = data['salleRef'] as DocumentReference?;
        
        if (salleRef != null && salleRef.id == salleId) {
          final dateTime = (data['dateTime'] as Timestamp?)?.toDate();
          if (dateTime != null) {
            final heure = dateTime.hour;
            final creneau = '$heure:00 - ${heure+1}:00';
            
            if (horaires.containsKey(creneau)) {
              horaires[creneau]!.add({
                'film': data['filmName'],
                'format': data['format'],
                'quality': data['quality'],
                'heure': '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}',
                'id': doc.id,
              });
            }
          }
        }
      }
      
      planning[salleName] = horaires;
    }
    
    return planning;
  }
  
  // ============================================================
  // 4. PLANNING HEBDOMADAIRE
  // ============================================================
  
  Future<Map<String, List<Map<String, dynamic>>>> getWeeklyPlanning({
    required DateTime startOfWeek,
  }) async {
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    
    final seancesSnapshot = await _firestore
        .collection('seances')
        .where('dateTime', isGreaterThanOrEqualTo: startOfWeek)
        .where('dateTime', isLessThan: endOfWeek)
        .orderBy('dateTime')
        .get();
    
    Map<String, List<Map<String, dynamic>>> weeklyPlanning = {};
    
    for (int i = 0; i < 7; i++) {
      final jour = startOfWeek.add(Duration(days: i));
      final jourKey = _getJourSemaine(jour.weekday);
      weeklyPlanning[jourKey] = [];
    }
    
    for (var doc in seancesSnapshot.docs) {
      final data = doc.data();
      final dateTime = (data['dateTime'] as Timestamp?)?.toDate();
      
      if (dateTime != null) {
        final jourKey = _getJourSemaine(dateTime.weekday);
        weeklyPlanning[jourKey]!.add({
          'heure': '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}',
          'film': data['filmName'],
          'salle': data['salleName'],
          'format': data['format'],
          'quality': data['quality'],
          'id': doc.id,
        });
      }
    }
    
    return weeklyPlanning;
  }
  
  // ============================================================
  // FONCTIONS UTILITAIRES
  // ============================================================
  
  String _getJourSemaine(int weekday) {
    const jours = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
    return jours[weekday - 1];
  }
  
  String _getTrancheHoraire(int heure) {
    if (heure >= 8 && heure < 12) return 'Matin (8h-12h)';
    if (heure >= 12 && heure < 14) return 'Midi (12h-14h)';
    if (heure >= 14 && heure < 18) return 'Après-midi (14h-18h)';
    if (heure >= 18 && heure < 22) return 'Soirée (18h-22h)';
    return 'Nuit (22h-2h)';
  }
}