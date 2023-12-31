part of 'department_cubit.dart';

@immutable
abstract class DepartmentState {}

class DepartmentInitial extends DepartmentState {}

class CreateDepartmentLoadingState extends DepartmentState {}
class CreateDepartmentSuccessfullyState extends DepartmentState {}
class CreateDepartmentErrorState extends DepartmentState {}

class UpdateDepartmentLoadingState extends DepartmentState {}
class UpdateDepartmentSuccessfullyState extends DepartmentState {}
class UpdateDepartmentErrorState extends DepartmentState {}

class GetManagersLoadingState extends DepartmentState {}
class GetManagersSuccessfullyState extends DepartmentState {}
class GetManagersErrorState extends DepartmentState {}

class GetValueSuccessfullyState extends DepartmentState {}