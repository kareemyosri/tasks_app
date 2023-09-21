import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasks_app/bussiness_logic/database/remoteDatabase/endpoints.dart';
import 'package:tasks_app/core/enums.dart';

import '../../core/constants.dart';
import '../../model/department_employeesModel.dart';
import '../../model/get_departments_employessModel.dart';
import '../database/local_database/cache_helper.dart';
import '../database/remoteDatabase/DioHelper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  userLogout() {
    DioHelper.PostData(url: logout)
        .then((value) {
      print(value.data);
      emit(UserLogoutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UserLogoutErrorState());
    });
  }


  List<DepartmentsAndEmployeesData> departmentsAndEmployeesData = [];

  List<Employees> departmentEmployeesData = [];

  DepartmentsAndEmployeesModel? departmentsAndEmployeesModel;
  EmployeesInDepartmentModel? employeesInDepartmentModel;

  getDepartmentsAndEmployees() {
    emit(DepartmentsAndEmployeesLoadingState());
    if (CashHelper.getString(key: MySharedKeys.userType) == 'admin') {
      DioHelper.getData(url: getDepartmentsWithEmployees).then((value) {
        departmentsAndEmployeesModel =
            DepartmentsAndEmployeesModel.fromJson(value.data);
        for (var element in value.data['data']) {
          departmentsAndEmployeesData.add(
              DepartmentsAndEmployeesData.fromJson(element));
          print(element);
        }
        // print(employeeTasks);


        emit(DepartmentsAndEmployeesSuccessfullyState());
      }).catchError((error) {
        print(error.toString());
        emit(DepartmentsAndEmployeesErrorState());
      });
    }
    else {
      DioHelper.getData(url: getEmployeesOfDepartment).then((value) {
        employeesInDepartmentModel =
            EmployeesInDepartmentModel.fromJson(value.data);
        for (var element in value.data['data']) {
          departmentEmployeesData.add(Employees.fromJson(element));
          print(element);
        }
        // print(employeeTasks);


        emit(DepartmentsAndEmployeesSuccessfullyState());
      }).catchError((error) {
        print(error.toString());
        emit(DepartmentsAndEmployeesErrorState());
      });
    }
  }

  String type = CashHelper.getString(key: MySharedKeys.userType);

  bool checkUserType() {
    if (type == 'admin') {
      return true;
    }
    else {
      return false;
    }
  }

  deleteDepartment(int depId) {
    emit(DeleteDepartmentLoadingState());
    DioHelper.DeleteData(url: '$DeleteDepartment${depId.toString()}').then((
        value) {
      getDepartmentsAndEmployees();


      emit(DeleteDepartmentSuccessfullyState());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteDepartmentErrorState());
    });
  }



  String? selectedItem;

  getIdValue(newValue){
    selectedItem = newValue;
    // Find the corresponding integer value
    selectedValueAsManager = departmentEmployeesData
        .firstWhere((item) => item.email == newValue)
        .id;

    emit(GetValueSuccessfullyState());
  }



}
