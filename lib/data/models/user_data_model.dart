import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? displayName;
  final String? course;
  final List<String>? registeredUnits;

  const UserDataModel({
    this.firstName,
    this.lastName,
    this.displayName,
    this.course,
    this.registeredUnits,
  });

  UserDataModel copyWith({
    String? firstName,
    String? lastName,
    String? displayName,
    String? course,
    List<String>? registeredUnits,
  }) {
    return UserDataModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      displayName: displayName ?? this.displayName,
      course: course ?? this.course,
      registeredUnits: registeredUnits ?? this.registeredUnits,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
      'course': course,
      'registeredUnits': registeredUnits,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      displayName: map['displayName'],
      course: map['course'],
      registeredUnits: List<String>.from(map['registeredUnits']),
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
      firstName ?? '-',
      lastName ?? '-',
      displayName ?? '-',
      course ?? '-',
      registeredUnits ?? '-',
    ];
  }
}
