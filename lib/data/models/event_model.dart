import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

class EventModel extends Equatable {
  final String? id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final bool isAllDayEvent;

  const EventModel({
    this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.isAllDayEvent,
  });

  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    bool? isAllDayEvent,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isAllDayEvent: isAllDayEvent ?? this.isAllDayEvent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'isAllDayEvent': isAllDayEvent,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isAllDayEvent: map['isAllDayEvent'],
      startDate: map['startDate'] == null
          ? DateTime.now()
          : map['startDate'] is Timestamp
              ? map['startDate'].toDate()
              : DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: map['endDate'] == null
          ? DateTime.now()
          : map['endDate'] is Timestamp
              ? map['endDate'].toDate()
              : DateTime.fromMillisecondsSinceEpoch(map['endDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EventModel(id: $id, title: $title, description: $description, startDate: $startDate, endDate: $endDate, isAllDayEvent: $isAllDayEvent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.isAllDayEvent == isAllDayEvent;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        isAllDayEvent.hashCode;
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id ?? '-',
      title,
      description,
      startDate,
      endDate,
      isAllDayEvent,
    ];
  }
}
