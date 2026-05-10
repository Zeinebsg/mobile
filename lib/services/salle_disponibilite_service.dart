import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SalleDisponibiliteService {
  static const int TEMPS_NETTOYAGE_MINUTES = 15;
  
  // Mettre à jour la disponibilité d'une salle spécifique
  static Future<void> updateSalleDisponibilite(String salleId) async {
    final now = DateTime.now();
    final nowPlus12 = now.add(Duration(hours: 12));
    
    // Chercher les séances futures dans les 12 prochaines heures
    final seances = await FirebaseFirestore.instance
        .collection('seances')
        .where('salleId', isEqualTo: salleId)
        .where('dateTime', isGreaterThanOrEqualTo: now)
        .where('dateTime', isLessThanOrEqualTo: nowPlus12)
        .orderBy('dateTime')
        .get();
    
    bool disponible = true;
    String messageDisponibilite = 'Salle disponible';
    
    if (seances.docs.isNotEmpty) {
      final premiereSeance = seances.docs.first.data() as Map<String, dynamic>;
      final debutSeance = (premiereSeance['dateTime'] as Timestamp).toDate();
      final dureeFilm = premiereSeance['duree'] ?? 150; // durée en minutes
      
      // Fin de la séance + temps de nettoyage
      final finDisponible = debutSeance.add(Duration(minutes: dureeFilm + TEMPS_NETTOYAGE_MINUTES));
      
      if (now.isBefore(finDisponible)) {
        disponible = false;
        messageDisponibilite = 'Salle occupée jusqu\'à ${finDisponible.hour}h${finDisponible.minute}';
      }
    }
    
    // Mettre à jour Firestore
    await FirebaseFirestore.instance
        .collection('salles')
        .doc(salleId)
        .update({
          'disponibility': disponible,
          'disponibleMessage': messageDisponibilite,
          'derniereVerification': FieldValue.serverTimestamp(),
        });
  }
  
  // Mettre à jour TOUTES les salles
  static Future<void> updateAllSallesDisponibilite() async {
    final salles = await FirebaseFirestore.instance.collection('salles').get();
    
    for (var salle in salles.docs) {
      await updateSalleDisponibilite(salle.id);
    }
  }
  
  // Vérifier si une salle est disponible pour une nouvelle séance
  static Future<bool> isSalleDisponiblePourNouvelleSeance(
    String salleId,
    DateTime dateTimeSeance,
    int dureeFilmMinutes,
  ) async {
    final debutSeance = dateTimeSeance;
    final finSeanceAvecNettoyage = debutSeance.add(Duration(
      minutes: dureeFilmMinutes + TEMPS_NETTOYAGE_MINUTES
    ));
    
    // Rechercher les séances existantes qui chevauchent
    final seancesConflictuelles = await FirebaseFirestore.instance
        .collection('seances')
        .where('salleId', isEqualTo: salleId)
        .where('dateTime', isLessThan: finSeanceAvecNettoyage)
        .where('dateTime', isGreaterThanOrEqualTo: debutSeance.subtract(Duration(hours: 12)))
        .get();
    
    for (var doc in seancesConflictuelles.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final seanceDebut = (data['dateTime'] as Timestamp).toDate();
      final duree = data['duree'] ?? 150;
      final seanceFin = seanceDebut.add(Duration(minutes: duree + TEMPS_NETTOYAGE_MINUTES));
      
      if (finSeanceAvecNettoyage.isAfter(seanceDebut) && 
          debutSeance.isBefore(seanceFin)) {
        return false; // Conflit, salle non disponible
      }
    }
    
    return true;
  }
  
  // Obtenir le message de disponibilité d'une salle
  static Future<String> getDisponibiliteMessage(String salleId) async {
    final salleDoc = await FirebaseFirestore.instance
        .collection('salles')
        .doc(salleId)
        .get();
    
    if (salleDoc.exists) {
      final data = salleDoc.data() as Map<String, dynamic>;
      final isDispo = data['disponibility'] ?? true;
      final message = data['disponibleMessage'] ?? '';
      
      if (isDispo) {
        return '✅ Salle disponible';
      }
      return '🔴 $message';
    }
    
    return '❌ Salle non trouvée';
  }
}