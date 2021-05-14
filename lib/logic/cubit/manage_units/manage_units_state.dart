part of 'manage_units_cubit.dart';

class ManageUnitsState extends Equatable {
  const ManageUnitsState.initial({
    this.school,
    this.course,
    this.year,
    this.session,
    this.changed = false,
  });

  const ManageUnitsState.changed({
    this.school,
    this.course,
    this.year,
    this.session,
    this.changed = true,
  });

  final SchoolModel? school;
  final CourseModel? course;
  final SessionModel? session;
  final String? year;
  final bool changed;

  @override
  List<Object> get props => [
        school ?? 'No School Selected',
        course ?? 'No Course Selected',
        year ?? 'No Year Selected',
        session ?? 'No Session Selected',
      ];
}
