import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? courseId;
  final String? schoolId;
  final String? sessionId;
  final String? year;
  final String? semester;
  final String? privilege;
  final List<String>? registeredUnitIds;

  const UserData({
    this.firstName,
    this.lastName,
    this.courseId,
    this.schoolId,
    this.sessionId,
    this.semester,
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
    String? semester,
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
      semester: semester ?? this.semester,
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
      'semester': semester,
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
      semester: map['semester'],
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
      firstName ?? 'No First Name',
      lastName ?? 'No Last Name',
      courseId ?? 'No Registered Course',
      schoolId ?? 'No Registered SchoolID',
      sessionId ?? 'No Registered Session',
      semester ?? 'No Registered Semester',
      year ?? 'No Registered Year',
      privilege ?? 'User',
      registeredUnitIds ?? 'No Registered Units',
    ];
  }
}
