part of 'addtask_cubit.dart';

@immutable
abstract class AddtaskState {}

class AddtaskInitial extends AddtaskState {}
class ChangeTaskDateState extends AddtaskState {}


class CreateTaskLoadingState extends AddtaskState {}
class CreateTaskSuccessfullyState extends AddtaskState {}
class CreateTaskErrorState extends AddtaskState {}


class GetEmployeesLoadingState extends AddtaskState {}
class GetEmployeesSuccessfullyState extends AddtaskState {}
class GetEmployeesErrorState extends AddtaskState {}

class GetValueSuccessfullyState extends AddtaskState {}
