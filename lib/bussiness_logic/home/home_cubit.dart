import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasks_app/bussiness_logic/database/remoteDatabase/endpoints.dart';

import '../database/remoteDatabase/DioHelper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context)=>BlocProvider.of(context);

  userLogout(){
    DioHelper.PostData(url: logout)
        .then((value) {

      print(value.data);
      emit(UserLogoutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UserLogoutErrorState());
    });

  }

}
