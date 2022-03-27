import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/constants.dart';
import 'package:todo_app/core/data/local_data.dart';
import 'package:todo_app/core/utils/size_config.dart';
import 'package:todo_app/screens/provider/category_provider.dart';

class TaskCategoriesPage extends StatelessWidget {
  const TaskCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          context
              .read<CategoryProvider>()
              .byCategories(Categories.get[index]['title']);
          var ctasks = context.watch<CategoryProvider>().ctasks;

          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/bycategory", arguments: ctasks);
            },
            child: CategoryCard(
              index: index,
            ),
          );
        },
        itemCount: Categories.get.length,
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  CategoryCard({
    required this.index,
    Key? key,
  }) : super(key: key);

  int index;

  @override
  Widget build(BuildContext context) {
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
  }
}
