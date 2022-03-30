import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/core/constants/constants.dart';
import 'package:todo_app/core/data/local_data.dart';
import 'package:todo_app/core/domain/task__crud_repository.dart';
import 'package:todo_app/core/models/categorys_model.dart';
import 'package:todo_app/core/services/task_service.dart';
import 'package:todo_app/core/utils/size_config.dart';
import 'package:todo_app/screens/task_status/cubit/addingtask_cubit.dart';

class AddNewTask extends StatelessWidget {
  AddNewTask({
    Key? key,
  }) : super(key: key);

  final TextEditingController _textController = TextEditingController();

  List<CategoriesModel> all_categ =
      Categories.get.map((e) => CategoriesModel.fromJson(e)).toList();

  @override
  Widget build(BuildContext context) {
    TaskService service = TaskService();
    return BlocProvider<AddingtaskCubit>(
        create: (BuildContext context) => AddingtaskCubit(
              taskModelRepository: Task_Crud(taskService: service),
            ),
        child: BlocConsumer<AddingtaskCubit, AddingtaskState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Stack(
              children: [
                Container(
                  height: getHeight(691),
                  margin: EdgeInsets.only(top: getHeight(25)),
                  padding: EdgeInsets.symmetric(
                      horizontal: getWidth(20), vertical: getHeight(50)),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(170, 30),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Add new task",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      _textInputField(),
                      SizedBox(
                        height: getHeight(62),
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              BlocProvider.of<AddingtaskCubit>(context)
                                  .chooseCategory(index);
                            },
                            child: _categoryButton(index, context),
                          ),
                          itemCount: all_categ.length,
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            context
                                .read<AddingtaskCubit>()
                                .selectDateAndTime(context);
                          },
                          child: const Text(
                            "Choose date",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: context.watch<AddingtaskCubit>().isValidTask,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            context
                                    .watch<AddingtaskCubit>()
                                    .selectedTime
                                    .hour
                                    .toString() +
                                ":" +
                                context
                                    .watch<AddingtaskCubit>()
                                    .selectedTime
                                    .minute
                                    .toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: SizedBox(
                          height: getHeight(53),
                          width: getWidth(323),
                          child: ElevatedButton(
                            onPressed: () async {
                              await BlocProvider.of<AddingtaskCubit>(context)
                                  .addNewTask(
                                    title: _textController.text,
                                    disc: "no disc",
                                    isCompleted: false,
                                  )
                                  .whenComplete(
                                    () => Navigator.pushReplacementNamed(
                                        context, "/home"),
                                  );
                            },
                            child: Text(
                              "Add task",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: Constants.h2,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xff7EB6FF)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: getWidth(161),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Constants.elevatedBtnColor,
                    child: SvgPicture.asset("assets/images/close.svg"),
                  ),
                )
              ],
            );
          },
        ));
  }

  Widget _textInputField() => TextFormField(
        controller: _textController,
        cursorColor: Colors.black,
        cursorHeight: getHeight(32),
        autofocus: true,
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      );

  Widget _categoryButton(int index, BuildContext context) => Container(
        height: getHeight(27),
        width: getWidth(100),
        margin: EdgeInsets.symmetric(
          vertical: getHeight(5.0),
          horizontal: getWidth(8.0),
        ),
        padding: EdgeInsets.all(getWidth(5.0)),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade300),
          color: context.watch<AddingtaskCubit>().categoryIndex == index
              ? Categories.get[index]['color']
              : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 5,
              backgroundColor: all_categ[index].color,
            ),
            Text(all_categ[index].title!)
          ],
        ),
      );
}
