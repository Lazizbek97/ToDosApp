import 'package:todo_app/core/services/notifications_service.dart';

abstract class NotificaionRepository {
  const NotificaionRepository();
  Future<void> initNotification(bool initScheduled);
  Future<void> setNotification(
      {required DateTime datetime,
      required int id,
      required String title,
      required String body,
      required String payload});
  Future<void> cancelNotification(int id);
}

class TodoNotFoundException implements Exception {}

class NotificaitonUsecase extends NotificaionRepository {
  final LocalNotificationService notification;

  NotificaitonUsecase(this.notification) {
    notification.init();
  }

  @override
  Future<void> cancelNotification(int id) async {
    await notification.cancelNotification(id);
  }

  @override
  Future<void> setNotification(
      {required DateTime datetime,
      required int id,
      required String title,
      required String body,
      required String payload}) async {
    await notification.setNotificationScheduledDailyBasis(
      id: id,
      body: body,
      payload: payload,
      title: title,
      scheduledDate: datetime,
    );
  }

  @override
  Future<void> initNotification(bool initScheduled) async {
    await notification.init(initScheduled: initScheduled);
  }
}
