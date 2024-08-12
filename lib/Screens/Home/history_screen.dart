import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Logic/Profile Cubit/profile_cubit.dart';
import '../../Shared/Constants/dimenstions.dart';
import '../../Shared/Core/assets_paths.dart';


class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body:Stack(children: [
        Image.asset(
        AssetsPaths.backgroundImage,
        height: screen_height,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.none,
      ),Scaffold(backgroundColor: Colors.white.withOpacity(0.0),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.white30.withOpacity(0.0),

            title: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: Center(
                child: Text(
                  ' HISTORY',
                  style: GoogleFonts.aBeeZee(
                    color: Colors.black.withOpacity(0.85),
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),

          body: BackdropFilter(            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: HistoryScreen(),
              )),
        )]),
    );
  }
}


class HistoryScreen extends StatefulWidget {

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getresult(),
      child: BlocConsumer<ProfileCubit,ProfileState>(
        listener: (BuildContext context,ProfileState state){},
        builder:(BuildContext context,ProfileState state){
          var cubit=ProfileCubit.get(context);
          var results=cubit.allResults;

          if(results.length>0){return ListView.separated(

              itemBuilder: (context,index) => GestureDetector(
                // onLongPress: () {
                //   showDialog(
                //       context: context,
                //       builder: (_) => Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //
                //           ],
                //         ),
                //       ));
                // },
                onTap: () {
                  showDialog(barrierColor: Colors.black.withOpacity(0.75),
                      context: context,
                      builder: (_) => SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("created on: ${cubit.allResults[index].time}",
                                    style: GoogleFonts.aBeeZee(
                                      color: Colors.white.withOpacity(0.85),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    )),
                                Gaps.medium_Gap,

                                Text(cubit.allResults[index].result,
                                    style: GoogleFonts.aBeeZee(
                                      color: Colors.white.withOpacity(0.85),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                  child: Container(
                    height: 70,width: 300,

                    decoration: BoxDecoration(
                        color: Colors.green[900],
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Row(
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Container(

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "Result",
                                    style: TextStyle(fontSize: 25, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "${index+1}",
                              style: TextStyle(color: Colors.white54),
                            ),

                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: Text(
                            cubit.allResults[index].time,
                            style: TextStyle(color: Colors.white,fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              separatorBuilder:(context,index) => Gaps.medium_Gap,
              itemCount: results.length);}
          else{return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.menu_rounded, color: Colors.white,size: 100,),
                SizedBox(height: 0,),
                Text(
                  "History is Empty",
                  style: GoogleFonts.aBeeZee(
                    color: Colors.white.withOpacity(0.85),
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                )
              ],
            ),
          );}


        } ,

      ),
    );
  }
}
