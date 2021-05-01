import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_model.dart';
import '../models/user_model.dart';

class TaskRepository {
  final CollectionReference _tasksSubCollection;

  TaskRepository(UserModel user)
      : _tasksSubCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('tasks');

  Stream<List<TaskModel>> get taskDataStream {
    return _tasksSubCollection
        .snapshots()
        .distinct()
        .map(_mapSnapshotToTaskModelList);
  }

  Future createTask(Map<String, dynamic> taskData) async {
    _tasksSubCollection.doc().set(taskData, SetOptions(merge: true));
  }

  Future updateTask(TaskModel task, Map<String, dynamic> taskData) async {
    _tasksSubCollection.doc(task.docId).set(taskData, SetOptions(merge: true));
  }

  List<TaskModel> _mapSnapshotToTaskModelList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map(
          (doc) => TaskModel(
            docId: '',
            title: doc.data()['title'],
            isDone: doc.data()['is_done'],
          ),
        )
        .toList();
  }
}
