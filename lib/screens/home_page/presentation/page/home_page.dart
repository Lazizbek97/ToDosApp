import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/core/constants/constants.dart';
import 'package:todo_app/core/utils/size_config.dart';
import 'package:todo_app/screens/home_page/presentation/cubit/tasks_cubit.dart';
import 'package:todo_app/screens/home_page/presentation/page/components/alltasks.dart';
import 'package:todo_app/screens/home_page/presentation/page/components/notasks.dart';
import 'package:todo_app/screens/task_categories/task_categories.dart';
import 'package:todo_app/screens/task_status/add_new_task.dart';

import 'components/remainder_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  final List _pages = [const HomeTasksPage(), const TaskCategoriesPage()];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TasksCubit>(context).getTasks();
    return Scaffold(
      appBar: _myAppBar(),
      body: _pages[_pageIndex],
      floatingActionButton: _floatActionBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          _pageIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/home.svg",
                color: _pageIndex == 0 ? Colors.blue : Colors.grey,
              ),
              label: ""),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/tasks.svg",
                color: _pageIndex == 1 ? Colors.blue : Colors.grey),
            label: "",
          ),
        ],
      ),
    );
  }

  _floatActionBtn() => FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return AddNewTask();
            },
          );
        },
        child: SvgPicture.asset("assets/images/add.svg"),
      );

  _myAppBar() => AppBar(
        toolbarHeight: getHeight(106),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Hello Lazizbek!",
              style: TextStyle(fontSize: Constants.h2),
            ),
            Text(
              "You have 9 tasks",
              style: TextStyle(fontSize: Constants.h2),
            )
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: getWidth(15)),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
            ),
          )
        ],
        bottom: PreferredSize(
          child: const RemainderNotifier(),
          preferredSize: Size(
            getWidth(300),
            getHeight(100),
          ),
        ),
      );
}

class HomeTasksPage extends StatelessWidget {
  const HomeTasksPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TasksCubit>(context).getTasks();
    return BlocConsumer<TasksCubit, TasksState>(
      listener: ((context, state) {}),
      builder: (context, state) {
        if (state is TasksInitial) {
          return const NoTasks();
        } else if (state is TasksLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is TaskLoaded) {
          return state.tasks.isEmpty
              ? const NoTasks()
              : AllTasks(
                  tasks: state.tasks,
                );
        }
        return Center(
          child: Text((state as TaskErorr).message),
        );
      },
    );
  }
}
