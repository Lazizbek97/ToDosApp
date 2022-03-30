import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/domain/notification_repository.dart';
import 'package:todo_app/core/models/task_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificaitonUsecase notificationUsecase;

  NotificationCubit(this.notificationUsecase) : super(NotificationInitial()) {
    notificationUsecase.initNotification(true);
  }

  Future<void> initNotification() async {
    await notificationUsecase.initNotification(true);
  }

  Future<void> setNotification({required TaskModel taskModel}) async {
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

    // ? Set notifications
    if (taskModel.doNotify!) {
      await notificationUsecase.setNotification(
          id: taskModel.key,
          title: taskModel.title!,
          body: taskModel.disc!,
          payload: "payload",
          datetime: datetime);
    }
  }

  Future<void> cancelNotification(TaskModel taskModel) async {
    await notificationUsecase.cancelNotification(taskModel.key);
  }
}
