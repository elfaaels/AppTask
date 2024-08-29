import 'package:app_task/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTask(Todo todo) {
    _todos.add(todo);
    notifyListeners();
    saveTasksToStorage();
  }

  void toggleTodoStatus(String id) {
    final task = _todos.firstWhere((task) => task.id == id);
    task.isCompleted = !task.isCompleted;
    notifyListeners();
    saveTasksToStorage();
  }

  void deleteTask(String id) {
    _todos.removeWhere((task) => task.id == id);
    notifyListeners();
    saveTasksToStorage();
  }

  void saveTasksToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'tasks',
        jsonEncode(_todos
            .map((task) => {
                  'id': task.id,
                  'title': task.title,
                  'description': task.description,
                  'isCompleted': task.isCompleted,
                })
            .toList()));
  }

  Future<void> loadTasksFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      final List<dynamic> todosJson = jsonDecode(tasksString);
      _todos = todosJson
          .map((todoJson) => Todo(
                id: todoJson['id'],
                title: todoJson['title'],
                description: todoJson['description'],
                isCompleted: todoJson['isCompleted'],
              ))
          .toList();
      notifyListeners();
    }
  }
}
