import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:classmate/data/models/unit_model.dart';

class LessonModel extends Equatable {
  final String? id;
  final UnitModel? unit;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;

  const LessonModel({
    this.id,
    this.unit,
    this.description,
    this.startDate,
    this.endDate,
  });

  LessonModel copyWith({
    String? id,
    UnitModel? unit,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return LessonModel(
      id: id ?? this.id,
      unit: unit ?? this.unit,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unit': unit?.toMap(),
      'description': description,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
    };
  }

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      id: map['id'],
      description: map['description'],
      startDate: map['startDate'] == null
          ? null
          : map['startDate'] is Timestamp
              ? map['startDate'].toDate()
              : DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: map['endDate'] == null
          ? null
          : map['endDate'] is Timestamp
              ? map['endDate'].toDate()
              : DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      unit: map['unit'] == null ? UnitModel() : UnitModel.fromMap(map['unit']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LessonModel.fromJson(String source) =>
      LessonModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id ?? '-',
      unit ?? '-',
      description ?? '-',
      startDate ?? '-',
      endDate ?? '-',
    ];
  }
}
