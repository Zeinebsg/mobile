import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> fixAllSalles() async {
  // 1. Récupérer toutes les salles
  final salles = await FirebaseFirestore.instance.collection('salles').get();
  final Map<String, DocumentReference> salleRefs = {};
  
  for (var salle in salles.docs) {
    salleRefs[salle.id] = salle.reference;
    print('📌 Salle: ${salle.id} → ${salle.data()['name']}');
  }
  
  // 2. Récupérer toutes les séances
  final seances = await FirebaseFirestore.instance.collection('seances').get();
  int count = 0;
  
  for (var seance in seances.docs) {
    final data = seance.data();
    final String? salleId = data['salleId'];
    
    if (salleId != null && salleRefs.containsKey(salleId)) {
      // Ajouter salleRef si absent
      if (data['salleRef'] == null) {
        await seance.reference.update({
          'salleRef': salleRefs[salleId],
        });
        count++;
        print('✅ Ajouté salleRef pour ${seance.id}');
      }
    }
  }
  
  print('✨ Terminé! $count séances corrigées.');
}