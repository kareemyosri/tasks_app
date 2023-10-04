import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasks_app/core/enums.dart';

import '../../model/get_employeeModel.dart';
import '../database/local_database/cache_helper.dart';
import '../database/remoteDatabase/DioHelper.dart';
import '../database/remoteDatabase/endpoints.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial()) ;
 static TaskCubit get(context)=> BlocProvider.of(context);

  late int buttonValue;

  setButtonValue( state){
    emit(ChangeTaskStatusState());

    if(state=='new'){
      return buttonValue=0;
    }
    else if(state=='processing'){
      return buttonValue=1;
    }
    else if(state=='notcompleted'){
     return buttonValue=3;
    }
    else if(state=='expired'){
      return buttonValue=5;
    }
    else if(state=='cancelled'){
       return buttonValue=4;
    }
    else{
    return  buttonValue=2;
    }

  }


  changeTaskStatus(value) {
    buttonValue = value;
    emit(ChangeTaskStatusState());
  }

  //Employee
  EmployeeTaskModel? employeeTaskModel;
  List<TaskData> employeeTasks=[];

  //String type= CashHelper.getString(key: MySharedKeys.userType);
  getTasks(){
    emit(TaskLoadingState());
    employeeTasks=[];
    DioHelper.getData(url: getEmployeeTask).then((value) {
      employeeTaskModel = EmployeeTaskModel.fromJson(value.data);
      for(var element in value.data['data']  ){
         employeeTasks.add(TaskData.fromJson(element));
         print(element);
      }
     // print(employeeTasks);
      if(employeeTasks.isNotEmpty){
        emit(TaskSuccessfullyState());

      }
      else{
        emit(EmptyTask());
      }

    }).catchError((error) {
      print(error.toString());
      emit(TaskErrorState());
    });
  }
String type= CashHelper.getString(key: MySharedKeys.userType);
  bool checkUserType(){
    if(type=='admin'||type=='manager'){
      return true;
    }
    else{
      return false;
    }
  }

  userLogout(){
    DioHelper.PostData(url: logout)
        .then((value) {

      print(value.data);
      emit(UserLogoutSuccessfullyState());
    }).catchError((error) {
      print(error.toString());
      emit(UserLogoutErrorrState());
    });

  }

  deleteTask(int taskId) {
    emit(DeleteTaskLoadingState());
    DioHelper.DeleteData(url: '$DeleteTask${taskId.toString()}').then((
        value) {
    //  getDepartmentsAndEmployees();
      getTasks();

      emit(DeleteTaskSuccessfullyState());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteTaskErrorState());
    });
  }

}
