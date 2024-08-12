import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Shared/Constants/dimenstions.dart';
import '../../Shared/Core/app_navigator.dart';
import '../../Shared/Core/app_routes.dart';
import '../../Shared/Core/assets_paths.dart';
class Results extends StatefulWidget {
  Results({super.key,required this.results});
  var results;
  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children:[           Image.asset(
        AssetsPaths.backgroundImage3,
        height: screen_height,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.none,
      ),BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15,),

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration:BoxDecoration(color: Color(0xff108f0e),borderRadius: BorderRadius.all(Radius.circular(35))) ,
                      child: Center(child: Text("envGemini", style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w800),)),
                    ),
                  ),
                  Container(
                    width: double.infinity,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Text(widget.results,style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w500),)),
                        ElevatedButton(
                          onPressed: () {
                            AppNavigator.push(AppRoutes.introScreen, context);

                            print('Learn More of Environment pressed');
                          },
                          child: Text(
                            'Back to Home',
                            style: GoogleFonts.aBeeZee(
                              color: Colors.black.withOpacity(0.85),
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),)


                ],),
              ),
            ),
          ),
      ),]
      ),
    );
  }
}
