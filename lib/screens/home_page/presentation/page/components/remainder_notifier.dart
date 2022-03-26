import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/constants.dart';
import 'package:todo_app/core/utils/size_config.dart';

class RemainderNotifier extends StatelessWidget {
  const RemainderNotifier({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: getHeight(105),
          width: getWidth(339),
          padding: EdgeInsets.symmetric(
              vertical: getWidth(8.0), horizontal: getWidth(13)),
          margin: EdgeInsets.all(getWidth(10)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today Remainder",
                    style: TextStyle(
                      fontSize: Constants.size20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Meeting with client",
                    style: TextStyle(
                      fontSize: Constants.h4,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "13:00 PM",
                    style: TextStyle(
                      fontSize: Constants.h4,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(right: getWidth(15)),
                child: SizedBox(
                  height: getHeight(66),
                  width: getWidth(52),
                  child: Image.asset(
                    "assets/images/bell.png",
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          right: getWidth(5),
          top: getHeight(5),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.clear,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
