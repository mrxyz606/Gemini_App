// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gemini_app/Logic/Login%20Cubit/login_cubit.dart';
import 'package:gemini_app/Shared/Constants/dimenstions.dart';
import 'package:gemini_app/Shared/Core/app_navigator.dart';
import 'package:gemini_app/Shared/Core/app_routes.dart';
import 'package:gemini_app/Shared/Core/assets_paths.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:gemini_app/Shared/Widgets/auth_text_form_field.dart';
import 'package:gemini_app/Shared/Widgets/progress_indicator.dart';
import 'package:gemini_app/Shared/Widgets/snack_message.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is FailedLoginState) {
            if (state.error == 'user-not-found' ||
                state.error == 'invalid-credential') {
              snackMessage(
                  context: context, text: "No user found for that email.");
            } else if (state.error == 'wrong-password') {
              snackMessage(context: context, text: "Wrong Password");
            } else if (state.error == 'invalid-email') {
              snackMessage(context: context, text: "Invalid E-mail");
            }
          } else if (state is SuccessLoginState) {
            AppNavigator.pushAndRemoveUntil(AppRoutes.homeScreen, context);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  AssetsPaths.backgroundImage,
                  height: screen_height,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.none,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: ConditionalBuilder(
                    condition: state is! LoadingLoginState,
                    fallback: (context) => AppProgressIndicator(Colors.white.withOpacity(0.85)),
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        width: screen_width,
                        height: screen_height,
                        padding: Pads.medium_Padding,
                        child: Center(
                          child: SafeArea(
                            child: Form(
                              key: key,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "WELCOME",
                                    style: GoogleFonts.aBeeZee(
                                        color: Colors.white.withOpacity(0.85),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 45.sp),
                                  ),
                                  Gaps.tiny_Gap,
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Nature is not a place to visit, it is home",
                                    style: GoogleFonts.aBeeZee(
                                      color: Colors.white.withOpacity(0.85),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Gaps.huge_Gap,
                                  AuthTextFormField(
                                      controller: cubit.emailController,
                                      hintText: "E-mail",
                                      type: TextInputType.emailAddress,
                                      validatorText: "Please enter your e-mail"),
                                  Gaps.medium_Gap,
                                  AuthTextFormField(
                                      controller: cubit.passwordController,
                                      hintText: "Password",
                                      type: TextInputType.visiblePassword,
                                      validatorText: "Please enter your password",
                                      obscured: cubit.obscured,
                                      suffixEnabled: true,
                                      suffixFunction: () {
                                        cubit.changeObscurity();
                                      },
                                      suffixIcon: Icons.remove_red_eye),
                                  Gaps.medium_Gap,
                                  MaterialButton(
                                    onPressed: () {
                                      if (key.currentState!.validate()) {
                                        cubit.login();
                                      }
                                    },
                                    minWidth: screen_width,
                                    height: 45.h,
                                    color: Colors.green[400],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16)),
                                    child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Gaps.medium_Gap,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        style: const ButtonStyle(
                                            splashFactory:
                                                NoSplash.splashFactory),
                                        child: Text(
                                          "Password",
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.85)),
                                        ),
                                      ),
                                      Gaps.small_Gap,
                                      Container(
                                        width: 2,
                                        height: 40,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      Gaps.small_Gap,
                                      TextButton(
                                        onPressed: () {
                                          AppNavigator.push(AppRoutes.registerScreen, context);


                                        },
                                        style: const ButtonStyle(
                                            splashFactory:
                                                NoSplash.splashFactory),
                                        child: Text(
                                          "Register",
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.85)),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
