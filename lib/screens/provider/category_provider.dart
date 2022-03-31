import 'package:flutter/material.dart';
import 'package:todo_app/core/hive/hive_boxes.dart';
import 'package:todo_app/core/models/task_model.dart';

class CategoryProvider extends ChangeNotifier {
  
  int number = 0;
  List<TaskModel> ctasks = [];


  byCategories(String category)  {
    number = 0;
    ctasks = [];

    final tasks = Boxes.getTask().values.toList();
    for (var element in tasks) {
      print(category);
      print(element.category);
      if (element.category == category) {
        number += 1;
        ctasks.add(element);
      }
    }
    // notifyListeners();
  }
}
