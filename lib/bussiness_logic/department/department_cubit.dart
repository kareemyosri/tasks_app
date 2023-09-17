import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasks_app/bussiness_logic/database/remoteDatabase/DioHelper.dart';
import 'package:tasks_app/bussiness_logic/database/remoteDatabase/endpoints.dart';
import 'package:tasks_app/model/create_departmentModel.dart';
import 'package:tasks_app/model/update_department.dart';

part 'department_state.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit() : super(DepartmentInitial());
  static DepartmentCubit get(context)=>BlocProvider.of(context);

  CreateDepartmentModel? createDepartmentModel;
  createDepartment(String name){
    emit(CreateDepartmentLoadingState());
    DioHelper.PostData(url: createDepartmentPath,data: {
      'name':name
    })
        .then((value) {
          createDepartmentModel=CreateDepartmentModel.fromJson(value.data);
          print(createDepartmentModel?.data?.id);
          print(value.data);

          emit(CreateDepartmentSuccessfullyState());

    }).
    catchError((error){
      print(error.toString());
      emit(CreateDepartmentErrorState());
    });
  }

  UpdateDepartmentModel? updateDepartmentModel;
  updateDepartment(String name,String id){
    emit(UpdateDepartmentLoadingState());
    DioHelper.PostData(url: "$updateDepartmentPath${createDepartmentModel?.data?.id}",data: {
      'name':name,
      'manager_id':id
    })
        .then((value) {
      updateDepartmentModel=UpdateDepartmentModel.fromJson(value.data);
      print(updateDepartmentModel?.message);
      print(value.data);

      emit(UpdateDepartmentSuccessfullyState());

    }).
    catchError((error){
      print(error.toString());
      emit(UpdateDepartmentErrorState());
    });
  }
}
