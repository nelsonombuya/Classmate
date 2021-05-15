import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:classmate/data/models/unit_model.dart';

class AssignmentModel extends Equatable {
  final String? id;
  final UnitModel? unit;
  final String? title;
  final String? description;
  final DateTime? dueDate;
  final bool? isDone;

  const AssignmentModel({
    this.id,
    this.unit,
    this.title,
    this.description,
    this.dueDate,
    this.isDone,
  });

  AssignmentModel copyWith({
    String? id,
    UnitModel? unit,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isDone,
  }) {
    return AssignmentModel(
      id: id ?? this.id,
      unit: unit ?? this.unit,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unit': unit?.toMap(),
      'title': title,
      'description': description,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }

  factory AssignmentModel.fromMap(Map<String, dynamic> map) {
    return AssignmentModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isDone: map['isDone'],
      dueDate: map['dueDate'] == null
          ? null
          : map['dueDate'] is Timestamp
              ? map['dueDate'].toDate()
              : DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
      unit: map['unit'] == null ? UnitModel() : UnitModel.fromMap(map['unit']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignmentModel.fromJson(String source) =>
      AssignmentModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id ?? '-',
      unit ?? '-',
      title ?? '-',
      description ?? '-',
      dueDate ?? '-',
      isDone ?? '-',
    ];
  }
}
