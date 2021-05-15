import 'package:classmate/data/models/lesson_model.dart';
import 'package:classmate/logic/cubit/school/school_cubit.dart';
import 'package:classmate/presentation/common_widgets/no_data_found.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Stream<List<LessonModel>>>(
        future: context.read<SchoolCubit>().getLessonsStream(),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (futureSnapshot.hasData && futureSnapshot.data != null) {
            return StreamBuilder<List<LessonModel>>(
              stream: futureSnapshot.data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (snapshot.hasData && snapshot.data != null) {
                  var listOfLessons = snapshot.data!;
                  return ListView.builder(
                    itemCount: listOfLessons.length,
                    itemBuilder: (context, index) {
                      var currentLesson = listOfLessons[index];
                      return Text('currentLesson');
                    },
                  );
                }

                return NoDataFound(
                  message: 'No Lessons Found.\nKindly register your units',
                );
              },
            );
          }
          return NoDataFound(
            message: "No Data Found.\nKindly register your units",
          );
        });
  }
}
//     List<UnitRepository> units = context.read<SchoolCubit>().unitRepositoryList;

//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: units.length,
//       controller: _unitScrollController,
//       itemBuilder: (context, index) {
//         if (units.isNotEmpty) {
//           UnitRepository unitRepository = units[index];
//           return FutureBuilder<UnitModel>(
//             future: unitRepository.getUnitDetails(),
//             builder: (context, unitSnapshot) {
//               if (unitSnapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator.adaptive();
//               }

//               if (unitSnapshot.hasData && unitSnapshot.data != null) {
//                 UnitModel currentUnit = unitSnapshot.data!;
//                 return Column(
//                   children: [
//                     StreamBuilder<List<LessonModel>>(
//                       stream: unitRepository.lessonRepository.lessonsDataStream,
//                       builder: (context, lessonSnapshot) {
//                         if (lessonSnapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Center(
//                             child: CircularProgressIndicator.adaptive(),
//                           );
//                         }

//                         if (lessonSnapshot.hasData &&
//                             lessonSnapshot.data != null) {
//                           var lessons = lessonSnapshot.data;

//                           return Padding(
//                             padding: EdgeInsets.all(
//                               _deviceQuery.safeWidth(4.0),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(8.0),
//                               child: ListTile(
//                                 enableFeedback: true,
//                                 leading: Icon(
//                                   Icons.class__rounded,
//                                   color: CupertinoColors.activeOrange,
//                                 ),
//                                 contentPadding: EdgeInsets.symmetric(
//                                   vertical: 10,
//                                   horizontal: 16,
//                                 ),
//                                 onTap:
//                                     () {}, // TODO Changing Class details for Class Reps
//                                 tileColor: _deviceQuery.brightness ==
//                                         Brightness.light
//                                     ? CupertinoColors.systemGroupedBackground
//                                     : CupertinoColors.darkBackgroundGray,
//                                 title: Text(
//                                   "${currentUnit.name}",
//                                   style: Theme.of(context).textTheme.headline6,
//                                 ),
//                               ),
//                             ),
//                           );
//                         }
//                         return NoDataFound(
//                           message: 'No Lessons Found',
//                         );
//                       },
//                     )
//                   ],
//                 );
//               }

//               return NoDataFound(
//                 message: 'Unit Details Not Found',
//               );
//             },
//           );
//         }
//         return NoDataFound(
//           message: 'No Registered Units Found.\nKindly register your units',
//         );
//       },
//     );
//   }
// }
    //   return BlocBuilder<SessionCubit, SessionState>(
    //     builder: (context, state) {
    //       if (state.lessonStreamsList.isEmpty) {
    //         return NoDataFound(message: "Register your course and units");
    //       }

    //       return ListView.builder(
    //         shrinkWrap: true,
    //         controller: _listViewController,
    //         itemCount: state.lessonStreamsList.length,
    //         itemBuilder: (context, unitIndex) {
    //           return StreamBuilder<DocumentSnapshot>(
    //             stream: state.lessonStreamsList[unitIndex],
    //             builder: (context, sessionSnapshot) {
    //               if (sessionSnapshot.connectionState ==
    //                   ConnectionState.waiting) {
    //                 return Center(
    //                   child: CircularProgressIndicator.adaptive(),
    //                 );
    //               }

    //               if (sessionSnapshot.hasData && sessionSnapshot.data != null) {
    //                 var sessionData = sessionSnapshot.data!.data();

    //                 return Column(
    //                   children: [
    //                     Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: ClipRRect(
    //                         borderRadius: BorderRadius.circular(8.0),
    //                         child: ListTile(
    //                           enableFeedback: true,
    //                           leading: Icon(
    //                             Icons.school_rounded,
    //                             color: CupertinoColors.activeOrange,
    //                           ),
    //                           contentPadding: EdgeInsets.symmetric(
    //                             vertical: 10,
    //                             horizontal: 16,
    //                           ),
    //                           onTap:
    //                               () {}, // TODO Changing Class details for Class Reps
    //                           tileColor:
    //                               _deviceQuery.brightness == Brightness.light
    //                                   ? CupertinoColors.systemGroupedBackground
    //                                   : CupertinoColors.darkBackgroundGray,
    //                           title: Text(
    //                             "${sessionData!['name']}",
    //                             style: Theme.of(context).textTheme.headline6,
    //                           ),
    //                           subtitle: Text(
    //                             "On ${_formatFirebaseTimestamp('EEEE', sessionData['class_start_time'])}",
    //                             style: TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                             ),
    //                           ),
    //                           trailing: Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             crossAxisAlignment: CrossAxisAlignment.end,
    //                             children: [
    //                               Text(
    //                                   "${_formatFirebaseTimestamp('hh:mm aa', sessionData['class_start_time'])}"),
    //                               Text("TO"),
    //                               Text(
    //                                   "${_formatFirebaseTimestamp('hh:mm aa', sessionData['class_end_time'])}"),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     StreamBuilder<QuerySnapshot>(
    //                       stream: state.assignmentStreamsList[unitIndex],
    //                       builder: (context, assignmentsSnapshot) {
    //                         if (assignmentsSnapshot.connectionState ==
    //                             ConnectionState.waiting) {
    //                           return CircularProgressIndicator.adaptive();
    //                         }

    //                         if (assignmentsSnapshot.hasData) {
    //                           var numberOfAssignments =
    //                               assignmentsSnapshot.data!.docs.length;

    //                           return ListView.builder(
    //                             shrinkWrap: true,
    //                             itemCount: numberOfAssignments,
    //                             controller: ScrollController(),
    //                             itemBuilder: (context, index) {
    //                               var assignmentId =
    //                                   assignmentsSnapshot.data!.docs[index].id;
    //                               var assignment = assignmentsSnapshot
    //                                   .data!.docs[index]
    //                                   .data();
    //                               var title = assignment['title'];
    //                               var isDone =
    //                                   assignment['users']?[_currentUserUid];
    //                               if (isDone == null) isDone = false;

    //                               return Padding(
    //                                 padding: const EdgeInsets.symmetric(
    //                                   horizontal: 8.0,
    //                                   vertical: 2.0,
    //                                 ),
    //                                 child: ClipRRect(
    //                                   borderRadius: BorderRadius.circular(8.0),
    //                                   child: CheckboxListTile(
    //                                     activeColor: CupertinoColors.activeBlue,
    //                                     value: isDone,
    //                                     onChanged: (value) {
    //                                       if (value == null) {
    //                                         throw Exception(
    //                                             "The checked value shouldn't be null ❗");
    //                                       }
    //                                       _sessionCubit.updateAssignmentDetails(
    //                                         assignmentId: assignmentId,
    //                                         session: state.sessionList[unitIndex],
    //                                         user: _currentUser,
    //                                         value: value,
    //                                       );
    //                                     },
    //                                     tileColor: _deviceQuery.brightness ==
    //                                             Brightness.light
    //                                         ? CupertinoColors
    //                                             .systemGroupedBackground
    //                                         : CupertinoColors.darkBackgroundGray,
    //                                     title: Text(
    //                                       title,
    //                                       style: Theme.of(context)
    //                                           .textTheme
    //                                           .headline6!
    //                                           .copyWith(
    //                                             decoration: isDone
    //                                                 ? TextDecoration.lineThrough
    //                                                 : null,
    //                                             color: isDone
    //                                                 ? Theme.of(context)
    //                                                     .disabledColor
    //                                                 : null,
    //                                           ),
    //                                     ),
    //                                     subtitle: Text((assignment['due_date'] !=
    //                                             null)
    //                                         ? "${_formatFirebaseTimestamp('EEE dd hh:mm aa', assignment['due_date'])}"
    //                                         : "No Due Date Set"),
    //                                   ),
    //                                 ),
    //                               );
    //                             },
    //                           );
    //                         }
    //                         return NoDataFound(message: "No Assignments Found");
    //                       },
    //                     )
    //                   ],
    //                 );
    //               }
    //               return NoDataFound(message: "Something went wrong");
    //             },
    //           );
    //         },
    //       );
    //     },
    //   );
//     // }
//   }
// }




    //       StreamBuilder<List<LessonModel>>(
    //         stream: unitRepository.lessonRepository.lessonsDataStream,
    //         builder: (context, lessonSnapshot) {
    //           if (lessonSnapshot.connectionState == ConnectionState.waiting) {
    //             return Center(
    //               child: CircularProgressIndicator.adaptive(),
    //             );
    //           }
    //           if (lessonSnapshot.hasData && lessonSnapshot.data != null) {
    //             var lessons = lessonSnapshot.data;
    //             return Column(
    //                   children: [
    //                     Padding(
    //                       padding:  EdgeInsets.all(_deviceQuery.safeWidth(4.0),),
    //                       child: ClipRRect(
    //                         borderRadius: BorderRadius.circular(8.0),
    //                         child: ListTile(
    //                           enableFeedback: true,
    //                           leading: Icon(
    //                             Icons.class__rounded,
    //                             color: CupertinoColors.activeOrange,
    //                           ),
    //                           contentPadding: EdgeInsets.symmetric(
    //                             vertical: 10,
    //                             horizontal: 16,
    //                           ),
    //                           onTap:
    //                               () {}, // TODO Changing Class details for Class Reps
    //                           tileColor:
    //                               _deviceQuery.brightness == Brightness.light
    //                                   ? CupertinoColors.systemGroupedBackground
    //                                   : CupertinoColors.darkBackgroundGray,
    //                           title: Text(
    //                             "$unit",
    //                             style: Theme.of(context).textTheme.headline6,
    //                           ),
    //                           subtitle: Text(
    //                             "On ${_formatFirebaseTimestamp('EEEE',)}",
    // //                             style: TextStyle(
    // //                               fontWeight: FontWeight.bold,
    // //                             ),
    // //                           ),
    // //                           trailing: Column(
    // //                             mainAxisAlignment: MainAxisAlignment.center,
    // //                             crossAxisAlignment: CrossAxisAlignment.end,
    // //                             children: [
    // //                               Text(
    // //                                   "${_formatFirebaseTimestamp('hh:mm aa', sessionData['class_start_time'])}"),
    // //                               Text("TO"),
    // //                               Text(
    // //                                   "${_formatFirebaseTimestamp('hh:mm aa', sessionData['class_end_time'])}"),
    // //                             ],
    // //                           ),
    // //                         ),
    // //                       ),
    // //                     ),
