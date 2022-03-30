// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'task_model.g.dart';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  TaskModel(
      {this.title,
      this.category,
      this.time,
      this.disc,
      this.isComleted,
      this.date,
      this.doNotify});

  @HiveField(0)
  String? title;
  @HiveField(1)
  String? category;
  @HiveField(2)
  String? time;
  @HiveField(3)
  String? disc;
  @HiveField(4)
  bool? isComleted;
  @HiveField(5)
  String? date;
  @HiveField(6)
  bool? doNotify;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json["title"],
        category: json["category"],
        time: json["time"],
        disc: json["disc"],
        isComleted: json['isComleted'],
        date: json["date"],
        doNotify: json["doNotify"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "category": category,
        "time": time,
        "disc": disc,
        "isComleted": isComleted,
        "date": date,
        "doNotify": doNotify,
      };
}
