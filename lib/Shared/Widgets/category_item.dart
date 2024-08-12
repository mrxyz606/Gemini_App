import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gemini_app/Shared/Core/assets_paths.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/dimenstions.dart';

class CategoryItem extends StatelessWidget {

String Title;
String data;
CategoryItem( {required this.Title,required this.data});
  @override
  Widget build(BuildContext context) {
    return TextButton(

    onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen(data: data),));

    },
      child: Stack(
        children: [Image.asset(
          AssetsPaths.bookImage,height: 280,fit: BoxFit.cover,),
          Container(
            margin: EdgeInsets.all(6),
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.45),

            child: Padding(

              padding: const EdgeInsets.all(7),

              child: Text(Title,style: GoogleFonts.aBeeZee(
              color: Colors.white.withOpacity(0.85),
              fontWeight: FontWeight.w600,
              fontSize: 19,
                      ),),
            ),)
        ],
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  CategoryScreen({required this.data});
  @override
  String data;
  Widget build(BuildContext context) {
    return Scaffold(
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
            child:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 38.0, left: 8.0),
                child: Text(data,style: GoogleFonts.aBeeZee(
                  color: Colors.white.withOpacity(0.85),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

