// Mocks generated by Mockito 5.4.4 from annotations
// in app_task/test/todo_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:ui' as _i5;

import 'package:app_task/model/todo.dart' as _i3;
import 'package:app_task/services/todo_provider.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [TodoProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoProvider extends _i1.Mock implements _i2.TodoProvider {
  MockTodoProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i3.Todo> get todos => (super.noSuchMethod(
        Invocation.getter(#todos),
        returnValue: <_i3.Todo>[],
      ) as List<_i3.Todo>);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  void addTask(_i3.Todo? todo) => super.noSuchMethod(
        Invocation.method(
          #addTask,
          [todo],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void toggleTodoStatus(String? id) => super.noSuchMethod(
        Invocation.method(
          #toggleTodoStatus,
          [id],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void deleteTask(String? id) => super.noSuchMethod(
        Invocation.method(
          #deleteTask,
          [id],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void saveTasksToStorage() => super.noSuchMethod(
        Invocation.method(
          #saveTasksToStorage,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<void> loadTasksFromStorage() => (super.noSuchMethod(
        Invocation.method(
          #loadTasksFromStorage,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  void addListener(_i5.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i5.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
