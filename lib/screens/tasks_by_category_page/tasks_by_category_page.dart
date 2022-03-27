import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/constants/constants.dart';
import 'package:todo_app/core/data/local_data.dart';
import 'package:todo_app/core/models/categorys_model.dart';
import 'package:todo_app/core/models/task_model.dart';
import 'package:todo_app/core/utils/size_config.dart';
import 'package:todo_app/screens/home_page/presentation/cubit/tasks_cubit.dart';
import 'package:todo_app/screens/provider/category_provider.dart';

class TasksByCategoryPage extends StatefulWidget {
  TasksByCategoryPage({required this.category, Key? key}) : super(key: key);
  // List<TaskModel> tasks;
  String category;

  @override
  State<TasksByCategoryPage> createState() => _TasksByCategoryPageState();
}

class _TasksByCategoryPageState extends State<TasksByCategoryPage> {
  @override
  Widget build(BuildContext context) {
    context.read<CategoryProvider>().byCategories(widget.category);
    List<TaskModel> tasks = context.watch<CategoryProvider>().ctasks;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: getHeight(70),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Your category tasks",
              style: TextStyle(fontSize: Constants.h2),
            ),
            Text(
              "You have 9 tasks",
              style: TextStyle(fontSize: Constants.h2),
            )
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: getWidth(15), vertical: getHeight(10)),
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
                    setState(() {});
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
                        setState(() {});
                      },
                      child: _markCompletion(index, context, tasks),
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
                      onPressed: () {}, icon: const Icon(Icons.notifications)),
                ),
              ),
            ),
          );
        },
        itemCount: tasks.length,
      ),
    );
  }
  

  Widget _markCompletion(int index, BuildContext context, tasks) {
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
