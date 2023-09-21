import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_app/bussiness_logic/database/user/user_cubit.dart';
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
    return BlocListener<HomeCubit, HomeState>(
  listener: (context, state) {
    // TODO: implement listener}
    if(state is DeleteDepartmentSuccessfullyState){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Department Deleted Successfully...')),
      );
    }
    if(state is DeleteDepartmentErrorState){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to Delete Department...')),
      );
    }
  },
  child: Column(
      children: [
        SizedBox(
          height: 2.h,
        ),
        Text('OnLongPress User Will Deleted',
        style: GoogleFonts.roboto(
          color: Colors.red
        ),
        ),
        Visibility(
          visible:
              CashHelper.getString(key: MySharedKeys.userType) == 'manager',
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 5.h / 8.w,
                crossAxisCount: 2,
                crossAxisSpacing: 1.4.w,
                mainAxisSpacing: 2.h,
              ),
              itemCount: cubit.departmentEmployeesData.length,
              itemBuilder: (BuildContext ctx, index) {
                return BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (cubit.departmentEmployeesData.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      children: [
                        EmployeeInfo(
                          employees: cubit.departmentEmployeesData[index],
                          onLongPress: (){
                            UserCubit.get(context).deleteUser(cubit.departmentEmployeesData[index].id!);
                          },
                        ),
                      ],
                    );
                  },
                );
              }),
        ),
        Visibility(
          visible: CashHelper.getString(key: MySharedKeys.userType) == 'admin',
          child: Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (cubit.departmentsAndEmployeesData.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return view(
                          () {}, cubit.departmentsAndEmployeesData[index]);
                    },
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 2.h,
                    ),
                itemCount: cubit.departmentsAndEmployeesData.length),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    ),
);
  }

  Widget view(void Function()? onPressed,
      DepartmentsAndEmployeesData departmentsAndEmployeesData) {
    return Column(
      children: [
        departmentLine(departmentsAndEmployeesData.name ?? "", () {
          cubit.deleteDepartment(departmentsAndEmployeesData.id!);
        }),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 5.h / 8.w,
              crossAxisCount: 2,
              crossAxisSpacing: 1.4.w,
              mainAxisSpacing: 2.h,
            ),
            itemCount: departmentsAndEmployeesData.employees?.length,
            itemBuilder: (BuildContext ctx, index) {
              return Column(
                children: [
                  BlocListener<UserCubit, UserState>(
  listener: (context, state) {
    // TODO: implement listener}
    if(state is DeleteUserSuccessfullyState){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('user Deleted Successfully...')),
      );
    }
    if(state is DeleteUserErrorState){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to Deleted...')),
      );
    }
  },
  child: EmployeeInfo(
                    employees: departmentsAndEmployeesData.employees![index],
                    onLongPress:(){UserCubit.get(context).deleteUser(departmentsAndEmployeesData.employees![index].id!);},



                  ),
),
                ],
              );
            })
      ],
    );
  }

  Widget departmentLine(String? name, void Function()? onPressed) {
    return Row(
      children: [
        Container(
          width: 14.w,
          height: 1,
          decoration: const BoxDecoration(color: AppTheme.greyColor),
        ),
        SizedBox(
          width: 1.w,
        ),
        Text(
          name ?? "",
          style: GoogleFonts.roboto(
            color: AppTheme.greyColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.delete_outline,
              color: AppTheme.greyColor,
            ))
      ],
    );
  }
}
