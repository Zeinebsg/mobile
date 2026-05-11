import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BilletRecord extends FirestoreRecord {
  BilletRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "numeroSiege" field.
  String? _numeroSiege;
  String get numeroSiege => _numeroSiege ?? '';
  bool hasNumeroSiege() => _numeroSiege != null;

  // "prix" field.
  double? _prix;
  double get prix => _prix ?? 0.0;
  bool hasPrix() => _prix != null;

  // "statut" field.
  String? _statut;
  String get statut => _statut ?? '';
  bool hasStatut() => _statut != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "film" field.
  String? _film;
  String get film => _film ?? '';
  bool hasFilm() => _film != null;

  // "youtubeUrl" field.
  String? _youtubeUrl;
  String get youtubeUrl => _youtubeUrl ?? '';
  bool hasYoutubeUrl() => _youtubeUrl != null;

  // "imageUrl" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  void _initializeFields() {
    _numeroSiege = snapshotData['numeroSiege'] as String?;
    _prix = castToType<double>(snapshotData['prix']);
    _statut = snapshotData['statut'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _film = snapshotData['film'] as String?;
    _youtubeUrl = snapshotData['youtubeUrl'] as String?;
    _imageUrl = snapshotData['imageUrl'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('billet');

  static Stream<BilletRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BilletRecord.fromSnapshot(s));

  static Future<BilletRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BilletRecord.fromSnapshot(s));

  static BilletRecord fromSnapshot(DocumentSnapshot snapshot) => BilletRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BilletRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BilletRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BilletRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BilletRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBilletRecordData({
  String? numeroSiege,
  double? prix,
  String? statut,
  DateTime? createdTime,
  DocumentReference? userRef,
  String? film,
  String? youtubeUrl,
  String? imageUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'numeroSiege': numeroSiege,
      'prix': prix,
      'statut': statut,
      'created_time': createdTime,
      'user_ref': userRef,
      'film': film,
      'youtubeUrl': youtubeUrl,
      'imageUrl': imageUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class BilletRecordDocumentEquality implements Equality<BilletRecord> {
  const BilletRecordDocumentEquality();

  @override
  bool equals(BilletRecord? e1, BilletRecord? e2) {
    return e1?.numeroSiege == e2?.numeroSiege &&
        e1?.prix == e2?.prix &&
        e1?.statut == e2?.statut &&
        e1?.createdTime == e2?.createdTime &&
        e1?.userRef == e2?.userRef &&
        e1?.film == e2?.film &&
        e1?.youtubeUrl == e2?.youtubeUrl &&
        e1?.imageUrl == e2?.imageUrl;
  }

  @override
  int hash(BilletRecord? e) => const ListEquality().hash([
        e?.numeroSiege,
        e?.prix,
        e?.statut,
        e?.createdTime,
        e?.userRef,
        e?.film,
        e?.youtubeUrl,
        e?.imageUrl
      ]);

  @override
  bool isValidKey(Object? o) => o is BilletRecord;
}
