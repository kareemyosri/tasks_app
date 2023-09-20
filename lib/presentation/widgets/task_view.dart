import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_app/model/get_employeeModel.dart';
import 'package:tasks_app/presentation/router/app_route.dart';
import 'package:tasks_app/presentation/styles.dart';

import '../../core/enums.dart';
import '../screens/single_task.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key? key,  required this.taskData}) : super(key: key);
  final TaskData taskData;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, AppRoute.singleTaskScreen,arguments:SingleTaskScreen(taskData: taskData,) );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 11),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskData.status??"",
            style: GoogleFonts.roboto(
              color: ColorState() ,
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w400,
            ),
            ),
            const Divider(color: AppTheme.greyColor,height: 1.3,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: 3,
                   height: 70,
                    decoration:  BoxDecoration(color: ColorState()),
                  ),
                ),
                const SizedBox(width: 20,),
                SizedBox(
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(taskData.name??"",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.roboto(
                              color: AppTheme.primaryColor,
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            ),
                          ),
                          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
                        ],
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        //fit: BoxFit.contain,
                        child: Container(
                          width: 150,
                          child: Text(taskData.description??"",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            color: AppTheme.greyColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 2.h,),
            Row(
              children: [
                const Icon(Icons.watch_later_outlined,color: AppTheme.greyColor,),
                SizedBox(width: 1.w,),
                Text(
                  'starts ${taskData.startDate} - ends ${taskData.endDate}',
                  style: GoogleFonts.roboto(
                    color: AppTheme.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,

                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
  Color ColorState(){
    if(taskData.status=='new'){
      return AppTheme.primaryColor;
    }
    else if(taskData.status=='processing'){
      return const Color(0xFFFAA75B);
    }
    else if(taskData.status=='notcompleted'){
      return const Color(0xFF649FBA);
    }
    else if(taskData.status=='expired'){
      return const Color(0xFFF87B7B);
    }
    else if(taskData.status=='cancelled'){
      return Colors.grey;
    }
    else{
      return Color(0xFF94C58D);
    }

  }
}
