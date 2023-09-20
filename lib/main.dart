import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_app/bussiness_logic/database/user/user_cubit.dart';
import 'package:tasks_app/bussiness_logic/department/department_cubit.dart';
import 'package:tasks_app/bussiness_logic/home/home_cubit.dart';
import 'package:tasks_app/bussiness_logic/login/login_cubit.dart';
import 'package:tasks_app/bussiness_logic/task/task_cubit.dart';
import 'package:tasks_app/presentation/router/app_router.dart';
import 'package:tasks_app/presentation/screens/add_new_task.dart';
import 'package:tasks_app/presentation/screens/create_derpartment.dart';
import 'package:tasks_app/presentation/screens/create_user.dart';
import 'package:tasks_app/presentation/screens/login_screen.dart';
import 'package:tasks_app/presentation/screens/single_task.dart';
import 'package:tasks_app/presentation/screens/update_department.dart';
import 'package:tasks_app/presentation/screens/update_user.dart';
import 'package:tasks_app/presentation/screens/user_page/user_page.dart';
import 'package:tasks_app/presentation/screens/user_tasks.dart';

import 'bussiness_logic/add_new_task/addtask_cubit.dart';
import 'bussiness_logic/database/local_database/cache_helper.dart';
import 'bussiness_logic/database/remoteDatabase/DioHelper.dart';
import 'core/bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  CashHelper.init();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginCubit(),
            ),
            BlocProvider(
              create: (context) => HomeCubit(),
            ),
            BlocProvider(
              create: (context) => DepartmentCubit(),
            ),
            BlocProvider(
              create: (context) => UserCubit(),
            ),
            BlocProvider(
              create: (context) => AddtaskCubit()..getEmployees(),
            ),
            BlocProvider(
              create: (context) => TaskCubit(),
            ),

          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
           // home: SingleTaskScreen(),
           onGenerateRoute: onGenerateRouter,
          ),
        );
      },

    );
  }
}

