import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SessionDetails extends Equatable {
  final String? id;
  final String? name;
  final DateTime? startDate;
  final DateTime? endDate;

  const SessionDetails({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
  });

  SessionDetails copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return SessionDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
    };
  }

  factory SessionDetails.fromMap(Map<String, dynamic> map) {
    return SessionDetails(
      id: map['id'],
      name: map['name'],
      startDate: map['startDate'] == null
          ? DateTime.now()
          : map['startDate'] is Timestamp
              ? map['startDate'].toDate()
              : DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: map['endDate'] == null
          ? DateTime.now()
          : map['endDate'] is Timestamp
              ? map['endDate'].toDate()
              : DateTime.fromMillisecondsSinceEpoch(map['endDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionDetails.fromJson(String source) =>
      SessionDetails.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id ?? 'No Session ID Set',
        name ?? 'No Session Name Set',
        startDate ?? 'No Start Date Set',
        endDate ?? 'No End Date Set',
      ];
}
