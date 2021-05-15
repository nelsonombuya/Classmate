import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_model.dart';
import '../models/user_model.dart';

class TaskRepository {
  TaskRepository(UserModel user)
      : _tasksSubCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('tasks');

  final CollectionReference _tasksSubCollection;

  Stream<List<TaskModel>> get personalTaskDataStream {
    return _tasksSubCollection
        .snapshots()
        .distinct()
        .map(_mapQuerySnapshotToTaskModelList);
  }

  Future<void> createPersonalTask(TaskModel task) async {
    return _tasksSubCollection.doc().set(task.toMap(), SetOptions(merge: true));
  }

  Future<void> updatePersonalTask(TaskModel task) async {
    _tasksSubCollection.doc(task.id).set(task.toMap(), SetOptions(merge: true));
  }

  Future<void> deletePersonalTask(TaskModel task) async {
    return _tasksSubCollection.doc(task.id).delete();
  }

  List<TaskModel> _mapQuerySnapshotToTaskModelList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => TaskModel.fromMap(doc.data()).copyWith(id: doc.id))
        .toList();
  }
}
