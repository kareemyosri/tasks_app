import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasks_app/bussiness_logic/database/remoteDatabase/DioHelper.dart';
import 'package:tasks_app/bussiness_logic/database/remoteDatabase/endpoints.dart';
import 'package:tasks_app/model/create_departmentModel.dart';
import 'package:tasks_app/model/get_managersModel.dart';
import 'package:tasks_app/model/update_department.dart';

import '../../model/get_departments_employessModel.dart';

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

  updateDepartment(String name){
    emit(UpdateDepartmentLoadingState());
    DioHelper.PostData(url: "$updateDepartmentPath$selectedValue2",data: {
      'name':name,
      'manager_id':selectedValue.toString()
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

  List<ManagerData> managers=[];
  ManagersModel? managersModel;
  void getManagers() {
    DioHelper.getData(url: getManagersNotAssigned).then((value) {
      emit(GetManagersLoadingState());

      managersModel = ManagersModel.fromJson(value.data);
      for(var element in value.data['data']){
        //employeesID.add(element['id']);
        // employeesName.add(element['name']);
        managers.add(ManagerData.fromJson(element));
      }
      print(managers);

      emit(GetManagersSuccessfullyState());
    }).catchError((error) {
      print(error.toString());
      emit(GetManagersErrorState());
    });
  }

  String? selectedItem;
  String? selectedItem2;

  int? selectedValue;
  int? selectedValue2;

  getIdValue(newValue){
    selectedItem = newValue;
    // Find the corresponding integer value
    selectedValue = managers
        .firstWhere((item) => item.email == newValue)
        .id;
    print(selectedValue);

    emit(GetValueSuccessfullyState());
  }

  getIdValue2(newValue,List<DepartmentsAndEmployeesData> list){
    selectedItem2 = newValue;
    // Find the corresponding integer value
    selectedValue2 = list
        .firstWhere((item) => item.name == newValue)
        .id;
    print(selectedValue2);

    emit(GetValueSuccessfullyState());
  }
}
