import 'package:buildcondition/buildcondition.dart';
import 'package:email_validator/email_validator.dart';
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
  TextEditingController emailController = TextEditingController(
      text: CashHelper.getString(key: MySharedKeys.email));
  TextEditingController passwordController = TextEditingController(
      text: CashHelper.getString(key: MySharedKeys.password));
  late LoginCubit cubit;
  final formLoginKey = GlobalKey<FormState>();

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
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Logged-in Successfully'),
                duration: Duration(seconds: 1),
                showCloseIcon: true,
              ),
            );
            CashHelper.putString(
                    key: MySharedKeys.token,
                    value: LoginCubit.get(context).loginModel?.data?.token)
                .then((value) {
              print(LoginCubit.get(context).loginModel?.data?.token);
              //Navigator.pushNamedAndRemoveUntil(context, AppRoute.userPageScreen, (route) => false);
            });

            CashHelper.putString(
                    key: MySharedKeys.userType,
                    value: LoginCubit.get(context).loginModel?.data?.userType)
                .then((value) {
              if (LoginCubit.get(context).loginModel?.data?.userType ==
                  "employee") {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoute.userTasksScreen, (route) => false);
              } else {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoute.userPageScreen, (route) => false);
              }
            });
          }
          if(state is LoginErrorState){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Something went wrong!')),
            );
          }
          // TODO: implement listener
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Form(
              key: formLoginKey,
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
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email',
                      labelText: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'email must not be empty';
                        }
                        final bool isValid = EmailValidator.validate(value);
                        if (!isValid) {
                          return "please enter right email";
                        }
                        return null;
                      },
                      obscureText: false),
                  SizedBox(
                    height: 2.h,
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
  builder: (context, state) {
    return CustomTextFormField(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        cubit.changePasswordVisibility();
                      },
                      icon: cubit.isPassword
                          ? const Icon(Icons.visibility_off_outlined)
                          : const Icon(Icons.visibility_outlined),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    hintText: 'Password',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      //         RegExp regex = RegExp(
                      //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[!@#\$&*~]).{8,}$');
                      //         if (!regex.hasMatch(value)) {
                      //         return
                      //           ''' password must contain at least one capital letter and
                      // one special character''';
                      //         }
                      return null;
                    },
                    obscureText: cubit.isPassword,
                  );
  },
),
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
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return BuildCondition(
                        condition: state is! LoginLoadingState,
                        builder: (context) => CustomElevatedButton(() {
                         if(formLoginKey.currentState!.validate()){
                           cubit.userLogin(
                               email: emailController.text,
                               password: passwordController.text);
                           CashHelper.putString(
                               key: MySharedKeys.email,
                               value: emailController.text);
                           CashHelper.putString(
                               key: MySharedKeys.password,
                               value: passwordController.text);
                         }
                        }, 'LOGIN'),
                        fallback: (context) => const Center(
                            child: CircularProgressIndicator()),

                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
