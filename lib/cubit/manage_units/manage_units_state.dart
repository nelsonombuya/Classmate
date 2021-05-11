part of 'manage_units_cubit.dart';

class ManageUnitsState extends Equatable {
  const ManageUnitsState.initial({this.school, this.course, this.year});

  const ManageUnitsState.changed({this.school, this.course, this.year});

  final SchoolModel? school;
  final CourseModel? course;
  final String? year;

  @override
  List<Object> get props => [
        school ?? 'No School Selected',
        course ?? 'No Course Selected',
        year ?? 'No Year Selected',
      ];
}
