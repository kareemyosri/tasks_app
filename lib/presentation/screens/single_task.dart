import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_app/bussiness_logic/task/task_cubit.dart';

import '../styles.dart';
import '../widgets/RadioTile.dart';

class SingleTaskScreen extends StatefulWidget {
  const SingleTaskScreen({Key? key}) : super(key: key);

  @override
  State<SingleTaskScreen> createState() => _SingleTaskScreenState();
}

class _SingleTaskScreenState extends State<SingleTaskScreen> {
  late TaskCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit=TaskCubit.get(context);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
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
              //  cubit.userLogout();

                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Add User'),
              onTap: () {
               // Navigator.pushNamed(context, AppRoute.createUserScreen);
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Update User'),
              onTap: () {
               // Navigator.pushNamed(context, AppRoute.updateUserScreen);


                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Add Department'),
              onTap: () {
              //  Navigator.pushNamed(context, AppRoute.createDepartmentScreen);


                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Update Department'),
              onTap: () {
              //  Navigator.pushNamed(context, AppRoute.updateDepartmentScreen);

                // Navigator.pop(context);
              },
            ),

          ],
        ),

      ),
      appBar: AppBar(

        title:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today",
              style: GoogleFonts.roboto(
                color: AppTheme.primaryColor,
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text('11/9/2023',
              style:GoogleFonts.roboto(
                color: AppTheme.greyColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ) ,
            )
          ],
        ),

        leading: Builder(
          builder: (BuildContext context) {
            return  IconButton(onPressed: () {
              Scaffold.of(context).openDrawer();
            },
              //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              icon: const Icon(Icons.notes_outlined),);
          },

        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularPercentIndicator(
                  radius: 20,
                  lineWidth: 6.0,
                  percent: 0.5,
                  center:  Text(
                    '9/20',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      color: AppTheme.primaryColor,
                      fontSize: 8,
                      fontWeight: FontWeight.w900,

                    ),
                  ),
                  progressColor: const Color(0xFF94C68D),
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                SizedBox(width: 3.w,),
                CircularPercentIndicator(
                  radius: 20,
                  lineWidth: 6.0,
                  percent: 5/20,
                  center:  Text(
                    '5/20',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      color: AppTheme.primaryColor,
                      fontSize: 8,
                      fontWeight: FontWeight.w900,

                    ),
                  ),
                  progressColor: const Color(0xFFFBA85B),
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                SizedBox(width: 3.w,),

                CircularPercentIndicator(
                  radius: 20,
                  lineWidth: 6.0,
                  percent: 6/20,
                  center:  Text(
                    '6/20',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      color: AppTheme.primaryColor,
                      fontSize: 8,
                      fontWeight: FontWeight.w900,

                    ),
                  ),
                  progressColor: const Color(0xFFF87B7B),
                  circularStrokeCap: CircularStrokeCap.round,
                ),

              ],
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(

                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Create a High-Intensity Interval Training (HIIT) Workout Routine\n',
                      style: GoogleFonts.roboto(

                        color: AppTheme.primaryColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,

                      ),
                    ),
                    TextSpan(
                      text: 'tap to edit',
                      style: GoogleFonts.roboto(
                        color: AppTheme.greyColor,
                        fontSize: 7.sp,
                        fontWeight: FontWeight.w700,

                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 20.h,
                decoration: const BoxDecoration(color: Color(0xFF7B808A)),
                child: Center(
                  child: Text('IMAGE',
                  style: GoogleFonts.roboto(
                    color: AppTheme.primaryColor,
                    fontSize: 64,
                    fontWeight: FontWeight.w400,
                  ),
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Assigned by',
                        style: GoogleFonts.roboto(
                          color: AppTheme.greyColor,
                          fontSize: 13.5.sp,

                          fontWeight: FontWeight.w400,

                        ),
                      ),
                      Text(
                        'Creator name',
                        style: GoogleFonts.roboto(
                          color: AppTheme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,

                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Due date',
                            style: GoogleFonts.roboto(
                              color: AppTheme.greyColor,
                              fontSize: 13.5.sp,

                              fontWeight: FontWeight.w400,

                            ),
                          ),
                          SizedBox(width: 1.w,),
                          GestureDetector(
                              onTap: (){},
                              child: const Icon(Icons.edit_outlined,color: AppTheme.greyColor)),

                        ],
                      ),
                      Text(
                        '16 September',
                        style: GoogleFonts.roboto(
                          color: AppTheme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,

                        ),
                      ),
                    ],
                  ),

                ],
              ),
              SizedBox(height: 2.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RadioTile(
                    userType: "NEW",
                    value: 0,
                    groupValue: cubit.buttonValue,
                    onChanged: (value) {
                      cubit.changeTaskStatus(value);
                    },
                  ),
                  RadioTile(
                    userType: "PROCESSING",
                    value: 1,
                    groupValue: cubit.buttonValue,
                    onChanged: (value) {
                      cubit.changeTaskStatus(value);
                    },
                  ),
                  RadioTile(
                    userType: "COMPLETED ",
                    value: 2,
                    groupValue: cubit.buttonValue,
                    onChanged: (value) {
                      cubit.changeTaskStatus(value);
                    },
                  ),

                ],
              ),
              SizedBox(height: 0.5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RadioTile(
                    userType: "NOTCOMPLETED  ",
                    value: 3,
                    groupValue: cubit.buttonValue,
                    onChanged: (value) {
                      cubit.changeTaskStatus(value);
                    },
                  ),
                  RadioTile(
                    userType: "CANCELED  ",
                    value: 4,
                    groupValue: cubit.buttonValue,
                    onChanged: (value) {
                      cubit.changeTaskStatus(value);
                    },
                  ),
                  RadioTile(
                    userType: "EXPIRED  ",
                    value: 5,
                    groupValue: cubit.buttonValue,
                    onChanged: (value) {
                      cubit.changeTaskStatus(value);
                    },
                  ),
                ],
              ),
              SizedBox(height: 2.h,),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Description ',
                      style: GoogleFonts.roboto(
                        color: AppTheme.primaryColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,

                      ),
                    ),
                    TextSpan(
                      text: 'tap to edit',
                      style: GoogleFonts.roboto(
                        color: AppTheme.greyColor,
                        fontSize: 7.sp,
                        fontWeight: FontWeight.w400,

                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              Text(
                'Design a 20-minute HIIT workout routine that includes a warm-up, alternating periods of intense exercise and rest, and a cool-down. Specify the exercises, durations, and intensity levels for each interval.',
                style: GoogleFonts.roboto(
                  color: AppTheme.greyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,

                ),
              )

            ],
          ),
        ),
      ),
    );
  },
);
  }
}
