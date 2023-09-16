import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/bussiness_logic/home/home_cubit.dart';

import '../../bussiness_logic/database/local_database/cache_helper.dart';
import '../../core/enums.dart';
import '../router/app_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = HomeCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if(state is UserLogoutSuccessState){
          CashHelper.removeCacheKey(key: MySharedKeys.token)
              .then((value) {
            Navigator.pushNamedAndRemoveUntil(context, AppRoute.loginScreen, (route) => false);


          });
        }
        // TODO: implement listener}
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer'),
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  cubit.userLogout();

                  // Navigator.pop(context);
                },
              ),

            ],
          ),

        ),
        appBar: AppBar(),
        body: Text("body"),
      ),
    );
  }
}
