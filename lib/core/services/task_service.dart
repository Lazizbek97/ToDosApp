import 'package:hive/hive.dart';
import 'package:todo_app/core/hive/hive_boxes.dart';
import 'package:todo_app/core/models/task_model.dart';

class TaskService {
  Box<TaskModel> taskBox = Boxes.getTask();

  Future<List<TaskModel>> getTasks() async {
    return taskBox.values.toList();
  }

  addToHive(TaskModel task) async {
    if (taskBox.containsKey(task.key)) {
      await task.save();
    } else {
      await taskBox.add(task);
    }
  }

  deleteFromHive(TaskModel task) async {
    await task.delete();
  }

  editFromHive(TaskModel oldTask, TaskModel newTask) async {
    await taskBox.put(oldTask.key, newTask);
  }

  markAsCompletedHive(TaskModel task) async {
    task.isComleted = !task.isComleted!;
    await task.save();
  }
}
