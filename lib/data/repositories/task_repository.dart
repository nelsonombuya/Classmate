import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/auth_model.dart';
import '../models/task_model.dart';

class TaskRepository {
  final CollectionReference _tasksSubCollection;

  TaskRepository(AuthModel user)
      : _tasksSubCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('tasks');

  Stream<List<TaskModel>> get personalTaskDataStream {
    return _tasksSubCollection
        .snapshots()
        .distinct()
        .map(_mapSnapshotToTaskModelList);
  }

  Future createTask(Map<String, dynamic> taskData) async {
    _tasksSubCollection.doc().set(taskData, SetOptions(merge: true));
  }

  Future updateTask(TaskModel task) async {
    _tasksSubCollection
        .doc(task.docId)
        .set(task.toMap(), SetOptions(merge: true));
  }

  Future deleteTask(TaskModel task) async {
    _tasksSubCollection.doc(task.docId).delete();
  }

  List<TaskModel> _mapSnapshotToTaskModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      TaskModel newTask = TaskModel.fromMap(doc.data());
      return newTask.copyWith(docId: doc.id);
    }).toList();
  }
}
