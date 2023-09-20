
import 'package:flutter/material.dart';
import 'package:tasks_app/presentation/router/app_route.dart';
import 'package:tasks_app/presentation/screens/create_derpartment.dart';
import 'package:tasks_app/presentation/screens/create_user.dart';
import 'package:tasks_app/presentation/screens/update_department.dart';
import 'package:tasks_app/presentation/screens/update_user.dart';
import 'package:tasks_app/presentation/screens/user_page/user_page.dart';
import 'package:tasks_app/presentation/screens/user_tasks.dart';

import '../screens/add_new_task.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';


Route? onGenerateRouter(RouteSettings settings){
  switch(settings.name){

    case AppRoute.loginScreen:
      return MaterialPageRoute(builder: (_)=>  const LoginScreen());

    case AppRoute.homeScreen:
      return MaterialPageRoute(builder: (_)=>  const HomeScreen());
    case AppRoute.userPageScreen:
      return MaterialPageRoute(builder: (_)=>  const UserPage());
    case AppRoute.userTasksScreen:
      return MaterialPageRoute(builder: (_)=>  const UserTasks());

    case AppRoute.createUserScreen:
      return MaterialPageRoute(builder: (_)=>  const CreateUser());
    case AppRoute.updateUserScreen:
      return MaterialPageRoute(builder: (_)=>  const UpdateUser());
    case AppRoute.createDepartmentScreen:
      return MaterialPageRoute(builder: (_)=>  const CreateDepartment());
    case AppRoute.updateDepartmentScreen:
      return MaterialPageRoute(builder: (_)=>  const UpdateDepartment());
    case AppRoute.createTaskScreen:
      return MaterialPageRoute(builder: (_)=>  const AddNewTask());
    // case AppRoute.registerScreen:
    //   return MaterialPageRoute(builder: (_)=>  RegisterScreenTask());
    // case AppRoute.loginScreen:
    //   return MaterialPageRoute(builder: (_)=>  LoginScreenTask());

    default:
      return null;

  }

}