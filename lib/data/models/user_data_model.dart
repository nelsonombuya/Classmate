import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? course;
  final String? schoolId;
  final String? session;
  final String? semester;
  final String? year;
  final String? privilege;
  final List<String>? registeredUnitIds;

  const UserData({
    this.firstName,
    this.lastName,
    this.course,
    this.schoolId,
    this.session,
    this.semester,
    this.year,
    this.privilege,
    this.registeredUnitIds,
  });

  UserData copyWith({
    String? firstName,
    String? lastName,
    String? course,
    String? schoolId,
    String? session,
    String? semester,
    String? year,
    String? privilege,
    List<String>? registeredUnitIds,
  }) {
    return UserData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      course: course ?? this.course,
      schoolId: schoolId ?? this.schoolId,
      session: session ?? this.session,
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
      'course': course,
      'schoolId': schoolId,
      'session': session,
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
      course: map['course'],
      schoolId: map['schoolId'],
      session: map['session'],
      semester: map['semester'],
      year: map['year'],
      privilege: map['privilege'],
      registeredUnitIds: List<String>.from(map['registeredUnitIds']),
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
      course ?? 'No Registered Course',
      schoolId ?? 'No Registered SchoolID',
      session ?? 'No Registered Session',
      semester ?? 'No Registered Semester',
      year ?? 'No Registered Year',
      privilege ?? 'User',
      registeredUnitIds ?? 'No Registered Units',
    ];
  }
}
