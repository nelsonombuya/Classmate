part of 'manage_course_cubit.dart';

abstract class ManageCourseState extends Equatable {
  final String? courseId;
  final String? year;
  final List<DocumentReference>? selectedUnits;

  const ManageCourseState({this.courseId, this.year, this.selectedUnits});

  @override
  List<Object> get props => [];
}

class ManageCourseInitial extends ManageCourseState {}

class CourseDetailsChanged extends ManageCourseState {
  final String? courseId;
  final String? year;
  final List<DocumentReference>? selectedUnits;

  const CourseDetailsChanged({this.courseId, this.year, this.selectedUnits});

  @override
  List<Object> get props => [
        courseId ?? "Course Not Selected",
        year ?? "Year Not Selected",
        selectedUnits ?? "Units not selected",
      ];
}

class CourseDetailsUpdatedSuccessfully extends ManageCourseState {
  final String? course;
  final String? year;
  final List<DocumentReference>? selectedUnits;

  const CourseDetailsUpdatedSuccessfully({
    this.course,
    this.year,
    this.selectedUnits,
  });

  @override
  List<Object> get props => [
        course ?? "Course Not Selected",
        year ?? "Year Not Selected",
        selectedUnits ?? "Units not selected",
      ];
}
