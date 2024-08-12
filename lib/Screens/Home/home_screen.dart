
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gemini_app/Screens/Home/results.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Logic/Profile Cubit/profile_cubit.dart';
import '../../Shared/Constants/dimenstions.dart';
import '../../Shared/Core/app_navigator.dart';
import '../../Shared/Core/app_routes.dart';
import '../../Shared/Core/assets_paths.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../../Shared/Widgets/progress_indicator.dart';
import '../../Shared/Widgets/snack_message.dart';
import '../../Shared/data/questions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum TtsState { playing, stopped}

class _HomeScreenState extends State<HomeScreen> {
  @override

  TtsState ttsState = TtsState.stopped;
  bool get isPlaying => ttsState == TtsState.playing;
  bool get isStopped => ttsState == TtsState.stopped;


  int currentQuestionIndex = 0;

  Future<void> uploadresulrs(results){
    var users= FirebaseFirestore.instance.collection('users').doc();
    print(users);
    print("///////////////////");

    return users.update({

      'results':results,
    }).then((value) => print('user added')).catchError((e)=>print('error happened${e}'));
  }



  void answerQuestion() {
    if (currentQuestionIndex < questions.length ) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  //FlutterTts _flutterTts = FlutterTts();
  // void initState() {
  //   super.initState();
  //   TTS();
  // }
  // List<Map> voices = [];
//
//   void TTS() {
//     _flutterTts.setStartHandler(() {
//       setState(() {
//         print("Playing");
//         ttsState = TtsState.playing;
// //########add image ###########
//
//       });
//     });
//
//     _flutterTts.setCompletionHandler(() {
//       setState(() {
//         print("Complete");
//         ttsState = TtsState.stopped;
// //########add image ###########
//       });
//     });
//     _flutterTts.getVoices.then((values) {
//       try {
//         voices = List<Map>.from(values);
//         _flutterTts.setVoice({"name": "en-in-x-end-network", "locale": "en-IN"});
//         setState(() {
//           voices = voices.where((voice) => voice["name"].contains("en")).toList();
//           print(voices);
//
//           //_currentVoice = voices.last;
//           //setVoice({"name": "en-gb-x-gba-network", "locale": "en-GB"});
//         });
//       } catch (e) {
//         print(e);
//       }
//     });
//   }
//
//   void setVoice(Map voice) {
//     _flutterTts.setVoice({"name": voice["name"], "locale": voice["locale"]});
//   }


  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUser(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          var user = cubit.user;
          var outlineInputBorder = OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: Colors.green[900]!, width: 2));
          return  Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  AssetsPaths.backgroundImage2,
                  height: screen_height,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.none,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Padding(
                  padding: const EdgeInsets.all( 28.0),
                  child: CircleAvatar(
                    child: IconButton(
                        onPressed: () {
                          AppNavigator.push(
                              AppRoutes.profile(), context);
                        },
                        icon: Icon(
                          Icons.person_2,
                          color: Colors.black,
                        )),
                  ),),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 298.0),
                        child: Center(
                          child: currentQuestionIndex < questions.length
                              ? Card(
                            color:Colors.white30 ,
                            elevation: 5,
                            margin: EdgeInsets.all(20),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    questions[currentQuestionIndex],
                                    style: GoogleFonts.aBeeZee(
                                      color: Colors.white.withOpacity(0.85),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24,
                                    ),                        textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            cubit.answers[currentQuestionIndex]="";
                                          });
                                          answerQuestion();
                                        },
                                        child: Text('Yes',  style: GoogleFonts.aBeeZee(
                                          color: Colors.black.withOpacity(0.85),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20,
                                        ),),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          cubit.answers[currentQuestionIndex]="don't";

                                          answerQuestion();
                                        },
                                        child: Text('No',  style: GoogleFonts.aBeeZee(
                                          color: Colors.black.withOpacity(0.85),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20,
                                        ),),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ) : Card(
                            color:Colors.white30 ,
                            elevation: 5,
                            margin: EdgeInsets.all(20),

                            child: Container(
                              width: 400,
                              height: 150,
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Thank you for answering the questions!',
                                      style: GoogleFonts.aBeeZee(
                                        color: Colors.white.withOpacity(0.85),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    IconButton(onPressed: (){



                                      cubit.askgemini( "I ${cubit.answers[0]}regularly recycle plastic, paper, and glass materials and i ${cubit.answers[1]} use reusable bags when you go shopping and i ${cubit.answers[2]} try to conserve water by taking shorter showers or turning off the tap while brushing your teeth and i ${cubit.answers[3]} use energy-efficient appliances in your home and i ${cubit.answers[4]} avoid using single-use plastics, such as straws and cutlery also i ${cubit.answers[5]} prefer walking, biking, or using public transportation over driving a car when possible also i ${cubit.answers[6]} try to buy locally produced food to reduce your carbon footprint. so am i saving the environment?",context);

                                    }, icon: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Color(0xff108f0e),
                                            borderRadius: BorderRadius.all(Radius.circular(30))),
                                        child: Center(child: Icon(Icons.send_rounded,color: Colors.white,))))

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
