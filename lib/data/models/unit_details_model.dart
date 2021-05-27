import 'dart:convert';

import 'package:equatable/equatable.dart';

class UnitDetails extends Equatable {
  final String id;
  final String name;
  final List<String>? codes;

  const UnitDetails({
    required this.id,
    required this.name,
    this.codes,
  });

  UnitDetails copyWith({
    String? id,
    String? name,
    List<String>? codes,
  }) {
    return UnitDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      codes: codes ?? this.codes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'codes': codes,
    };
  }

  factory UnitDetails.fromMap(Map<String, dynamic> map) {
    return UnitDetails(
      id: map['id'],
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
  List<Object> get props => [id, name, codes ?? 'No Unit Codes'];
}
