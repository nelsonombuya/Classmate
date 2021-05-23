import 'dart:convert';

import 'package:equatable/equatable.dart';

class UnitDetails extends Equatable {
  final String? name;
  final List<String>? codes;

  const UnitDetails({
    this.name,
    this.codes,
  });

  UnitDetails copyWith({
    String? name,
    List<String>? codes,
  }) {
    return UnitDetails(
      name: name ?? this.name,
      codes: codes ?? this.codes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'codes': codes,
    };
  }

  factory UnitDetails.fromMap(Map<String, dynamic> map) {
    return UnitDetails(
      name: map['name'],
      codes: List<String>.from(map['codes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UnitDetails.fromJson(String source) =>
      UnitDetails.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props =>
      [name ?? 'No UnitDetails Name', codes ?? 'No UnitDetails Codes'];
}
