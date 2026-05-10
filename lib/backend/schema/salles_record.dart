import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SallesRecord extends FirestoreRecord {
  SallesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "number" field.
  int? _number;
  int get number => _number ?? 0;
  bool hasNumber() => _number != null;

  // "capacity" field.
  int? _capacity;
  int get capacity => _capacity ?? 0;
  bool hasCapacity() => _capacity != null;

  // "disponibility" field.
  bool? _disponibility;
  bool get disponibility => _disponibility ?? false;
  bool hasDisponibility() => _disponibility != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _number = castToType<int>(snapshotData['number']);
    _capacity = castToType<int>(snapshotData['capacity']);
    _disponibility = snapshotData['disponibility'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('salles');

  static Stream<SallesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SallesRecord.fromSnapshot(s));

  static Future<SallesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SallesRecord.fromSnapshot(s));

  static SallesRecord fromSnapshot(DocumentSnapshot snapshot) => SallesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SallesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SallesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SallesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SallesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSallesRecordData({
  String? name,
  int? number,
  int? capacity,
  bool? disponibility,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'number': number,
      'capacity': capacity,
      'disponibility': disponibility,
    }.withoutNulls,
  );

  return firestoreData;
}

class SallesRecordDocumentEquality implements Equality<SallesRecord> {
  const SallesRecordDocumentEquality();

  @override
  bool equals(SallesRecord? e1, SallesRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.number == e2?.number &&
        e1?.capacity == e2?.capacity &&
        e1?.disponibility == e2?.disponibility;
  }

  @override
  int hash(SallesRecord? e) => const ListEquality()
      .hash([e?.name, e?.number, e?.capacity, e?.disponibility]);

  @override
  bool isValidKey(Object? o) => o is SallesRecord;
}
