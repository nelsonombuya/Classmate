import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'assignment_model.dart';
import 'unit_details_model.dart';

class Unit extends Equatable {
  final String? id;
  final String? sessionId;
  final UnitDetails? unitDetails;
  final List<Assignment>? assignments;

  const Unit({
    this.id,
    this.assignments,
    required this.sessionId,
    required this.unitDetails,
  });

  Unit copyWith({
    String? id,
    String? sessionId,
    UnitDetails? unitDetails,
    List<Assignment>? assignments,
  }) {
    return Unit(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      unitDetails: unitDetails ?? this.unitDetails,
      assignments: assignments ?? this.assignments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sessionId': sessionId,
      'unitDetails': unitDetails?.toMap(),
      'assignments': assignments?.map((x) => x.toMap()).toList(),
    };
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['id'],
      sessionId: map['sessionId'],
      unitDetails: UnitDetails.fromMap(map['unitDetails'] ?? {}),
      assignments: List<Assignment>.from(
          map['assignments']?.map((x) => Assignment.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Unit.fromJson(String source) => Unit.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id ?? 'No Unit ID',
        unitDetails ?? 'No Unit Details',
        sessionId ?? 'No Session ID',
        assignments ?? 'No Assignments',
      ];
}
