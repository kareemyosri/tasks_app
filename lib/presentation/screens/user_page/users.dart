import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_app/bussiness_logic/home/home_cubit.dart';

import '../../../bussiness_logic/database/local_database/cache_helper.dart';
import '../../../core/enums.dart';
import '../../../model/get_departments_employessModel.dart';
import '../../styles.dart';
import '../../widgets/employee_info.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late HomeCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = HomeCubit.get(context);

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 2.h,),
        Visibility(
          visible: CashHelper.getString(key: MySharedKeys.userType)=='manager',
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 5.h/8.w,
                crossAxisCount: 2,
                crossAxisSpacing: 1.4.w,
                mainAxisSpacing: 2.h,
              ),
              itemCount: cubit.departmentEmployeesData.length,
              itemBuilder: (BuildContext ctx, index) {
                return  Column(
                  children: [
                    EmployeeInfo(employees: cubit.departmentEmployeesData[index],

                    ),
                  ],
                );
              }
          ),
        ),
        Visibility(
          visible: CashHelper.getString(key: MySharedKeys.userType)=='admin',
          child: Expanded(
            child: ListView.separated(
              shrinkWrap: true,
                itemBuilder: (context,index){
                  return BlocBuilder<HomeCubit,HomeState>(
                    builder: (context, state){
                      return view(() { }, cubit.departmentsAndEmployeesData[index]);
                    },
                  );
                },
                separatorBuilder:(context,index)=> SizedBox(height: 2.h,),
                itemCount: cubit.departmentsAndEmployeesData.length
            ),
          ),
        ),
        SizedBox(height: 2.h,),

      ],
    );
  }


  Widget view(void Function()? onPressed,DepartmentsAndEmployeesData departmentsAndEmployeesData){
    return Column(
      children: [
        departmentLine(departmentsAndEmployeesData.name??"", () { }),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 5.h/8.w,
              crossAxisCount: 2,
              crossAxisSpacing: 1.4.w,
              mainAxisSpacing: 2.h,
            ),
            itemCount: departmentsAndEmployeesData.employees?.length,
            itemBuilder: (BuildContext ctx, index) {
              return  Column(
                children: [
                  EmployeeInfo(employees: departmentsAndEmployeesData.employees![index],

                  ),
                ],
              );
            }
        )

      ],
    );
  }
  Widget departmentLine(String? name,void Function()? onPressed){
    return Row(
      children: [
        Container(
          width: 14.w,
          height: 1,
          decoration: const BoxDecoration(color: AppTheme.greyColor),
        ),
        SizedBox(width: 1.w,),
        Text(name??"",
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
