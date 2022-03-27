import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/constants.dart';
import 'package:todo_app/core/data/local_data.dart';
import 'package:todo_app/core/domain/task__crud_repository.dart';
import 'package:todo_app/core/services/task_service.dart';
import 'package:todo_app/core/utils/size_config.dart';
import 'package:todo_app/screens/home_page/presentation/cubit/tasks_cubit.dart';
import 'package:todo_app/screens/provider/category_provider.dart';

class TaskCategoriesPage extends StatelessWidget {
  const TaskCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskService taskService = TaskService();

    return

        // BlocConsumer<TasksCubit, TasksState>(
        //   listener: (context, state) {},
        //   builder: (context, state) {
        // BlocProvider.of<TasksCubit>(context).getTasks();
        // state is TaskLoaded
        //     ? state.tasks.map((e) => BlocProvider.of<TasksCubit>(context)
        //         .byCategories(e.category!))
        //     : null;

        Container(
      padding: EdgeInsets.symmetric(
        horizontal: getWidth(10),
        vertical: getHeight(10),
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: getWidth(159),
          mainAxisExtent: getHeight(210),
          crossAxisSpacing: getWidth(20),
          mainAxisSpacing: getHeight(10),
        ),
        itemBuilder: (context, index) {
          // int todoNumber = 0;
          // context
          //     .read<TasksCubit>()
          //     .byCategories(Categories.get[index]['title']);

          // todoNumber = context.watch<TasksCubit>().number;
          context
              .read<CategoryProvider>()
              .byCategories(Categories.get[index]['title']);

          return Container(
            margin: EdgeInsets.all(getWidth(5)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xff59bbbbbb),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Categories.get[index]['color'],
                  child: SvgPicture.asset(Categories.get[index]['icon']),
                ),
                Text(
                  Categories.get[index]['title'],
                  style: TextStyle(
                    fontSize: Constants.h3,
                    fontWeight: FontWeight.w600,
                    color: Constants.categoryTitleColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: getHeight(25)),
                  child: Text(
                    "${context.watch<CategoryProvider>().number} Tasks",
                    style: TextStyle(
                        fontSize: Constants.h5,
                        color: Constants.categoryCountTextColor),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: Categories.get.length,
      ),
    );
  }
}
