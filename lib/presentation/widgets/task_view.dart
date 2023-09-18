import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_app/presentation/styles.dart';

import '../../core/enums.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key? key, required this.state}) : super(key: key);
  final TaskState state;
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text('New',
          style: GoogleFonts.roboto(
            color: ColorState() ,
            fontSize: 13.5.sp,
            fontWeight: FontWeight.w400,
          ),
          ),
          const Divider(color: AppTheme.greyColor,height: 1.3,),
          Row(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Create a High-Intensity ',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.roboto(
                          color: AppTheme.primaryColor,
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        ),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
                      ],
                    ),
                    Text('Design a 20-minute HIIT workout routine.',
                    style: GoogleFonts.roboto(
                      color: AppTheme.greyColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
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
                'starts 12/9/2023 - ends 16/9/2023',
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
    );
  }
  Color ColorState(){
    if(state==TaskState.newTask){
      return AppTheme.primaryColor;
    }
    else if(state==TaskState.processing){
      return const Color(0xFFFAA75B);
    }
    else if(state==TaskState.nOTCOMPLETED){
      return const Color(0xFF649FBA);
    }
    else if(state==TaskState.eXPIRED){
      return const Color(0xFFF87B7B);
    }
    else{
      return Color(0xFF94C58D);
    }

  }
}
