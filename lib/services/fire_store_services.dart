import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Task>> getTasks(String userId) {
    return _db
        .collection('tasks')
        .where('ownerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Task.fromMap(doc.data())).toList())
        .asyncExpand((tasks) {
          return _db
              .collection('tasks')
              .where('sharedWith', arrayContains: userId) // Use userId instead of email
              .snapshots()
              .map((snapshot) => tasks + snapshot.docs.map((doc) => Task.fromMap(doc.data())).toList());
        });
  }

  Future<void> addTask(Task task) async {
    await _db.collection('tasks').doc(task.id).set(task.toMap());
  }

  Future<void> updateTask(Task task) async {
    await _db.collection('tasks').doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String taskId) async {
    await _db.collection('tasks').doc(taskId).delete();
  }

  Future<void> shareTask(String taskId, String email) async {
    await _db.collection('tasks').doc(taskId).update({
      'sharedWith': FieldValue.arrayUnion([email]),
    });
  }
}