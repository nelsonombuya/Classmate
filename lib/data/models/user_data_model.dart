import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? courseId;
  final String? schoolId;
  final String? year;
  final List<String>? registeredUnitCodes;

  const UserDataModel({
    this.firstName,
    this.lastName,
    this.courseId,
    this.schoolId,
    this.year,
    this.registeredUnitCodes,
  });

  UserDataModel copyWith({
    String? firstName,
    String? lastName,
    String? courseId,
    String? schoolId,
    String? year,
    List<String>? registeredUnitCodes,
  }) {
    return UserDataModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      courseId: courseId ?? this.courseId,
      schoolId: schoolId ?? this.schoolId,
      year: year ?? this.year,
      registeredUnitCodes: registeredUnitCodes ?? this.registeredUnitCodes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'courseId': courseId,
      'schoolId': schoolId,
      'year': year,
      'registeredUnitCodes': registeredUnitCodes,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      courseId: map['courseId'],
      schoolId: map['schoolId'],
      year: map['year'],
      registeredUnitCodes: List<String>.from(map['registeredUnitCodes'] ?? []),
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
      "Year: ${year ?? '-'}",
      "Registered Units: ${registeredUnitCodes ?? '-'}",
    ];
  }
}
