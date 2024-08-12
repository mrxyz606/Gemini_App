// ignore_for_file: prefer_const_constructors

import 'dart:ffi';
import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gemini_app/Logic/Profile%20Cubit/profile_cubit.dart';
import 'package:gemini_app/Shared/Constants/dimenstions.dart';
import 'package:gemini_app/Shared/Core/app_navigator.dart';
import 'package:gemini_app/Shared/Core/app_routes.dart';
import 'package:gemini_app/Shared/Core/assets_paths.dart';
import 'package:gemini_app/Shared/Widgets/progress_indicator.dart';
import 'package:gemini_app/Shared/Widgets/seperator.dart';
import 'package:gemini_app/Shared/Widgets/snack_message.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUser(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is SuccessChangeNameState) {
            snackMessage(context: context, text: "Name Changed Successfully");
          } else if (state is SuccessChangePictureState) {
            snackMessage(context: context, text: "Picture Changed Successfully");
          } else if (state is FailedChangeNameState) {
            snackMessage(context: context, text: "Failed");
          } else if (state is FailedChangePictureState) {
            snackMessage(context: context, text: "Failed");
          } else if (state is LogoutState) {
            snackMessage(context: context, text: "Logged Out Successfully");
            AppNavigator.pushAndRemoveUntil(AppRoutes.loginScreen, context);
          }
        },
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          var user = cubit.user;
          var outlineInputBorder = OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Colors.green[900]!, width: 2));
          return Scaffold(
            body: ConditionalBuilder(
              condition: cubit.user!=null,
              fallback: (context) => AppProgressIndicator(Colors.green[900]!),
              builder: (context) => SafeArea(
                child: Padding(
                  padding: Pads.medium_Padding,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is LoadingChangePictureState)
                          LinearProgressIndicator(color: Colors.green[900],),    
                        if (state is LoadingChangePictureState)
                          Gaps.small_Gap,
                          Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                AssetsPaths.backgroundImage,
                                fit: BoxFit.cover,
                                height: (screen_height / 3).h,
                                width: screen_width,
                              ),
                              BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: const SizedBox()),
                              CircleAvatar(
                                radius: 86.r,
                                backgroundColor: Colors.white,
                              ),
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 80.r,
                                    backgroundImage: NetworkImage(
                                        user!.profilePicture),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.lightGreen[300],
                                    child: IconButton(
                                      onPressed: () {
                                        if (state is LoadingChangeNameState) return;
                                        cubit.changePicture();
                                      },
                                      icon: Icon(
                                        Icons.camera_enhance,
                                        color: Colors.green[900],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Gaps.medium_Gap,
                        TextFormField(
                          cursorColor: Colors.green[300],
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a name";
                            }
                            return null;
                          },
                          style: GoogleFonts.aBeeZee(
                            color: Colors.black,
                            fontSize: 26.sp,
                          ),
                          controller: cubit.nameController..text=user.name,
                          maxLines: 2,
                          minLines: 1,
                          enabled: cubit.editEnabled,
                          decoration: InputDecoration(
                              contentPadding: Pads.medium_Padding,
                              border: outlineInputBorder,
                              enabledBorder: outlineInputBorder,
                              focusedBorder:outlineInputBorder,
                              disabledBorder: InputBorder.none),
                        ),
                        Gaps.small_Gap,
                        if (state is LoadingChangeNameState)
                          LinearProgressIndicator(color: Colors.green[900],),    
                        Gaps.small_Gap,
                        Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                onPressed: () {
                                  if (state is LoadingChangePictureState) return;
                                  if (state is LoadingChangeNameState) return;
                                  cubit.logout();
                                },
                                color: Colors.green[900],
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                padding: Pads.small_Padding,
                                child: Text(
                                  "LOGOUT",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.sp),
                                ),
                              ),
                            ),
                            Gaps.small_Gap,
                            Expanded(
                              child: MaterialButton(
                                onPressed: () {
                                  if (state is LoadingChangePictureState) return;
                                  if (state is LoadingChangeNameState) return;
                                    if (cubit.editEnabled) {
                                      cubit.changeName();
                                    } else {
                                      cubit.changeEditMode();
                                    }
                                },
                                color: Colors.green[900],
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                padding: Pads.small_Padding,
                                child: Text(
                                  cubit.editEnabled ? "SAVE" : "EDIT NAME",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gaps.large_Gap,
                        Padding(
                          padding: Pads.h_medium_Padding,
                          child: TextButton(
                            onPressed: (){
                              AppNavigator.push(AppRoutes.historyScreen, context);

                            },
                            child: Text("History",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 23.sp,
                                )),
                          ),
                        ),


                        hSeperator(),                        Gaps.large_Gap,

                        Center(
                          child: MaterialButton(minWidth: 200,
                            onPressed: () {
                              AppNavigator.push(AppRoutes.homeScreen, context);

                            },
                            color: Colors.green[900],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            padding: Pads.small_Padding,
                            child: Text(
                              "HOME",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
