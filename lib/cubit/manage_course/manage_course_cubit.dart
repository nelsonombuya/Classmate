import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/notification/notification_bloc.dart';
import '../../data/models/user_data_model.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../data/repositories/course_repository.dart';
import '../../data/repositories/user_repository.dart';

part 'manage_course_state.dart';

class ManageCourseCubit extends Cubit<ManageCourseState> {
  final CourseRepository _courseRepository = CourseRepository();
  final AuthenticationRepository _AuthenticationRepository =
      AuthenticationRepository();
  late final NotificationBloc _notificationBloc;
  late final UserRepository _UserRepository;
  late final coursesDataStream;

  ManageCourseCubit(BuildContext context)
      : _notificationBloc = BlocProvider.of<NotificationBloc>(context),
        super(ManageCourseInitial()) {
    coursesDataStream = _courseRepository.coursesDataStream;

    if (!_AuthenticationRepository.isUserSignedIn()) {
      this.addError("No User Signed In ❗");
      throw NullThrownError();
    }
    _UserRepository =
        UserRepository(_AuthenticationRepository.getCurrentUser()!);

    _UserRepository.getUserData().then((value) {
      if (value != null && value.course != null) {
        emit(CourseDetailsChanged(
          year: value.year,
          courseId: value.course!.id,
          selectedUnits: value.registeredUnits ?? <DocumentReference>[],
        ));
      }
    });
  }

  void changeSelectedCourse(String? selectedCourseID) {
    if (selectedCourseID == null) {
      this.addError("Course ID Can't Be Null ❗");
      throw NullThrownError();
    }

    emit(CourseDetailsChanged(
      courseId: selectedCourseID,
      year: null,
      selectedUnits: null,
    ));
  }

  void changeSelectedYear(String? selectedYear) {
    if (selectedYear == null) {
      this.addError("Year Can't Be Null ❗");
      throw NullThrownError();
    }

    emit(CourseDetailsChanged(
      courseId: state.courseId,
      year: selectedYear,
      selectedUnits: null,
    ));
  }

  void addSelectedUnits(dynamic selectedUnit) {
    dynamic newListOfUnits =
        (state.selectedUnits == null) ? [] : state.selectedUnits;

    if (selectedUnit is List) {
      selectedUnit.forEach(
        (unit) {
          if (!newListOfUnits.contains(unit)) newListOfUnits.add(unit);
        },
      );
    }

    if (selectedUnit is DocumentReference) {
      if (!newListOfUnits.contains(selectedUnit)) {
        newListOfUnits.add(selectedUnit);
      }
    }

    emit(CourseDetailsChanged(
      year: state.year,
      courseId: state.courseId,
      selectedUnits: newListOfUnits.cast<DocumentReference>(),
    ));
  }

  void removeSelectedUnits(DocumentReference selectedUnit) {
    dynamic newListOfUnits = state.selectedUnits;

    newListOfUnits.remove(selectedUnit);

    emit(CourseDetailsChanged(
      year: state.year,
      courseId: state.courseId,
      selectedUnits: newListOfUnits.cast<DocumentReference>(),
    ));
  }

  void saveCourseDetails() async {
    _notificationBloc.add(
      AlertRequested(
        "Saving Course Details",
        notificationType: NotificationType.Loading,
      ),
    );

    DocumentReference course =
        FirebaseFirestore.instance.doc("/courses/${state.courseId}");

    UserModel? currentUserData = await _UserRepository.getUserData();

    UserModel newUserData = currentUserData == null
        ? UserModel(
            course: course,
            year: state.year,
            registeredUnits: state.selectedUnits,
          )
        : currentUserData.copyWith(
            course: course,
            year: state.year,
            registeredUnits: state.selectedUnits,
          );

    _UserRepository.updateUserData(newUserData);
    _notificationBloc.add(
      AlertRequested(
        "Course Details Updated",
        notificationType: NotificationType.Success,
      ),
    );
    emit(CourseDetailsUpdatedSuccessfully(
      course: state.courseId,
      year: state.year,
      selectedUnits: state.selectedUnits,
    ));
  }
}
