import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FilmRecord extends FirestoreRecord {
  FilmRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "titre" field.
  String? _titre;
  String get titre => _titre ?? '';
  bool hasTitre() => _titre != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "annee_sortie" field.
  int? _anneeSortie;
  int get anneeSortie => _anneeSortie ?? 0;
  bool hasAnneeSortie() => _anneeSortie != null;

  // "realisateur" field.
  String? _realisateur;
  String get realisateur => _realisateur ?? '';
  bool hasRealisateur() => _realisateur != null;

  // "acteurs" field.
  String? _acteurs;
  String get acteurs => _acteurs ?? '';
  bool hasActeurs() => _acteurs != null;

  // "genre" field.
  String? _genre;
  String get genre => _genre ?? '';
  bool hasGenre() => _genre != null;

  // "affiche_url" field.
  String? _afficheUrl;
  String get afficheUrl => _afficheUrl ?? '';
  bool hasAfficheUrl() => _afficheUrl != null;

  void _initializeFields() {
    _titre = snapshotData['titre'] as String?;
    _description = snapshotData['description'] as String?;
    _anneeSortie = castToType<int>(snapshotData['annee_sortie']);
    _realisateur = snapshotData['realisateur'] as String?;
    _acteurs = snapshotData['acteurs'] as String?;
    _genre = snapshotData['genre'] as String?;
    _afficheUrl = snapshotData['affiche_url'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('film');

  static Stream<FilmRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FilmRecord.fromSnapshot(s));

  static Future<FilmRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FilmRecord.fromSnapshot(s));

  static FilmRecord fromSnapshot(DocumentSnapshot snapshot) => FilmRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FilmRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FilmRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FilmRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FilmRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFilmRecordData({
  String? titre,
  String? description,
  int? anneeSortie,
  String? realisateur,
  String? acteurs,
  String? genre,
  String? afficheUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'titre': titre,
      'description': description,
      'annee_sortie': anneeSortie,
      'realisateur': realisateur,
      'acteurs': acteurs,
      'genre': genre,
      'affiche_url': afficheUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class FilmRecordDocumentEquality implements Equality<FilmRecord> {
  const FilmRecordDocumentEquality();

  @override
  bool equals(FilmRecord? e1, FilmRecord? e2) {
    return e1?.titre == e2?.titre &&
        e1?.description == e2?.description &&
        e1?.anneeSortie == e2?.anneeSortie &&
        e1?.realisateur == e2?.realisateur &&
        e1?.acteurs == e2?.acteurs &&
        e1?.genre == e2?.genre &&
        e1?.afficheUrl == e2?.afficheUrl;
  }

  @override
  int hash(FilmRecord? e) => const ListEquality().hash([
        e?.titre,
        e?.description,
        e?.anneeSortie,
        e?.realisateur,
        e?.acteurs,
        e?.genre,
        e?.afficheUrl
      ]);

  @override
  bool isValidKey(Object? o) => o is FilmRecord;
}
