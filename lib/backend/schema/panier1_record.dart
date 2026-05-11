import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class Panier1Record extends FirestoreRecord {
  Panier1Record._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "billet_ref" field.
  DocumentReference? _billetRef;
  DocumentReference? get billetRef => _billetRef;
  bool hasBilletRef() => _billetRef != null;

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "film" field.
  String? _film;
  String get film => _film ?? '';
  bool hasFilm() => _film != null;

  // "numeroSiege" field.
  String? _numeroSiege;
  String get numeroSiege => _numeroSiege ?? '';
  bool hasNumeroSiege() => _numeroSiege != null;

  // "prix" field.
  double? _prix;
  double get prix => _prix ?? 0.0;
  bool hasPrix() => _prix != null;

  // "youtubeUrl" field.
  String? _youtubeUrl;
  String get youtubeUrl => _youtubeUrl ?? '';
  bool hasYoutubeUrl() => _youtubeUrl != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  void _initializeFields() {
    _billetRef = snapshotData['billet_ref'] as DocumentReference?;
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _film = snapshotData['film'] as String?;
    _numeroSiege = snapshotData['numeroSiege'] as String?;
    _prix = castToType<double>(snapshotData['prix']);
    _youtubeUrl = snapshotData['youtubeUrl'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('panier1');

  static Stream<Panier1Record> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => Panier1Record.fromSnapshot(s));

  static Future<Panier1Record> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => Panier1Record.fromSnapshot(s));

  static Panier1Record fromSnapshot(DocumentSnapshot snapshot) =>
      Panier1Record._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static Panier1Record getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      Panier1Record._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'Panier1Record(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is Panier1Record &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPanier1RecordData({
  DocumentReference? billetRef,
  DocumentReference? userRef,
  String? film,
  String? numeroSiege,
  double? prix,
  String? youtubeUrl,
  DateTime? createdTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'billet_ref': billetRef,
      'user_ref': userRef,
      'film': film,
      'numeroSiege': numeroSiege,
      'prix': prix,
      'youtubeUrl': youtubeUrl,
      'created_time': createdTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class Panier1RecordDocumentEquality implements Equality<Panier1Record> {
  const Panier1RecordDocumentEquality();

  @override
  bool equals(Panier1Record? e1, Panier1Record? e2) {
    return e1?.billetRef == e2?.billetRef &&
        e1?.userRef == e2?.userRef &&
        e1?.film == e2?.film &&
        e1?.numeroSiege == e2?.numeroSiege &&
        e1?.prix == e2?.prix &&
        e1?.youtubeUrl == e2?.youtubeUrl &&
        e1?.createdTime == e2?.createdTime;
  }

  @override
  int hash(Panier1Record? e) => const ListEquality().hash([
        e?.billetRef,
        e?.userRef,
        e?.film,
        e?.numeroSiege,
        e?.prix,
        e?.youtubeUrl,
        e?.createdTime
      ]);

  @override
  bool isValidKey(Object? o) => o is Panier1Record;
}
