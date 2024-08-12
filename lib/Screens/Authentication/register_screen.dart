import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gemini_app/Logic/Register%20Cubit/register_cubit.dart';
import 'package:gemini_app/Shared/Constants/dimenstions.dart';
import 'package:gemini_app/Shared/Core/app_navigator.dart';
import 'package:gemini_app/Shared/Core/app_routes.dart';
import 'package:gemini_app/Shared/Core/assets_paths.dart';
import 'package:gemini_app/Shared/Widgets/auth_text_form_field.dart';
import 'package:gemini_app/Shared/Widgets/progress_indicator.dart';
import 'package:gemini_app/Shared/Widgets/snack_message.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is FailedRegisterState) {
                  if (state.error == "invalid-email") {
                    snackMessage(context: context, text: "Invalid Email");
                  } else if (state.error == "weak-password") {
                    snackMessage(context: context, text: "Weak Password");
                  } else if (state.error == "email-already-in-use") {
                    snackMessage(context: context, text: "This Email Exists");
                  }
                } else if (state is FailedCreateUserState) {
                  snackMessage(context: context, text: state.error);
                } else if (state is SuccessCreateUserState) {
                  AppNavigator.pushAndRemoveUntil(AppRoutes.homeScreen, context);
                }
        },
        builder: (context, state) {
          List<bool> conditions =[
            state is LoadingCreateUserState,
            state is LoadingRegisterState
          ];
          var cubit = RegisterCubit.get(context);
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
                    condition: conditions.contains(true),
                    builder: (context) => AppProgressIndicator(Colors.white.withOpacity(0.85)),
                    fallback: (context) => SingleChildScrollView(
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
                                    "REGISTER",
                                    style: GoogleFonts.aBeeZee(
                                        color: Colors.white.withOpacity(0.85),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 45.sp),
                                  ),
                                  Gaps.tiny_Gap,
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Create a new account to access all of our services",
                                    style: GoogleFonts.aBeeZee(
                                      color: Colors.white.withOpacity(0.85),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Gaps.huge_Gap,
                                  AuthTextFormField(
                                      controller: cubit.nameController,
                                      hintText: "Name",
                                      validatorText: "Please enter your name"),
                                  Gaps.medium_Gap,
                                  AuthTextFormField(
                                      controller: cubit.emailController,
                                      hintText: "E-mail",
                                      type: TextInputType.emailAddress,
                                      validatorText: "Please enter your e-mail"),
                                  Gaps.medium_Gap,
                                  // note
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
                                        cubit.createUser();
                                      }
                                    },
                                    minWidth: screen_width,
                                    height: 45.h,
                                    color: Colors.green[400],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16)),
                                    child: Text(
                                      "REGISTER",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
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
