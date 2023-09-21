part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class UserLogoutSuccessState extends HomeState {}
class UserLogoutErrorState extends HomeState {}

class DepartmentsAndEmployeesLoadingState extends HomeState {}
class DepartmentsAndEmployeesSuccessfullyState extends HomeState {}
class DepartmentsAndEmployeesErrorState extends HomeState {}

class DeleteDepartmentSuccessfullyState extends HomeState {}
class DeleteDepartmentErrorState extends HomeState {}
class DeleteDepartmentLoadingState extends HomeState {}

class GetValueSuccessfullyState extends HomeState {}