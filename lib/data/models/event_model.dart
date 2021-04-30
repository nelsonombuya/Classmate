import 'dart:convert';

class EventModel {
  String docId;
  String title;
  String description;
  DateTime startingDate;
  DateTime endingDate;

  EventModel({
    required this.docId,
    required this.title,
    required this.description,
    required this.startingDate,
    required this.endingDate,
  });

  EventModel copyWith({
    String? docId,
    String? title,
    String? description,
    DateTime? startingDate,
    DateTime? endingDate,
  }) {
    return EventModel(
      docId: docId ?? this.docId,
      title: title ?? this.title,
      description: description ?? this.description,
      startingDate: startingDate ?? this.startingDate,
      endingDate: endingDate ?? this.endingDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'title': title,
      'description': description,
      'startingDate': startingDate.millisecondsSinceEpoch,
      'endingDate': endingDate.millisecondsSinceEpoch,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      docId: map['docId'],
      title: map['title'],
      description: map['description'],
      startingDate: DateTime.fromMillisecondsSinceEpoch(map['startingDate']),
      endingDate: DateTime.fromMillisecondsSinceEpoch(map['endingDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EventModel(docId: $docId, title: $title, description: $description, startingDate: $startingDate, endingDate: $endingDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventModel &&
        other.docId == docId &&
        other.title == title &&
        other.description == description &&
        other.startingDate == startingDate &&
        other.endingDate == endingDate;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        startingDate.hashCode ^
        endingDate.hashCode;
  }
}
