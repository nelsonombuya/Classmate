import 'dart:convert';

class SessionModel {
  String? code;
  DateTime? classStartDate;
  DateTime? classEndDate;
  DateTime? examStartDate;
  DateTime? examEndDate;
  SessionModel({
    this.code,
    this.classStartDate,
    this.classEndDate,
    this.examStartDate,
    this.examEndDate,
  });

  SessionModel copyWith({
    String? code,
    DateTime? classStartDate,
    DateTime? classEndDate,
    DateTime? examStartDate,
    DateTime? examEndDate,
  }) {
    return SessionModel(
      code: code ?? this.code,
      classStartDate: classStartDate ?? this.classStartDate,
      classEndDate: classEndDate ?? this.classEndDate,
      examStartDate: examStartDate ?? this.examStartDate,
      examEndDate: examEndDate ?? this.examEndDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'classStartDate': classStartDate,
      'classEndDate': classEndDate,
      'examStartDate': examStartDate,
      'examEndDate': examEndDate,
    };
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      code: map['code'],
      classStartDate:
          DateTime.fromMillisecondsSinceEpoch(map['classStartDate']),
      classEndDate: DateTime.fromMillisecondsSinceEpoch(map['classEndDate']),
      examStartDate: DateTime.fromMillisecondsSinceEpoch(map['examStartDate']),
      examEndDate: DateTime.fromMillisecondsSinceEpoch(map['examEndDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionModel.fromJson(String source) =>
      SessionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SessionModel(code: $code, classStartDate: $classStartDate, classEndDate: $classEndDate, examStartDate: $examStartDate, examEndDate: $examEndDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SessionModel &&
        other.code == code &&
        other.classStartDate == classStartDate &&
        other.classEndDate == classEndDate &&
        other.examStartDate == examStartDate &&
        other.examEndDate == examEndDate;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        classStartDate.hashCode ^
        classEndDate.hashCode ^
        examStartDate.hashCode ^
        examEndDate.hashCode;
  }
}
