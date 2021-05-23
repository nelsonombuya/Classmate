import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SessionDetails extends Equatable {
  final String? name;
  final DateTime? startDate;
  final DateTime? endDate;
  SessionDetails({
    this.name,
    this.startDate,
    this.endDate,
  });

  SessionDetails copyWith({
    String? name,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return SessionDetails(
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
    };
  }

  factory SessionDetails.fromMap(Map<String, dynamic> map) {
    return SessionDetails(
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
        name ?? 'No Name',
        startDate ?? 'No Start Date',
        endDate ?? 'No End Date',
      ];
}
