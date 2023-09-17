import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_app/presentation/styles.dart';
import 'package:tasks_app/presentation/widgets/ElvatedButton.dart';
import 'package:tasks_app/presentation/widgets/TextFormField.dart';

import '../../bussiness_logic/department/department_cubit.dart';

class CreateDepartment extends StatefulWidget {
  const CreateDepartment({Key? key}) : super(key: key);

  @override
  State<CreateDepartment> createState() => _CreateDepartmentState();
}

class _CreateDepartmentState extends State<CreateDepartment> {


  late DepartmentCubit cubit;
  TextEditingController nameController = TextEditingController();

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
        if (state is CreateDepartmentSuccessfullyState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Department Created')),
            );


          print(DepartmentCubit.get(context).createDepartmentModel?.message);
        }
        else if (state is CreateDepartmentErrorState) {
          //navigate
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed To Create')),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(' New Department!',
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
                    'Create a new department now and assign a manager to start the work!',
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
                validator: (value){

                },
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false),
              SizedBox(
                height: 2.h,
              ),
              CustomElevatedButton(() {
                cubit.createDepartment(nameController.text);
              }, 'CREATE'),
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
    );
  }
}
