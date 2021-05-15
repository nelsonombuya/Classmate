import 'package:bloc/bloc.dart';
import 'package:classmate/data/models/lesson_model.dart';

import 'package:classmate/data/repositories/lesson_repository.dart';
import 'package:classmate/data/repositories/unit_repository.dart';
import 'package:classmate/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'school_state.dart';

class SchoolCubit extends Cubit<SchoolState> {
  final UserRepository _userRepository;

  SchoolCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SchoolState.initial()) {
    _userRepository.getUserData().then(
      (userData) {
        if (userData != null &&
            userData.registeredUnitIds != null &&
            userData.registeredUnitIds!.isNotEmpty &&
            userData.schoolId != null &&
            userData.sessionId != null) {
          userData.registeredUnitIds!.forEach(
            (unitId) async {
              var unitRepository = UnitRepository(
                unitId: unitId,
                schoolId: userData.schoolId!,
                sessionId: userData.sessionId!,
              );

              var unitData = await unitRepository.getUnitDetails();

              var lessonRepository = LessonRepository(
                userData.schoolId!,
                userData.sessionId!,
                unitData,
              );

              var stream = lessonRepository.lessonsDataStream;

              if (!state.lessonsStream.contains(stream)) {
                List<Stream<List<LessonModel>>> stateList =
                    List.from(state.lessonsStream);
                stateList.add(stream);
                emit(SchoolState.updated(lessonsStream: stateList));
              }
            },
          );
        }
      },
    );
  }
}
