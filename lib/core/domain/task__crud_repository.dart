import 'package:todo_app/core/models/task_model.dart';
import 'package:todo_app/core/services/task_service.dart';

/// The interface for an API that provides access to a list of todos.

abstract class TaskApi {
  const TaskApi();

  /// Provides  all of todos.
  Future<List<TaskModel>> getTodos();

  /// Saves a [todo].
  ///
  /// If a [todo] with the same id already exists, it will be replaced.
  Future<void> saveTodo(TaskModel todo);

  /// Deletes the todo with the given id.
  ///
  /// If no todo with the given id exists, a [TodoNotFoundException] error is
  /// thrown.
  Future<void> deleteTodo(TaskModel task);

  /// Deletes all completed todos.
  ///
  /// Returns the number of deleted todos.
  Future<void> markCompleted(TaskModel task);

  /// Sets the `isCompleted` state of all todos to the given value.
  /// Returns the number of updated todos.
  Future<void> editTodo(TaskModel oldTtask, TaskModel newTask);
}

/// Error thrown when a [Todo] with a given id is not found.
class TodoNotFoundException implements Exception {}

class Task_Crud extends TaskApi {
  TaskService taskService;
  Task_Crud({required this.taskService});

  @override
  Future<void> deleteTodo(TaskModel task) async {
    taskService.deleteFromHive(task);
  }

  @override
  Future editTodo(TaskModel oldTask, TaskModel newTask) async {
    taskService.editFromHive(oldTask, newTask);
  }

  @override
  Future<List<TaskModel>> getTodos() async {
    return await taskService.getTasks();
  }

  @override
  Future markCompleted(TaskModel task) async {
    taskService.markAsCompletedHive(task);
  }

  @override
  Future<void> saveTodo(TaskModel task) async {
    taskService.addToHive(task);
  }
}
