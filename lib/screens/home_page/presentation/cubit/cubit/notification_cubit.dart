import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/domain/notification_repository.dart';
import 'package:todo_app/core/domain/task__crud_repository.dart';
import 'package:todo_app/core/models/task_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificaitonUsecase notificationUsecase;
  final Task_Crud _taskModelRepository;

  NotificationCubit(this.notificationUsecase, this._taskModelRepository)
      : super(NotificationInitial()) {
    notificationUsecase.initNotification(true);
  }

  Future<void> initNotification() async {
    await notificationUsecase.initNotification(true);
    emit(NotificationAvialible());
  }

  Future<void> cancelNotification({required TaskModel taskModel}) async {
    await notificationUsecase.cancelNotification(taskModel.key);

    emit(NotificationAvialible());
  }

  Future<void> setNotification({required TaskModel taskModel}) async {
    DateTime dateTime = formatedDate(taskModel);
    // ? Set notifications
    if (!taskModel.doNotify!) {
      try {
        await notificationUsecase.setNotification(
          id: taskModel.key,
          title: taskModel.title!,
          body: taskModel.disc!,
          payload: "payload",
          datetime: dateTime,
        );
        emit(NotificationAvialible());
        await _taskModelRepository.changeNotifier(taskModel);
      } catch (e) {
        String error = "Time is not ahead of now!";
        emit(NotificationInvalidTime(error));
      }
    } else {
      await notificationUsecase.cancelNotification(taskModel.key);
      await _taskModelRepository.changeNotifier(taskModel);

      emit(NotificationAvialible());
    }
  }

  Future<void> completedNotification(TaskModel taskModel) async {
    DateTime dateTime = formatedDate(taskModel);
    print(taskModel.isComleted.toString());

    if (taskModel.isComleted!) {
      await notificationUsecase.cancelNotification(taskModel.key);

      if (taskModel.doNotify!) {
        await _taskModelRepository.changeNotifier(taskModel);
      }
      emit(NotificationAvialible());
    } else {
      try {
        await notificationUsecase.setNotification(
          id: taskModel.key,
          title: taskModel.title!,
          body: taskModel.disc!,
          payload: "payload",
          datetime: dateTime,
        );
        emit(NotificationAvialible());
        await _taskModelRepository.changeNotifier(taskModel);
      } catch (e) {
        String error = "Time is not ahead of now!";
        emit(NotificationInvalidTime(error));
      }
    }
  }

  formatedDate(TaskModel taskModel) {
    DateTime date = DateFormat("yyyy-MM-dd").parse(taskModel.date!);
    TimeOfDay time = TimeOfDay(
        hour: int.parse(taskModel.time!.split(":")[0]),
        minute: int.parse(taskModel.time!.split(":")[1]));

    DateTime datetime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    return datetime;
  }
}
