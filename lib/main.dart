// ignore_for_file: non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gemini_app/Logic/bloc_observer.dart';
import 'package:gemini_app/Screens/intro/intro_screen.dart';
import 'package:gemini_app/Shared/Constants/dimenstions.dart';
import 'package:gemini_app/Shared/Core/app_routes.dart';
import 'package:gemini_app/Shared/Core/firebase_options.dart';
import 'package:gemini_app/Shared/Design/themes.dart';
import 'package:gemini_app/Shared/Helpers/shared_preferences.dart';

import 'Screens/Authentication/login_screen.dart';
import 'Screens/Home/home_screen.dart';
var apiKey = "AIzaSyDKZE2QyuFNQY2-Lqsxi_EZUy3n_LxWdFU";

void main() async {
  Gemini.init(apiKey: apiKey);

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.inti();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Getting Screen Dimensions
    var size = MediaQuery.of(context).size;
    screen_height = size.height;
    screen_width = size.width;
    return ScreenUtilInit(
    designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: lightTheme,
    home: AppRoutes.introScreen),

    );

  }
}
