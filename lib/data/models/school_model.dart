import 'dart:convert';

import 'package:equatable/equatable.dart';

class SchoolModel extends Equatable {
  final String? id;
  final String name;

  const SchoolModel({
    this.id,
    required this.name,
  });

  SchoolModel copyWith({
    String? id,
    String? name,
  }) {
    return SchoolModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory SchoolModel.fromMap(Map<String, dynamic> map) {
    return SchoolModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SchoolModel.fromJson(String source) =>
      SchoolModel.fromMap(json.decode(source));

  @override
  String toString() => 'SchoolModel(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SchoolModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  static const SchoolModel empty = SchoolModel(name: '-');

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id ?? '-', name];
}
