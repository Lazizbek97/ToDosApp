part of 'tasks_cubit.dart';

@immutable
abstract class TasksState {
  const TasksState();
}

class TasksInitial extends TasksState {
  const TasksInitial();
}

class TasksLoading extends TasksState {
  const TasksLoading();
}

class TaskcategoriesLoaded extends TasksState {
  int number;
  TaskcategoriesLoaded(this.number);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TaskLoaded && o.tasks == number;
  }

  @override
  int get hashCode => number.hashCode;
}

class TaskLoaded extends TasksState {
  final List<TaskModel> tasks;
  const TaskLoaded(this.tasks);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TaskLoaded && o.tasks == tasks;
  }

  @override
  int get hashCode => tasks.hashCode;
}

class TaskErorr extends TasksState {
  final String message;
  const TaskErorr(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TaskErorr && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
