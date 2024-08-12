import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gemini_app/Screens/Authentication/login_screen.dart';
import 'package:gemini_app/Screens/learn%20more/learn_more.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Shared/Constants/dimenstions.dart';
import '../../Shared/Core/app_navigator.dart';
import '../../Shared/Core/app_routes.dart';
import '../../Shared/Core/assets_paths.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  var location;

  Future<void> getlocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.high);

    var placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      location = placemarks.reversed.last.subAdministrativeArea.toString() +
          " " +
          placemarks.reversed.last.administrativeArea.toString() +
          " " +
          placemarks.reversed.last.country.toString();
    });
  }

  @override
  void initState() {
    getlocation();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AssetsPaths.backgroundImage3,
            height: screen_height,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.none,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Padding(
              padding: const EdgeInsets.only(top: 38.0, left: 8.0),
              child: Column(
                children: [
                  // Row for Current Location and CircleAvatar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Current Location',
                              style: GoogleFonts.aBeeZee(
                                color: Colors.white.withOpacity(0.85),
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
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
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      location == null
                          ? Text(
                              "location",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            )
                          : Text(
                              location.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Spacer to push the button section to the center
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              AppNavigator.push(AppRoutes.learnMore, context);

                              print('Learn More of Environment pressed');
                            },
                            child: Text(
                              'Learn More of Environment',
                              style: GoogleFonts.aBeeZee(
                                color: Colors.black.withOpacity(0.85),
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              print(
                                'Begin Your New Life pressed',
                              );
                              AppNavigator.push(
                                  AppRoutes.firstScreen(), context);
                            },
                            child: Text('Begin Your New Life',
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.black.withOpacity(0.85),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                )),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
