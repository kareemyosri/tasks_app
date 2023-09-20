import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_app/bussiness_logic/task/task_cubit.dart';

import '../../core/enums.dart';
import '../router/app_route.dart';
import '../styles.dart';
import '../widgets/task_view.dart';

class UserTasks extends StatefulWidget {
  const UserTasks({Key? key}) : super(key: key);

  @override
  State<UserTasks> createState() => _UserTasksState();
}

class _UserTasksState extends State<UserTasks> {
  late TaskCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit=TaskCubit.get(context);
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCubit,TaskState>(
  listener: (context, state) {
    // if (state is UserLogoutSuccessState) {
    //   CashHelper.removeCacheKey(key: MySharedKeys.token)
    //       .then((value) {
    //     Navigator.pushNamedAndRemoveUntil(
    //         context, AppRoute.loginScreen, (route) => false);
    //   });
    // }

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

                 Navigator.pushNamedAndRemoveUntil(context, AppRoute.loginScreen, (route) => false);
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
            Text(DateTime.now().toString(),
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
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){},
                  child: Container(
                   // width: 36,
                    //height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: AppTheme.primaryColor2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Icon(Icons.filter_alt_outlined,color: Colors.white,),
                  ),
                ),
                SizedBox(width: 1.5.w,),
                Expanded(
                  child: CalendarTimeline(
                    showYears: true,
                    //shrink: true,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100, 11, 20),
                    onDateSelected: (date) => print(date),
                    //leftMargin: 20,
                    monthColor: const Color(0xB2111111).withOpacity(0.7),
                    dayColor: AppTheme.primaryColor,
                    activeDayColor: Colors.white,
                    activeBackgroundDayColor: AppTheme.primaryColor2,
                    //dotsColor: Color(0xFF333A47),
                    selectableDayPredicate: (date) => date.day != 23,
                    locale: 'en_ISO',
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h,),
            BlocBuilder<TaskCubit, TaskState>(
  builder: (context, state) {
    return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index)=>
                  TaskView(taskData: cubit.employeeTasks[index]),
                separatorBuilder: (context,index)=>SizedBox(height: 2.h,),
                itemCount: cubit.employeeTasks.length);
  },
),
            SizedBox(height: 10.h,)
          ],
        ),
      ),
    ),
    ),
);
  }
}
