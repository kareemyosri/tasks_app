import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_app/bussiness_logic/department/department_cubit.dart';

import '../styles.dart';
import '../widgets/ElvatedButton.dart';
import '../widgets/TextFormField.dart';

class UpdateDepartment extends StatefulWidget {
  const UpdateDepartment({Key? key}) : super(key: key);

  @override
  State<UpdateDepartment> createState() => _UpdateDepartmentState();
}

class _UpdateDepartmentState extends State<UpdateDepartment> {
  late DepartmentCubit cubit;
  TextEditingController nameController=TextEditingController();
  TextEditingController managerController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = DepartmentCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DepartmentCubit, DepartmentState>(
      listener: (context, state) {
        // TODO: implement listener}
        if (state is UpdateDepartmentSuccessfullyState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Department Updated')),
          );


          print(DepartmentCubit.get(context).createDepartmentModel?.message);
        }
        else if (state is UpdateDepartmentErrorState) {
          //navigate
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed To Update')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(' Update Department!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: AppTheme.primaryColor,
                        fontSize: 28.5.sp, //34
                        fontWeight: FontWeight.w400,
                      )),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: Text(
                      'Update  department details and assign a new manager to continue work!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: AppTheme.primaryColor,
                        fontSize: 13.5.sp, //34
                        fontWeight: FontWeight.w400,
                      )),
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextFormField(
                    validator: (value) {

                    },
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextFormField(
                    validator: (value) {

                    },
                    controller: managerController,
                    hintText: 'Assigned Manager',
                    obscureText: false),
                SizedBox(
                  height: 2.h,
                ),
                CustomElevatedButton(() {
                  cubit.updateDepartment(nameController.text,managerController.text);
                }, 'Update'),
                BlocBuilder<DepartmentCubit, DepartmentState>(
                  builder: (context, state) {
                    return Visibility(
                      visible: state is CreateDepartmentLoadingState,
                      child: Column(
                        children: [
                          SizedBox(height: 1.h,),
                          const Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
