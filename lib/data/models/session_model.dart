import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SessionModel extends Equatable {
  final String? id;
  final String? name;
  final DateTime? sessionStartDate;
  final DateTime? sessionEndDate;
  final DateTime? examStartDate;
  final DateTime? examEndDate;

  const SessionModel({
    this.id,
    this.name,
    this.sessionStartDate,
    this.sessionEndDate,
    this.examStartDate,
    this.examEndDate,
  });

  SessionModel copyWith({
    String? id,
    String? name,
    DateTime? sessionStartDate,
    DateTime? sessionEndDate,
    DateTime? examStartDate,
    DateTime? examEndDate,
  }) {
    return SessionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      sessionStartDate: sessionStartDate ?? this.sessionStartDate,
      sessionEndDate: sessionEndDate ?? this.sessionEndDate,
      examStartDate: examStartDate ?? this.examStartDate,
      examEndDate: examEndDate ?? this.examEndDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sessionStartDate': sessionStartDate?.millisecondsSinceEpoch,
      'sessionEndDate': sessionEndDate?.millisecondsSinceEpoch,
      'examStartDate': examStartDate?.millisecondsSinceEpoch,
      'examEndDate': examEndDate?.millisecondsSinceEpoch,
    };
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      id: map['id'],
      name: map['name'],
      sessionStartDate: map['sessionStartDate'] == null
          ? null
          : map['sessionStartDate'] is Timestamp
              ? map['sessionStartDate'].toDate()
              : DateTime.fromMillisecondsSinceEpoch(map['sessionStartDate']),
      sessionEndDate: map['sessionEndDate'] == null
          ? null
          : map['sessionEndDate'] is Timestamp
              ? map['sessionEndDate'].toDate()
              : DateTime.fromMillisecondsSinceEpoch(map['sessionEndDate']),
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

  factory SessionModel.fromJson(String source) =>
      SessionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SessionModel(sessionStartDate: $sessionStartDate, sessionEndDate: $sessionEndDate, examStartDate: $examStartDate, examEndDate: $examEndDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SessionModel &&
        other.sessionStartDate == sessionStartDate &&
        other.sessionEndDate == sessionEndDate &&
        other.examStartDate == examStartDate &&
        other.examEndDate == examEndDate;
  }

  @override
  int get hashCode {
    return sessionStartDate.hashCode ^
        sessionEndDate.hashCode ^
        examStartDate.hashCode ^
        examEndDate.hashCode;
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id ?? "-",
      name ?? "-",
      sessionStartDate ?? "-",
      sessionEndDate ?? "-",
      examStartDate ?? "-",
      examEndDate ?? "-",
    ];
  }
}
