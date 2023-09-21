import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_app/bussiness_logic/home/home_cubit.dart';

import '../../bussiness_logic/add_new_task/addtask_cubit.dart';
import '../../bussiness_logic/database/local_database/cache_helper.dart';
import '../../bussiness_logic/database/user/user_cubit.dart';
import '../../core/enums.dart';
import '../styles.dart';
import '../widgets/ElvatedButton.dart';
import '../widgets/RadioTile.dart';
import '../widgets/TextFormField.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController departmentIdController = TextEditingController();
  TextEditingController statusController = TextEditingController();


  late UserCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit=UserCubit.get(context);
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
  listener: (context, state) {
    // TODO: implement listener}
    if(state is UpdateUserSuccessfullyState){
      print('updaaatedddd');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('user Updated')),
      );
    }
    else if(state is UpdateUserErrorState){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to Update...  ')),
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
                child: Text('Update User Details!',
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
                    'Update user details and give them a new identity.',
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
                  validator: (value) {},
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFormField(
                  validator: (value) {},
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFormField(
                  validator: (value) {},
                  controller: phoneController,
                  hintText: 'Phone',
                  obscureText: false),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFormField(
                  validator: (value) {},
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true),
              Visibility(
                visible: CashHelper.getString(key: MySharedKeys.userType)=='admin',
                child: SizedBox(
                  height: 2.h,
                ),
              ),
              Visibility(
                visible:CashHelper.getString(key: MySharedKeys.userType)=='admin' ,
                child: CustomTextFormField(
                    validator: (value) {},
                    controller: departmentIdController,
                    hintText: 'DepartmentID',
                    obscureText: false),
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFormField(
                  validator: (value) {},
                  controller: statusController,
                  hintText: 'User Status',
                  obscureText: false),
              SizedBox(
                height: 2.h,
              ),
              Visibility(
                visible: CashHelper.getString(key: MySharedKeys.userType)=='admin',
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RadioTile(
                          userType: "Admin",
                          value: 0,
                          groupValue: cubit.buttonValueUpdate,
                          onChanged: (value) {
                            cubit.changeUpdateUserValue(value);
                          },
                        ),
                        RadioTile(
                          userType: "Manager",
                          value: 1,
                          groupValue: cubit.buttonValueUpdate,
                          onChanged: (value) {
                            cubit.changeUpdateUserValue(value);
                          },
                        ),
                        RadioTile(
                          userType: "User",
                          value: 2,
                          groupValue: cubit.buttonValueUpdate,
                          onChanged: (value) {
                            cubit.changeUpdateUserValue(value);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Visibility(
                visible: CashHelper.getString(key: MySharedKeys.userType)=='admin',
                child: BlocBuilder<AddtaskCubit, AddtaskState>(
                  builder: (context, state) {
                    return DropdownButtonFormField(
                      items: AddtaskCubit.get(context).employees
                          .map((item) => DropdownMenuItem<String>(
                        value: item.email,
                        child: Text(item.email??""),
                      ))
                          .toList(),
                      onChanged: (String? newValue) {
                        AddtaskCubit.get(context).getIdValue(newValue);
                      },
                    );
                  },
                ),
              ),
              Visibility(
                visible: CashHelper.getString(key: MySharedKeys.userType)=='manager',
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return DropdownButtonFormField(
                      items: HomeCubit.get(context).departmentEmployeesData
                          .map((item) => DropdownMenuItem<String>(
                        value: item.email,
                        child: Text(item.email??""),
                      ))
                          .toList(),
                      onChanged: (String? newValue) {
                        HomeCubit.get(context).getIdValue(newValue);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 2.h,),
              CustomElevatedButton(() {
                cubit.updateUser(name: nameController.text, email: emailController.text,
                    phone: phoneController.text, password: passwordController.text,
                    depId: departmentIdController.text, status:statusController.text,
                );
              }, "UPDATE"),
              SizedBox(
                height: 2.h,
              ),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return Visibility(
                    visible: state is CreateUserLoadingState,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
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
