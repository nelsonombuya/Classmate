import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? courseId;
  final String? schoolId;
  final String? sessionId;
  final String? year;
  final String? privilege;
  final List<String>? registeredUnitIds;

  const UserData({
    this.firstName,
    this.lastName,
    this.courseId,
    this.schoolId,
    this.sessionId,
    this.year,
    this.privilege,
    this.registeredUnitIds,
  });

  UserData copyWith({
    String? firstName,
    String? lastName,
    String? courseId,
    String? schoolId,
    String? sessionId,
    String? year,
    String? privilege,
    List<String>? registeredUnitIds,
  }) {
    return UserData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      courseId: courseId ?? this.courseId,
      schoolId: schoolId ?? this.schoolId,
      sessionId: sessionId ?? this.sessionId,
      year: year ?? this.year,
      privilege: privilege ?? this.privilege,
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
      'privilege': privilege,
      'registeredUnitIds': registeredUnitIds,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      firstName: map['firstName'],
      lastName: map['lastName'],
      courseId: map['courseId'],
      schoolId: map['schoolId'],
      sessionId: map['sessionId'],
      year: map['year'],
      privilege: map['privilege'],
      registeredUnitIds: List<String>.from(map['registeredUnitIds'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      firstName ?? '-',
      lastName ?? '-',
      courseId ?? '-',
      schoolId ?? '-',
      sessionId ?? '-',
      year ?? '-',
      privilege ?? '-',
      registeredUnitIds ?? '-',
    ];
  }
}
