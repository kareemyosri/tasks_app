import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasks_app/model/create_userModel.dart';
import 'package:tasks_app/model/update_userModel.dart';

import '../remoteDatabase/DioHelper.dart';
import '../remoteDatabase/endpoints.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);
  int buttonValue = 0;

  changeUserValue(value) {
    buttonValue = value;
    emit(ChangeUserTypeState());
  }


  CreateUserModel? createUserModel;

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String password,

  }) {
    DioHelper.PostData(url: createUserPath, data: {
      'name': name,
      'email': email,
      'phone': phone,
      "password": password,
      'user_type': buttonValue.toString(),
    }).then((value) {
      emit(CreateUserLoadingState());

      createUserModel = CreateUserModel.fromJson(value.data);
      //print(loginModel?.token);
      //print(loginModel?.data?.id);
      print(value.data);
      emit(CreateUserSuccessfullyState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState());
    });
  }

  int buttonValueUpdate = 0;

  UpdateUserModel? updateUserModel;

  void updateUser({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String depId,
    required String status,

  }) {
    DioHelper.PostData(url: "${updateUserPath}${createUserModel?.data?.id}", data: {
      'name': name,
      'email': email,
      'phone': phone,
      "password": password,
      'user_type': buttonValueUpdate.toString(),
      'user_status': status,
      'department_id': depId
    }).then((value) {
      emit(CreateUserLoadingState());

      updateUserModel = UpdateUserModel.fromJson(value.data);
      print(updateUserModel?.data?.id);
      //print(loginModel?.token);
      //print(loginModel?.data?.id);
      print(value.data);
      emit(UpdateUserSuccessfullyState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserErrorState());
    });
  }
  changeUpdateUserValue(value) {
    buttonValueUpdate = value;
    emit(ChangeUserTypeState());
  }

}
