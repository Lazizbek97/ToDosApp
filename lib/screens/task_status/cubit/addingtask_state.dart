part of 'addingtask_cubit.dart';

@immutable
abstract class AddingtaskState {}

class AddingtaskInitial extends AddingtaskState {}

class AddingtaskError extends AddingtaskState {
  String errorMessage;
  AddingtaskError(this.errorMessage);
}

class AddedTask extends AddingtaskState {}
class ChoosedCategory extends AddingtaskState {}


class AddingTaskValidateState extends AddingtaskState {
  bool isValidTask;
  AddingTaskValidateState(this.isValidTask);
}

