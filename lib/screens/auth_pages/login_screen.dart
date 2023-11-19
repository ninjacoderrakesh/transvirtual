import 'dart:ui';

import '../../constants/constant_methods.dart';
import '../../constants/constants.dart';
import '../../constants/screens.dart';
import '../../data/di/di.dart';
import '../../styles/colors.dart';
import '../../widgets/auth_form_field.dart';
import '../../widgets/default_loading_indicator.dart';
import '../../widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/cubit/auth_cubit/auth_cubit.dart';
import '../../widgets/default_material_button.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AuthCubit authCubit;
  @override
  void initState() {
    authCubit = sl<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authCubit,
      child: Builder(builder: (context) {
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(
                'assets/image/img.png',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.h),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/image/football.png",
                              height: 10.h,
                              width: 10.w,
                              color: Colors.white,
                            ),
                            DefaultText(
                              text: 'TransVirtual',
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        AuthFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          validator: (value) => emailController.text.isEmpty
                              ? "UserName can't be empty"
                              : null,
                          controller: emailController,
                          keyboardType: TextInputType.text,
                          hintText: '',
                          upHintText: 'UserName',
                          suffixIcon: Icon(Icons.mail_outline,
                              color: Colors.white, size: 20.sp),
                        ),
                        AuthFormField(
                          validator: (value) {
                            if (passwordController.text.isEmpty) {
                              return "Password can't be empty";
                            } else if (passwordController.text.length < 6) {
                              return 'Your password must be longer than 6 characters';
                            }
                            return null;
                          },
                          obscureText: true,
                          maxLines: 1,
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          hintText: '',
                          upHintText: 'Password',
                          suffixIcon: Icon(Icons.lock,
                              color: Colors.white, size: 20.sp),
                        ),
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is LoginSuccessState) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, homeRoute, (route) => false);
                            } else if (state is LoginFailureState) {
                              showToastMsg(
                                msg: state.errorMessage,
                                toastState: ToastStates.error,
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is LoginLoadingState) {
                              return const DefaultLoadingIndicator();
                            } else {
                              return DefaultMaterialButton(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    authCubit.login(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                background: Colors.orange,
                                text: 'Login',
                                fontSize: 15.sp,
                                height: 10.h,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
