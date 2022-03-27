import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/domain/task__crud_repository.dart';
import 'package:todo_app/core/services/task_service.dart';
import 'package:todo_app/screens/entry_page/entry_page.dart';
import 'package:todo_app/screens/home_page/presentation/cubit/tasks_cubit.dart';
import 'package:todo_app/screens/home_page/presentation/page/home_page.dart';
import 'package:todo_app/screens/tasks_by_category_page/tasks_by_category_page.dart';

class RouteGenerator {
  late TaskService taskService;
  RouteGenerator() {
    taskService = TaskService();
  }

  Route? routeGenerate(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/home":
        return MaterialPageRoute(
          builder: (_) => BlocProvider<TasksCubit>(
            create: (context) => TasksCubit(Task_Crud(
              taskService: taskService,
            )),
            child: const HomePage(),
          ),
        );
      case "/":
        return MaterialPageRoute(
          builder: (_) => const EntryPage(),
        );
      case "/bycategory":
        return MaterialPageRoute(
          builder: (_) => BlocProvider<TasksCubit>(
            create: (context) => TasksCubit(Task_Crud(
              taskService: taskService,
            )),
            child: TasksByCategoryPage(
              category: args as String,
            ),
          ),
        );
    }
    return null;
  }
}
