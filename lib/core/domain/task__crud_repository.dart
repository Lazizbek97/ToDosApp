import 'package:todo_app/core/models/task_model.dart';
import 'package:todo_app/core/services/task_service.dart';

abstract class TaskApi {
  const TaskApi();

  /// Provides  all of todos.
  Future<List<TaskModel>> getTodos();

  /// Saves a [todo].

  Future<void> saveTodo(TaskModel todo);

  /// Deletes the todo

  Future<void> deleteTodo(TaskModel task);

  /// Sets the `isCompleted` state of all todos to the given value.
  Future<void> markCompleted(TaskModel task);
  Future<void> changeNotifier(TaskModel task);

  /// Updated todo.
  Future<void> editTodo(TaskModel oldTtask, TaskModel newTask);
}

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
  Future changeNotifier(TaskModel task) async {
    taskService.changeNotifier(task);
  }

  @override
  Future<void> saveTodo(TaskModel task) async {
    taskService.addToHive(task);
  }
}
