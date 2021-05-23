part of 'manage_units_cubit.dart';

class ManageUnitsState extends Equatable {
  const ManageUnitsState.initial({
    this.school,
    this.course,
    this.year,
    this.session,
    this.semester,
    this.changed = false,
  });

  const ManageUnitsState.changed({
    this.school,
    this.course,
    this.year,
    this.session,
    this.semester,
    this.changed = true,
  });

  final School? school;
  final CourseDetails? course;
  final SessionDetails? session;
  final String? year;
  final String? semester;
  final bool changed;

  @override
  List<Object> get props => [
        school ?? 'No School Selected',
        course ?? 'No CourseDetails Selected',
        year ?? 'No Year Selected',
        semester ?? 'No Semester Selected',
        session ?? 'No Session Selected',
      ];
}
