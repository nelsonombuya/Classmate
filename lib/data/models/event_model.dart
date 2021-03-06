import 'dart:convert';

class EventModel {
  String? docId;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  bool isAllDayEvent;

  EventModel({
    this.docId,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.isAllDayEvent,
  });

  EventModel copyWith({
    String? docId,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    bool? isAllDayEvent,
  }) {
    return EventModel(
      docId: docId ?? this.docId,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isAllDayEvent: isAllDayEvent ?? this.isAllDayEvent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'title': title,
      'description': description,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'isAllDayEvent': isAllDayEvent,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      docId: map['docId'],
      title: map['title'],
      description: map['description'],
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      isAllDayEvent: map['isAllDayEvent'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EventModel(docId: $docId, title: $title, description: $description, startDate: $startDate, endDate: $endDate, isAllDayEvent: $isAllDayEvent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventModel &&
        other.docId == docId &&
        other.title == title &&
        other.description == description &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.isAllDayEvent == isAllDayEvent;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        isAllDayEvent.hashCode;
  }
}
