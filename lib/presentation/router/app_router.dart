
import 'package:flutter/material.dart';
import 'package:tasks_app/presentation/router/app_route.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';


Route? onGenerateRouter(RouteSettings settings){
  switch(settings.name){

    case AppRoute.loginScreen:
      return MaterialPageRoute(builder: (_)=>  const LoginScreen());

    case AppRoute.homeScreen:
      return MaterialPageRoute(builder: (_)=>  HomeScreen());
    // case AppRoute.registerScreen:
    //   return MaterialPageRoute(builder: (_)=>  RegisterScreenTask());
    // case AppRoute.loginScreen:
    //   return MaterialPageRoute(builder: (_)=>  LoginScreenTask());

    default:
      return null;

  }

}