import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_app/bussiness_logic/login/login_cubit.dart';
import 'package:tasks_app/presentation/screens/home_screen.dart';
import 'package:tasks_app/presentation/widgets/ElvatedButton.dart';
import 'package:tasks_app/presentation/widgets/TextFormField.dart';

import '../../bussiness_logic/database/local_database/cache_helper.dart';
import '../../core/enums.dart';
import '../router/app_route.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(text: CashHelper.getString(key: MySharedKeys.email));
  TextEditingController passwordController = TextEditingController(text: CashHelper.getString(key: MySharedKeys.password));
  late LoginCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = LoginCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if(state is LoginSuccessState){
            CashHelper.putString(
                key: MySharedKeys.token, value: LoginCubit.get(context).loginModel?.data?.token)
                .then((value) {
              print(LoginCubit.get(context).loginModel?.data?.token);
              Navigator.pushNamedAndRemoveUntil(context, AppRoute.userPageScreen, (route) => false);

            });
          }
          // TODO: implement listener
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text('Welcome Back!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: const Color(0xFF091E4A),
                        fontSize: 28.5.sp, //34
                        fontWeight: FontWeight.w400,
                      )),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: Text(
                      'Login to access your assigned tasks and personal overview.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: const Color(0xFF7B808A),
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextFormField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextFormField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: cubit.isChecked,
                            activeColor: const Color(0xFF5A55CA),
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            side: const BorderSide(
                              color: Color(0xFF091E4A),
                            ),
                            onChanged: (newValue) {
                              cubit.changeCheckBox(newValue);
                            });
                      },
                    ),
                    Text('Keep me logged in',
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF091E4A),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomElevatedButton(() {
                  cubit.userLogin(email: emailController.text, password: passwordController.text);
                  CashHelper.putString(key: MySharedKeys.email, value: emailController.text);
                  CashHelper.putString(key: MySharedKeys.password, value: passwordController.text);
                }, 'LOGIN'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
