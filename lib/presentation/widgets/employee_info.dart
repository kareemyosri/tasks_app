import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_app/presentation/styles.dart';

class EmployeeInfo extends StatelessWidget {
  const EmployeeInfo({Key? key, required this.employeeName, required this.userType, required this.userEmail, required this.userPhone}) : super(key: key);
  final String employeeName;
  final String userType;
  final String userEmail;
  final String userPhone;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 8, right: 5, bottom: 10),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.20, color: AppTheme.greyColor),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Row(

          children: [
            VerticalDivider(width: 1.w,color: AppTheme.primaryColor2,),
            SizedBox(width: 1.w,),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(employeeName,
                style: GoogleFonts.roboto(
                  color: AppTheme.primaryColor,
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w700,
                ),

                ),
                SizedBox(height: 0.5.h,),
                Container(
                 // width: 35,
                  //height: 10,
                  decoration: ShapeDecoration(
                    color: AppTheme.primaryColor2.withOpacity(0.1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                  ),
                  child: Text(userType,
                  style: GoogleFonts.roboto(
                    color: AppTheme.primaryColor2,
                    fontSize: 6.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  ),
                ),
                SizedBox(height: 0.5.h,),
                Row(
                  children: [
                    const Icon(Icons.email_outlined,color: AppTheme.greyColor,),
                    Text(userEmail,
                    style: GoogleFonts.roboto(
                      color: AppTheme.greyColor,
                      fontSize: 6.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.local_phone_outlined,color: AppTheme.greyColor,),
                    Text(userPhone,
                      style: GoogleFonts.roboto(
                        color: AppTheme.greyColor,
                        fontSize: 6.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}
