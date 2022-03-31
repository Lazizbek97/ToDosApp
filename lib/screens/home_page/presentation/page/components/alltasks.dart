import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/constants/constants.dart';
import 'package:todo_app/core/data/local_data.dart';
import 'package:todo_app/core/models/categorys_model.dart';
import 'package:todo_app/core/models/task_model.dart';
import 'package:todo_app/core/utils/size_config.dart';
import 'package:todo_app/screens/home_page/presentation/cubit/cubit/notification_cubit.dart';
import 'package:todo_app/screens/home_page/presentation/cubit/tasks_cubit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AllTasks extends StatelessWidget {
  AllTasks({
    required this.tasks,
    Key? key,
  }) : super(key: key);

  List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
      if (state is NotificationInvalidTime) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
          duration: const Duration(seconds: 1),
        ));
      }
    }, builder: (context, state) {
      return AllTaskList(
        context: context,
        state: state,
        tasks: tasks,
      );
    });
  }
}

class AllTaskList extends StatelessWidget {
  AllTaskList(
      {required this.tasks,
      required this.context,
      required this.state,
      Key? key})
      : super(key: key);
  List<TaskModel> tasks;
  BuildContext context;
  NotificationState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getWidth(15),
        vertical: getHeight(10),
      ),
      child: ListView.separated(
        itemCount: tasks.length,
        separatorBuilder: (context, index) {
          DateTime now = DateTime.now();
          DateTime todoDate =
              DateFormat("yyyy-MM-dd").parse(tasks[index].date!);
          String date = DateFormat("yyyy-MM-dd")
              .parse(tasks[index].date!)
              .toString()
              .split(" ")[0];

          return now == todoDate ? const Text("Today") : Text(date);
        },
        itemBuilder: (context, index) {
          Color? taskColor;
          List<CategoriesModel> allCateg =
              Categories.get.map((e) => CategoriesModel.fromJson(e)).toList();

          for (var element in allCateg) {
            tasks[index].category == element.title
                ? taskColor = element.color!
                : null;
          }

          return Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.4,
              children: [
                SlidableAction(
                  onPressed: (v) {},
                  backgroundColor: const Color(0xFFC4CEF5),
                  foregroundColor: Colors.indigo,
                  icon: Icons.edit_outlined,
                ),
                SlidableAction(
                  onPressed: (v) async {
                    await BlocProvider.of<TasksCubit>(context)
                        .deleteTask(tasks[index]);
                    await BlocProvider.of<NotificationCubit>(context)
                        .cancelNotification(taskModel: tasks[index]);
                  },
                  backgroundColor: const Color(0xFFFFCFCF),
                  foregroundColor: Colors.red,
                  icon: Icons.delete_forever_outlined,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Card(
                margin:
                    EdgeInsets.symmetric(vertical: getHeight(5), horizontal: 0),
                elevation: 2,
                shape: Border(
                  left: BorderSide(
                    color: taskColor!,
                    width: 5,
                  ),
                ),
                shadowColor: Colors.grey.shade200,
                child: ListTile(
                  subtitle: const Text(""),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: getWidth(8.0)),
                  leading: Padding(
                    padding: EdgeInsets.all(getWidth(5.0)),
                    child: InkWell(
                      onTap: () async {
                        await BlocProvider.of<TasksCubit>(context)
                            .changeCompletion(tasks[index]);
                        await BlocProvider.of<NotificationCubit>(context)
                            .completedNotification(tasks[index]);
                      },
                      child: _markCompletion(index),
                    ),
                  ),
                  title: SizedBox(
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: getWidth(10)),
                          child: Text(
                            tasks[index].time!,
                            style: TextStyle(
                              fontSize: 11,
                              color: Constants.dateTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            tasks[index].title!,
                            style: TextStyle(
                                color: tasks[index].isComleted!
                                    ? Constants.completedTextColor
                                    : Constants.textColor,
                                fontWeight: FontWeight.w600,
                                decoration: tasks[index].isComleted!
                                    ? TextDecoration.underline
                                    : TextDecoration.none),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await BlocProvider.of<NotificationCubit>(context)
                          .setNotification(taskModel: tasks[index]);
                    },
                    icon: Icon(
                      Icons.notifications,
                      color:
                          tasks[index].doNotify! ? Colors.yellow : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _markCompletion(int index) {
    return CircleAvatar(
      radius: 14,
      backgroundColor:
          tasks[index].isComleted! ? Colors.green : Constants.checkerColor,
      child: CircleAvatar(
        radius: 12,
        backgroundColor: tasks[index].isComleted! ? Colors.green : Colors.white,
        child: tasks[index].isComleted!
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
