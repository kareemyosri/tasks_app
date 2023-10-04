
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasks_app/model/loginModel.dart';

import '../database/remoteDatabase/DioHelper.dart';
import '../database/remoteDatabase/endpoints.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context)=>BlocProvider.of(context);
  bool isChecked=false;

  changeCheckBox(checked){
    isChecked= checked;
    emit(ChangeRememberState());
  }
  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.PostData(url: login, data: {
      'email': email,
      "password": password,

    }).then((value) {
      emit(LoginLoadingState());
      loginModel = LoginModel.fromJson(value.data);
      //print(loginModel?.token);
      //print(loginModel?.data?.id);
      //print(value.data);
      emit(LoginSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState());
    });
  }


  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(ChangePasswordVisibilityState());
  }

}
