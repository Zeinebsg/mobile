import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FilmsRecord extends FirestoreRecord {
  FilmsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "desription" field.
  String? _desription;
  String get desription => _desription ?? '';
  bool hasDesription() => _desription != null;

  // "releaseDate" field.
  DateTime? _releaseDate;
  DateTime? get releaseDate => _releaseDate;
  bool hasReleaseDate() => _releaseDate != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "duree" field.
  String? _duree;
  String get duree => _duree ?? '';
  bool hasDuree() => _duree != null;

  // "realisateur" field.
  String? _realisateur;
  String get realisateur => _realisateur ?? '';
  bool hasRealisateur() => _realisateur != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _desription = snapshotData['desription'] as String?;
    _releaseDate = snapshotData['releaseDate'] as DateTime?;
    _image = snapshotData['image'] as String?;
    _duree = snapshotData['duree'] as String?;
    _realisateur = snapshotData['realisateur'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('films');

  static Stream<FilmsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FilmsRecord.fromSnapshot(s));

  static Future<FilmsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FilmsRecord.fromSnapshot(s));

  static FilmsRecord fromSnapshot(DocumentSnapshot snapshot) => FilmsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FilmsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FilmsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FilmsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FilmsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFilmsRecordData({
  String? title,
  String? desription,
  DateTime? releaseDate,
  String? image,
  String? duree,
  String? realisateur,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'desription': desription,
      'releaseDate': releaseDate,
      'image': image,
      'duree': duree,
      'realisateur': realisateur,
    }.withoutNulls,
  );

  return firestoreData;
}

class FilmsRecordDocumentEquality implements Equality<FilmsRecord> {
  const FilmsRecordDocumentEquality();

  @override
  bool equals(FilmsRecord? e1, FilmsRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.desription == e2?.desription &&
        e1?.releaseDate == e2?.releaseDate &&
        e1?.image == e2?.image &&
        e1?.duree == e2?.duree &&
        e1?.realisateur == e2?.realisateur;
  }

  @override
  int hash(FilmsRecord? e) => const ListEquality().hash([
        e?.title,
        e?.desription,
        e?.releaseDate,
        e?.image,
        e?.duree,
        e?.realisateur
      ]);

  @override
  bool isValidKey(Object? o) => o is FilmsRecord;
}
