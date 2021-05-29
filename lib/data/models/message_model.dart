import 'dart:convert';

import 'package:equatable/equatable.dart';

class NotificationMessage extends Equatable {
  final String title;
  final String body;

  const NotificationMessage({
    required this.title,
    required this.body,
  });

  NotificationMessage copyWith({
    String? title,
    String? body,
  }) {
    return NotificationMessage(
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
    };
  }

  factory NotificationMessage.fromMap(Map<String, dynamic> map) {
    return NotificationMessage(
      title: map['title'] ?? 'No Title Set',
      body: map['body'] ?? 'No Body Set',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationMessage.fromJson(String source) =>
      NotificationMessage.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [title, body];
}
