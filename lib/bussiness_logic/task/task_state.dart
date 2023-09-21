part of 'task_cubit.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class ChangeTaskStatusState extends TaskState {}

class TaskLoadingState extends TaskState {}
class TaskSuccessfullyState extends TaskState {}
class TaskErrorState extends TaskState {}


class UserLogoutSuccessfullyState extends TaskState {}

class UserLogoutErrorrState extends TaskState {}

class DeleteTaskLoadingState extends TaskState {}
class DeleteTaskSuccessfullyState extends TaskState {}
class DeleteTaskErrorState extends TaskState {}

