import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_app/presentation/screens/user_page/users.dart';
import 'package:tasks_app/presentation/styles.dart';

import '../../../bussiness_logic/database/local_database/cache_helper.dart';
import '../../../bussiness_logic/home/home_cubit.dart';
import '../../../core/enums.dart';
import '../../router/app_route.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late HomeCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = HomeCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is UserLogoutSuccessState) {
            CashHelper.removeCacheKey(key: MySharedKeys.token).then((value) {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoute.loginScreen, (route) => false);
            });
          }
          // TODO: implement listener
        },
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor2,
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
                ListTile(
                  title: const Text('Add User'),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.createUserScreen);
                    //Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Update User'),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.updateUserScreen);

                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Add Department'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRoute.createDepartmentScreen);

                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Update Department'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRoute.updateDepartmentScreen);

                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('user Tasks'),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.userTasksScreen);

                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Create Task'),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.createTaskScreen);
                    //Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today",
                  style: GoogleFonts.roboto(
                    color: AppTheme.primaryColor,
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '11/9/2023',
                  style: GoogleFonts.roboto(
                    color: AppTheme.greyColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  icon: const Icon(Icons.notes_outlined),
                );
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: ShapeDecoration(
                      color: AppTheme.primaryColor2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
                  ),
                ),
              )
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  //labelPadding: EdgeInsets.symmetric(horizontal: 20.0),

                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.person_2_outlined,
                            color: AppTheme.primaryColor2,
                          ),
                          SizedBox(width: 8),
                          Text('USERS'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.view_week_outlined,
                            color: AppTheme.primaryColor,
                          ),
                          SizedBox(width: 8),
                          Text('TASKS'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: TabBarView(
              children: [
                UsersScreen(),
                Center(
                  child: Text("Tasks"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
