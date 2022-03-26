// To parse this JSON data, do
//
//     final CategoriesModel = CategoriesModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

CategoriesModel CategoriesModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str));

String CategoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
  CategoriesModel({
    this.icon,
    this.title,
    this.color,
    this.tasks,
  });

  String? icon;
  String? title;
  Color? color;
  List<dynamic>? tasks;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        icon: json["icon"],
        title: json["title"],
        color: json["color"],
        tasks: List<dynamic>.from(json["tasks"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "title": title,
        "color": color,
        "tasks": List<dynamic>.from(tasks!.map((x) => x)),
      };
}
