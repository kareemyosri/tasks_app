import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../styles.dart';
import '../../widgets/employee_info.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //SizedBox(height: 1.h,),
          departmentLine('department name', () { }),
          SizedBox(height: 0.5.h,),
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 5.h/8.w,
                crossAxisCount: 2,
                crossAxisSpacing: 1.4.w,
                mainAxisSpacing: 2.h,
              ),
              itemCount: 4,
              itemBuilder: (BuildContext ctx, index) {
                return const EmployeeInfo(employeeName: 'Employee Name',
                  userType: 'ADMIN', userEmail: 'user email',
                  userPhone: 'user phone',

                );
              }
          ),
          SizedBox(height: 2.h,),
          departmentLine('department name', () { }),
          SizedBox(height: 0.5.h,),
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 5.h/8.w,
                crossAxisCount: 2,
                crossAxisSpacing: 1.4.w,
                mainAxisSpacing: 2.h,
              ),
              itemCount: 4,
              itemBuilder: (BuildContext ctx, index) {
                return const EmployeeInfo(employeeName: 'Employee Name',
                  userType: 'ADMIN', userEmail: 'user email',
                  userPhone: 'user phone',

                );
              }
          ),
          SizedBox(height: 2.h,),
          departmentLine('department name', () { }),
          SizedBox(height: 0.5.h,),
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 5.h/8.w,
                crossAxisCount: 2,
                crossAxisSpacing: 1.4.w,
                mainAxisSpacing: 2.h,
              ),
              itemCount: 4,
              itemBuilder: (BuildContext ctx, index) {
                return const EmployeeInfo(employeeName: 'Employee Name',
                  userType: 'ADMIN', userEmail: 'user email',
                  userPhone: 'user phone',

                );
              }
          ),
        ],
      ),
    );
  }
  Widget departmentLine(String name,void Function()? onPressed){
    return Row(
      children: [
        Container(
          width: 14.w,
          height: 1,
          decoration: const BoxDecoration(color: AppTheme.greyColor),
        ),
        SizedBox(width: 1.w,),
        Text(name,
          style: GoogleFonts.roboto(
            color: AppTheme.greyColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        IconButton(onPressed: onPressed, icon: const Icon(Icons.edit_outlined,color: AppTheme.greyColor,))
      ],
    );
  }

}
