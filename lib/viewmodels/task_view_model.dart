import 'package:flutter/material.dart';
import 'package:todo_rappid/services/fire_store_services.dart';
import 'package:uuid/uuid.dart';
import 'package:share_plus/share_plus.dart';
import '../models/task.dart';

class TaskViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  String _userId;

  TaskViewModel(this._userId);

  // Getter for userId
  String get userId => _userId;

  // Method to update userId after login
  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  Stream<List<Task>> get tasks => _firestoreService.getTasks(_userId);

  Future<void> addTask(String title, String description) async {
    final task = Task(
      id: Uuid().v4(),
      title: title,
      description: description,
      ownerId: _userId,
      createdAt: DateTime.now(),
    );
    await _firestoreService.addTask(task);
    notifyListeners();
  }

  Future<void> updateTask(Task task, String title, String description) async {
    final updatedTask = Task(
      id: task.id,
      title: title,
      description: description,
      ownerId: task.ownerId,
      sharedWith: task.sharedWith,
      createdAt: task.createdAt,
    );
    await _firestoreService.updateTask(updatedTask);
    notifyListeners();
  }

  Future<void> deleteTask(String taskId) async {
    await _firestoreService.deleteTask(taskId);
    notifyListeners();
  }

  Future<void> shareTask(Task task, String email) async {
    await _firestoreService.shareTask(task.id, email);
    final shareText = 'Task: ${task.title}\nDescription: ${task.description}\nJoin via: todoapp://task/${task.id}';
    await Share.share(shareText, subject: 'Shared Task from TODO App');
    notifyListeners();
  }
}