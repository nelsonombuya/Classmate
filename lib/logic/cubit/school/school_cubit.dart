import 'package:bloc/bloc.dart';
import 'package:classmate/data/models/lesson_model.dart';
import 'package:classmate/data/models/user_data_model.dart';
import 'package:classmate/data/repositories/unit_repository.dart';
import 'package:classmate/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:async/async.dart';
import 'package:logger/logger.dart';

part 'school_state.dart';

class SchoolCubit extends Cubit<SchoolState> {
  final UserRepository _userRepository;
  final Logger logger = Logger();
  Stream<List<LessonModel>>? lessonsStream;

  SchoolCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SchoolInitial()) {
    _initializeStreams();
  }

  Future<Stream<List<LessonModel>>> getLessonsStream() async {
    while (lessonsStream == null) Future.delayed(Duration(seconds: 3));
    return lessonsStream!;
  }

  void _initializeStreams() async {
    var userData = await _userRepository.getUserData();
    var unitRepoList = _generateListOfUnitRepositories(userData);
    var listOfStreams = _generateListOfLessonStreams(unitRepoList);
    lessonsStream = StreamGroup.mergeBroadcast(listOfStreams);
  }

  List<UnitRepository> _generateListOfUnitRepositories(
      UserDataModel? userData) {
    List<UnitRepository> list = [];
    if (userData != null &&
        userData.registeredUnitIds != null &&
        userData.registeredUnitIds!.isNotEmpty &&
        userData.schoolId != null &&
        userData.sessionId != null) {
      print('round');
      userData.registeredUnitIds!.forEach(
        (unitId) {
          print(unitId);
        },
      );
      // UnitRepository.init(
      //   unitId: unitId,
      //   schoolId: userData.schoolId!,
      //   sessionId: userData.sessionId!,
      // );

      return list;
    }
    return list;
  }

  List<Stream<List<LessonModel>>> _generateListOfLessonStreams(
      List<UnitRepository> unitRepositoryList) {
    List<Stream<List<LessonModel>>> listOfStreams = [];
    unitRepositoryList.forEach(
      (element) {
        listOfStreams.add(element.lessonRepository.lessonsDataStream);
      },
    );
    return listOfStreams;
  }
}
