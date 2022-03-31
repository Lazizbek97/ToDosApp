import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/domain/task__crud_repository.dart';
import 'package:todo_app/core/models/task_model.dart';
import 'package:todo_app/core/services/notifications_service.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final Task_Crud _taskModelRepository;

  TasksCubit(this._taskModelRepository) : super(const TasksInitial());
  int number = 0;
  


  Future<void> getTasks() async {
    try {
      emit(const TasksLoading());

      final tasks = await _taskModelRepository.getTodos();
      sortTodoTimes(tasks);

      for (var element in tasks) {
        print(element.date);
      }

      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskErorr(e.toString()));
    }
  }

  Future<void> deleteTask(TaskModel task) async {
    await _taskModelRepository.deleteTodo(task);
    final tasks = await _taskModelRepository.getTodos();
    sortTodoTimes(tasks);
    emit(TaskLoaded(tasks));
  }

  Future<void> changeCompletion(task) async {
    await _taskModelRepository.markCompleted(task);
    final tasks = await _taskModelRepository.getTodos();
    sortTodoTimes(tasks);

    emit(TaskLoaded(tasks));
  }

  Future<void> changeNotifier(task) async {
    await _taskModelRepository.changeNotifier(task);
    final tasks = await _taskModelRepository.getTodos();
    sortTodoTimes(tasks);
    emit(TaskLoaded(tasks));
  }

  sortTodoTimes(List<TaskModel> tasks) {
    tasks.sort((a, b) => DateFormat("yyyy-MM-dd")
        .parse(a.date!)
        .compareTo(DateFormat("yyyy-MM-dd").parse(b.date!)));
  }

  byCategories(String category) async {
    number = 0;
    final tasks = await _taskModelRepository.getTodos();
    for (var element in tasks) {
      print(category);
      print(element.category);
      element.category == category ? number += 1 : number += 0;
    }
    emit(TaskcategoriesLoaded(number));
    return num;
  }
}
