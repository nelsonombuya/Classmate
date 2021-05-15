import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

import 'package:classmate/data/models/unit_model.dart';

class LessonModel extends Equatable {
  final String? id;
  final UnitModel unit;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;

  const LessonModel({
    this.id,
    required this.unit,
    this.description,
    required this.startDate,
    required this.endDate,
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
      'unit': unit.toMap(),
      'description': description,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
    };
  }

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    try {
      return LessonModel(
        id: map['id'],
        description: map['description'],
        unit: UnitModel.fromMap(map['unit']),
        startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
        endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      );
    } on TypeError catch (e) {
      Logger logger = Logger();
      logger.w("${e.toString()}");
      logger.w(
          "The DateTime variables used Firebase's Timestamp instead of the preferred MillisecondsSinceEpoch");
      logger.w(
          "NOTE: The program will still run and the value will be updated to MillisecondsSinceEpoch when this variable is updated in the database");
      return LessonModel(
        id: map['id'],
        description: map['description'],
        unit: UnitModel.fromMap(map['unit']),
        startDate: map['startDate'].toDate(),
        endDate: map['endDate'].toDate(),
      );
    }
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
      unit,
      description ?? 'No Description',
      startDate,
      endDate,
    ];
  }
}
