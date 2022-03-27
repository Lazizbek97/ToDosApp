import 'package:flutter/material.dart';
import 'package:todo_app/core/domain/task__crud_repository.dart';
import 'package:todo_app/core/hive/hive_boxes.dart';
import 'package:todo_app/core/services/task_service.dart';

class CategoryProvider extends ChangeNotifier {
  //  Task_Crud taskModelRepository = Task_Crud(taskService: TaskService());

  int number = 0;

  byCategories(String category) async {
    number = 0;

    final tasks = Boxes.getTask().values.toList();
    for (var element in tasks) {
      print(category);
      print(element.category);
      element.category == category ? number += 1 : number += 0;
    }
    notifyListeners();
  }
}
