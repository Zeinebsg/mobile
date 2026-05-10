import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SeancesRecord extends FirestoreRecord {
  SeancesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "dateTime" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  // "reservedSeatts" field.
  int? _reservedSeatts;
  int get reservedSeatts => _reservedSeatts ?? 0;
  bool hasReservedSeatts() => _reservedSeatts != null;

  // "ownerId" field.
  DocumentReference? _ownerId;
  DocumentReference? get ownerId => _ownerId;
  bool hasOwnerId() => _ownerId != null;

  // "SalleRef" field.
  DocumentReference? _salleRef;
  DocumentReference? get salleRef => _salleRef;
  bool hasSalleRef() => _salleRef != null;

  // "format" field.
  String? _format;
  String get format => _format ?? '';
  bool hasFormat() => _format != null;

  // "quality" field.
  String? _quality;
  String get quality => _quality ?? '';
  bool hasQuality() => _quality != null;

  // "filmTitleLower" field.
  String? _filmTitleLower;
  String get filmTitleLower => _filmTitleLower ?? '';
  bool hasFilmTitleLower() => _filmTitleLower != null;

  // "filmName" field.
  String? _filmName;
  String get filmName => _filmName ?? '';
  bool hasFilmName() => _filmName != null;

  // "filmId" field.
  String? _filmId;
  String get filmId => _filmId ?? '';
  bool hasFilmId() => _filmId != null;

  void _initializeFields() {
    _dateTime = snapshotData['dateTime'] as DateTime?;
    _reservedSeatts = castToType<int>(snapshotData['reservedSeatts']);
    _ownerId = snapshotData['ownerId'] as DocumentReference?;
    _salleRef = snapshotData['SalleRef'] as DocumentReference?;
    _format = snapshotData['format'] as String?;
    _quality = snapshotData['quality'] as String?;
    _filmTitleLower = snapshotData['filmTitleLower'] as String?;
    _filmName = snapshotData['filmName'] as String?;
    _filmId = snapshotData['filmId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('seances');

  static Stream<SeancesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SeancesRecord.fromSnapshot(s));

  static Future<SeancesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SeancesRecord.fromSnapshot(s));

  static SeancesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SeancesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SeancesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SeancesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SeancesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  String? get salleName => null;

  @override
  bool operator ==(other) =>
      other is SeancesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;

  Object? toJson() {}
}

Map<String, dynamic> createSeancesRecordData({
  DateTime? dateTime,
  int? reservedSeatts,
  DocumentReference? ownerId,
  DocumentReference? salleRef,
  String? format,
  String? quality,
  String? filmTitleLower,
  String? filmName,
  String? filmId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'dateTime': dateTime,
      'reservedSeatts': reservedSeatts,
      'ownerId': ownerId,
      'SalleRef': salleRef,
      'format': format,
      'quality': quality,
      'filmTitleLower': filmTitleLower,
      'filmName': filmName,
      'filmId': filmId,
    }.withoutNulls,
  );

  return firestoreData;
}

class SeancesRecordDocumentEquality implements Equality<SeancesRecord> {
  const SeancesRecordDocumentEquality();

  @override
  bool equals(SeancesRecord? e1, SeancesRecord? e2) {
    return e1?.dateTime == e2?.dateTime &&
        e1?.reservedSeatts == e2?.reservedSeatts &&
        e1?.ownerId == e2?.ownerId &&
        e1?.salleRef == e2?.salleRef &&
        e1?.format == e2?.format &&
        e1?.quality == e2?.quality &&
        e1?.filmTitleLower == e2?.filmTitleLower &&
        e1?.filmName == e2?.filmName &&
        e1?.filmId == e2?.filmId;
  }

  @override
  int hash(SeancesRecord? e) => const ListEquality().hash([
        e?.dateTime,
        e?.reservedSeatts,
        e?.ownerId,
        e?.salleRef,
        e?.format,
        e?.quality,
        e?.filmTitleLower,
        e?.filmName,
        e?.filmId
      ]);

  @override
  bool isValidKey(Object? o) => o is SeancesRecord;
}
