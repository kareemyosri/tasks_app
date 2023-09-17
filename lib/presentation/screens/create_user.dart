import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_app/bussiness_logic/database/user/user_cubit.dart';
import 'package:tasks_app/presentation/widgets/RadioTile.dart';

import '../styles.dart';
import '../widgets/ElvatedButton.dart';
import '../widgets/TextFormField.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late UserCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = UserCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        // TODO: implement listener}
        if(state is CreateUserSuccessfullyState){
          print("user Created");
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('user Created with id ${cubit.createUserModel?.data?.id}')),
          );
        }
        else if(state is CreateUserErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed  ')),
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
                  child: Text('Add New User!',
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
                      'Create a new user now and assign them tasks right away.',
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

                SizedBox(
                  height: 2.h,
                ),
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RadioTile(
                          userType: "Admin",
                          value: 0,
                          groupValue: cubit.buttonValue,
                          onChanged: (value) {
                            cubit.changeUserValue(value);
                          },
                        ),
                        RadioTile(
                          userType: "Manager",
                          value: 1,
                          groupValue: cubit.buttonValue,
                          onChanged: (value) {
                            cubit.changeUserValue(value);
                          },
                        ),
                        RadioTile(
                          userType: "User",
                          value: 2,
                          groupValue: cubit.buttonValue,
                          onChanged: (value) {
                            cubit.changeUserValue(value);
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomElevatedButton(() {
                  cubit.createUser(name: nameController.text, email: emailController.text,
                      phone: phoneController.text, password: passwordController.text,
                     );
                }, "CREATE"),
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
