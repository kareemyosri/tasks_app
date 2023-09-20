import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasks_app/bussiness_logic/database/remoteDatabase/endpoints.dart';
import 'package:tasks_app/model/create_taskModel.dart';

import '../../core/constants.dart';
import '../../model/get_employeesModel.dart';
import '../database/remoteDatabase/DioHelper.dart';

part 'addtask_state.dart';

class AddtaskCubit extends Cubit<AddtaskState> {
  AddtaskCubit() : super(AddtaskInitial());

  static AddtaskCubit get(context)=>BlocProvider.of(context);
  List<DateTime?> rangeDatePickerValueWithDefaultValue = [
    DateTime.now(),
    DateTime.now(),
  ];

  changeDate(date){
    rangeDatePickerValueWithDefaultValue=date;
    emit(ChangeTaskDateState());
  }

 // CreateUserModel? createUserModel;
  CreateTaskModel? createTaskModel;

  void createTask({
    required String title,
    required String description,
    required String employeeId,

    required String startDate,
    required String endDate,



  }) {
    DioHelper.PostData(url: createTaskPath, data: {
      'name': title,
      'description': description,
      'status':0,
      'start_date': startDate,
      "end_date": endDate,

      'employee_id': employeeId,

    }).then((value) {
      emit(CreateTaskLoadingState());

      createTaskModel = CreateTaskModel.fromJson(value.data);
      //print(loginModel?.token);
      //print(loginModel?.data?.id);
      print(value.data);
      emit(CreateTaskSuccessfullyState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateTaskErrorState());
    });
  }


  GetEmployeesModel? getEmployeesModel;
  //List<int> employeesID=[];
 // List<Map<String,int>> employees=[];
  List<EmployeeData> employees=[];

  void getEmployees() {
    DioHelper.getData(url: getEmployeesPath).then((value) {
      emit(GetEmployeesLoadingState());

      getEmployeesModel = GetEmployeesModel.fromJson(value.data);
      for(var element in value.data['data']){
        //employeesID.add(element['id']);
       // employeesName.add(element['name']);
        employees.add(EmployeeData.fromJson(element));
}
      //print(employeesID);
      //print(employeesName);
      print(employees);
      //print(loginModel?.token);
      //print(loginModel?.data?.id);
      //print(value.data);
      emit(GetEmployeesSuccessfullyState());
    }).catchError((error) {
      print(error.toString());
      emit(GetEmployeesErrorState());
    });
  }
  String? selectedItem;
  getIdValue(newValue){
    selectedItem = newValue;
    // Find the corresponding integer value
    selectedValue = employees
        .firstWhere((item) => item.email == newValue)
        .id;
    selectedDepartment = employees
        .firstWhere((item) => item.email == newValue)
        .departmentId;

    emit(GetValueSuccessfullyState());
  }



}
