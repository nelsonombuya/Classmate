import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? courseId;
  final String? schoolId;
  final String? sessionId;
  final String? year;
  final List<String>? registeredUnitIds;

  const UserDataModel({
    this.firstName,
    this.lastName,
    this.courseId,
    this.schoolId,
    this.sessionId,
    this.year,
    this.registeredUnitIds,
  });

  UserDataModel copyWith({
    String? firstName,
    String? lastName,
    String? courseId,
    String? schoolId,
    String? sessionId,
    String? year,
    List<String>? registeredUnitIds,
  }) {
    return UserDataModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      courseId: courseId ?? this.courseId,
      schoolId: schoolId ?? this.schoolId,
      sessionId: sessionId ?? this.sessionId,
      year: year ?? this.year,
      registeredUnitIds: registeredUnitIds ?? this.registeredUnitIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'courseId': courseId,
      'schoolId': schoolId,
      'sessionId': sessionId,
      'year': year,
      'registeredUnitIds': registeredUnitIds,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      courseId: map['courseId'],
      schoolId: map['schoolId'],
      sessionId: map['sessionId'],
      year: map['year'],
      registeredUnitIds: List<String>.from(map['registeredUnitIds'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      "First Name: ${firstName ?? '-'}",
      "Last Name: ${lastName ?? '-'}",
      "School ID: ${schoolId ?? '-'}",
      "Course ID: ${courseId ?? '-'}",
      "Session ID: ${sessionId ?? '-'}",
      "Year: ${year ?? '-'}",
      "Registered Units: ${registeredUnitIds ?? '-'}",
    ];
  }
}
