part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class CreateUserLoadingState extends UserState {}
class CreateUserSuccessfullyState extends UserState {}
class CreateUserErrorState extends UserState {}

class ChangeUserTypeState extends UserState {}

class UpdateUserLoadingState extends UserState {}
class UpdateUserSuccessfullyState extends UserState {}
class UpdateUserErrorState extends UserState {}
