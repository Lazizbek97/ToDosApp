import 'package:hive/hive.dart';
import 'package:todo_app/core/models/task_model.dart';

class Boxes {
  static Box<TaskModel> getTask() => Hive.box<TaskModel>("all_tasks");
}