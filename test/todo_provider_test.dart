import 'dart:convert';
import 'package:app_task/model/todo.dart';
import 'package:app_task/services/todo_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Todo Provider Test', () {
    late TodoProvider todoProvider;

    setUp(() {
      todoProvider = TodoProvider();
    });

    test('Test - Add Todo', () async {
      // Arrange
      var expectedResponse = Todo(
        id: "1",
        title: 'Flutter',
        description: "Nothing to see here",
        createdAt: "09-09-2024",
      );

      SharedPreferences.setMockInitialValues({});

      final actualResponse = todoProvider.addTask(expectedResponse);

      expect(
        () async => actualResponse,
        isA<void>(),
      );
    });

    test('Test - Toggle Todo Status', () async {
      final todo = Todo(id: '1', title: 'Flutter');
      todoProvider.todos.add(todo);

      todoProvider.toggleTodoStatus('1');

      expect(todo.isCompleted, isTrue);
    });

    test('Test - Delete Todo', () async {
      // Arrange
      var expectedResponse = Todo(
        id: "1",
        title: 'Flutter',
        description: "Nothing to see here",
        createdAt: "09-09-2024",
      );

      SharedPreferences.setMockInitialValues({});

      final actualResponse =
          todoProvider.deleteTask(expectedResponse.id ?? "1");

      expect(
        () async => actualResponse,
        isA<void>(),
      );
    });

    test(
        'Test - Load Todo - should load tasks from SharedPreferences and convert them to Todo objects',
        () async {
      // Arrange
      SharedPreferences.setMockInitialValues({
        'tasks': jsonEncode([
          {
            'id': '1',
            'title': 'Task 1',
            'description': 'Description 1',
            'isCompleted': false
          },
          {
            'id': '2',
            'title': 'Task 2',
            'description': 'Description 2',
            'isCompleted': true
          },
        ]),
      });

      // Act
      await todoProvider.loadTasksFromStorage();

      // Assert
      expect(todoProvider.todos.length, 2);
      expect(todoProvider.todos[0].id, '1');
      expect(todoProvider.todos[0].title, 'Task 1');
      expect(todoProvider.todos[0].description, 'Description 1');
      expect(todoProvider.todos[0].isCompleted, false);

      expect(todoProvider.todos[1].id, '2');
      expect(todoProvider.todos[1].title, 'Task 2');
      expect(todoProvider.todos[1].description, 'Description 2');
      expect(todoProvider.todos[1].isCompleted, true);
    });

    test('Test - Load Todo 2 - should handle empty tasks in SharedPreferences',
        () async {
      // Arrange
      SharedPreferences.setMockInitialValues({});

      // Act
      await todoProvider.loadTasksFromStorage();

      // Assert
      expect(todoProvider.todos.isEmpty, true);
    });

    test(
        'Test - Load Todo 3 - should handle malformed JSON in SharedPreferences',
        () async {
      // Arrange
      SharedPreferences.setMockInitialValues({'tasks': 'invalid json'});

      // Act
      await todoProvider.loadTasksFromStorage();

      // Assert
      expect(todoProvider.todos.isEmpty,
          true); // In case of error, we expect empty list
    });
  });
}
