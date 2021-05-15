import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

class UnitModel extends Equatable {
  final String? id;
  final String? name;
  final String? code;
  final DateTime? examStartDate;
  final DateTime? examEndDate;
  UnitModel({
    this.id,
    this.name,
    this.code,
    this.examStartDate,
    this.examEndDate,
  });

  UnitModel copyWith({
    String? id,
    String? name,
    String? code,
    DateTime? examStartDate,
    DateTime? examEndDate,
  }) {
    return UnitModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      examStartDate: examStartDate ?? this.examStartDate,
      examEndDate: examEndDate ?? this.examEndDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'examStartDate': examStartDate?.millisecondsSinceEpoch,
      'examEndDate': examEndDate?.millisecondsSinceEpoch,
    };
  }

  factory UnitModel.fromMap(Map<String, dynamic> map) {
    try {
      return UnitModel(
        id: map['id'],
        name: map['name'],
        code: map['code'],
        examStartDate:
            DateTime.fromMillisecondsSinceEpoch(map['examStartDate']),
        examEndDate: DateTime.fromMillisecondsSinceEpoch(map['examEndDate']),
      );
    } on TypeError catch (e) {
      Logger logger = Logger();
      logger.w("${e.toString()}");
      logger.w(
          "The DateTime variables used Firebase's Timestamp instead of the preferred MillisecondsSinceEpoch");
      logger.w(
          "NOTE: The program will still run and the value will be updated to MillisecondsSinceEpoch when this variable is updated in the database");
      return UnitModel(
        id: map['id'],
        name: map['name'],
        code: map['code'],
        examStartDate: map['examStartDate'].toDate(),
        examEndDate: map['examEndDate'].toDate(),
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory UnitModel.fromJson(String source) =>
      UnitModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id ?? '-',
      name ?? '-',
      code ?? '-',
      examStartDate ?? '-',
      examEndDate ?? '-',
    ];
  }
}
