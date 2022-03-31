part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationAvialible extends NotificationState {
  NotificationAvialible();
}



class NotificationInvalidTime extends NotificationState {
  String error;
  NotificationInvalidTime(this.error);
}
