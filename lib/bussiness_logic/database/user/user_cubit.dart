import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasks_app/bussiness_logic/add_new_task/addtask_cubit.dart';
import 'package:tasks_app/model/create_userModel.dart';
import 'package:tasks_app/model/update_userModel.dart';

import '../../../core/constants.dart';
import '../../../core/enums.dart';
import '../local_database/cache_helper.dart';
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
    if(CashHelper.getString(key: MySharedKeys.userType)=='admin'){
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
    else  {
      DioHelper.PostData(url: createUserPath, data: {
        'name': name,
        'email': email,
        'phone': phone,
        "password": password,
        'user_type': "2",
        //'department_id':
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
    emit(UpdateUserLoadingState());

    if(CashHelper.getString(key: MySharedKeys.userType)=='admin'){
      DioHelper.PostData(url: "${updateUserPath}${createUserModel?.data?.id}", data: {
        'name': name,
        'email': email,
        'phone': phone,
        "password": password,
        'user_type': buttonValueUpdate.toString(),
        'user_status': status,
        'department_id': depId
      }).then((value) {

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

    else{
      DioHelper.PostData(url: "$updateUserPath$selectedValue", data: {
        'name': name,
        'email': email,
        'phone': phone,
        "password": password,
        'user_type': "2",
        'user_status': status,
        'department_id': selectedDepartment
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


  }
  changeUpdateUserValue(value) {
    buttonValueUpdate = value;
    emit(ChangeUserTypeState());
  }

}
