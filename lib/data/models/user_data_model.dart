import 'dart:convert';

class UserDataModel {
  String firstName;
  String lastName;
  List? registeredUnits;

  UserDataModel({
    required this.firstName,
    required this.lastName,
    this.registeredUnits,
  });

  UserDataModel copyWith({
    String? firstName,
    String? lastName,
    List? registeredUnits,
  }) {
    return UserDataModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      registeredUnits: registeredUnits ?? this.registeredUnits,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'registeredUnits': registeredUnits,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      registeredUnits: map['registeredUnits'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserDataModel(firstName: $firstName, lastName: $lastName, registeredUnits: $registeredUnits)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDataModel &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.registeredUnits == registeredUnits;
  }

  @override
  int get hashCode =>
      firstName.hashCode ^ lastName.hashCode ^ registeredUnits.hashCode;
}
