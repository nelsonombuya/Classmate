import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UnitModel extends Equatable {
  final String? id;
  final String? name;
  final String? code;
  final DateTime? examStartDate;
  final DateTime? examEndDate;

  const UnitModel({
    this.id,
    this.name,
    this.code,
    this.examStartDate,
    this.examEndDate,
  });

  UnitModel copyWith({
    String? id,
    String? name,
    String? code,
    DateTime? examStartDate,
    DateTime? examEndDate,
  }) {
    return UnitModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      examStartDate: examStartDate ?? this.examStartDate,
      examEndDate: examEndDate ?? this.examEndDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'examStartDate': examStartDate?.millisecondsSinceEpoch,
      'examEndDate': examEndDate?.millisecondsSinceEpoch,
    };
  }

  factory UnitModel.fromMap(Map<String, dynamic> map) {
    return UnitModel(
      id: map['id'],
      name: map['name'],
      code: map['code'],
      examStartDate: map['examStartDate'] == null
          ? null
          : map['examStartDate'] is Timestamp
              ? map['examStartDate'].toDate()
              : DateTime.fromMillisecondsSinceEpoch(map['examStartDate']),
      examEndDate: map['examEndDate'] == null
          ? null
          : map['examEndDate'] is Timestamp
              ? map['examEndDate'].toDate()
              : DateTime.fromMillisecondsSinceEpoch(map['examEndDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UnitModel.fromJson(String source) =>
      UnitModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id ?? '-',
      name ?? '-',
      code ?? '-',
      examStartDate ?? '-',
      examEndDate ?? '-',
    ];
  }
}
