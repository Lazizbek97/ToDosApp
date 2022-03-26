import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/constants.dart';
import 'package:todo_app/core/hive/hive_boxes.dart';
import 'package:todo_app/core/utils/size_config.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: getHeight(670),
            padding: EdgeInsets.only(top: getHeight(100)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getHeight(195),
                  width: getWidth(180),
                  child: Image.asset(
                    "assets/images/entry.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  "Remainders made simple",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Constants.h1,
                    color: Constants.textColor,
                  ),
                ),
                SizedBox(
                  height: getHeight(56),
                  width: getWidth(258),
                  child: ElevatedButton(
                    onPressed: () async {
                      // await Boxes.getTask().clear();
                      Navigator.pushReplacementNamed(context, "/home");
                    },
                    child: const Text("Get started"),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
