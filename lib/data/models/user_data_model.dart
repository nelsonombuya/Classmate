import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserDataModel {
  String? year;
  String? firstName;
  String? lastName;
  DocumentReference? course;
  List<DocumentReference>? registeredUnits;
  UserDataModel({
    this.firstName,
    this.lastName,
    this.registeredUnits,
    this.course,
    this.year,
  });

  UserDataModel copyWith({
    String? firstName,
    String? lastName,
    List<DocumentReference>? registeredUnits,
    DocumentReference? course,
    String? year,
  }) {
    return UserDataModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      registeredUnits: registeredUnits ?? this.registeredUnits,
      course: course ?? this.course,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'registeredUnits': registeredUnits,
      'course': course,
      'year': year,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      registeredUnits: map['registeredUnits']?.cast<DocumentReference>(),
      course: map['course'],
      year: map['year'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserDataModel(firstName: $firstName, lastName: $lastName, registeredUnits: $registeredUnits, course: $course, year: $year)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDataModel &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        listEquals(other.registeredUnits, registeredUnits) &&
        other.course == course &&
        other.year == year;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        registeredUnits.hashCode ^
        course.hashCode ^
        year.hashCode;
  }
}
