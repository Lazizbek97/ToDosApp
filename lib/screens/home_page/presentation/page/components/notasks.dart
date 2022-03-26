import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/constants.dart';
import 'package:todo_app/core/utils/size_config.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: getHeight(70)),
            child: SizedBox(
              height: getHeight(164),
              width: getWidth(119),
              child: Image.asset("assets/images/home_empty.png"),
            ),
          ),
          Text(
            "No tasks",
            style: TextStyle(
              fontSize: Constants.h1,
              color: Constants.textColor,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
