import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gemini_app/Models/user_model.dart';
import 'package:gemini_app/Shared/Constants/data.dart';
import 'package:gemini_app/Shared/Helpers/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Controllers
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var obscured = true;

  //Change Obscurity
  void changeObscurity() {
    obscured = !obscured;
    emit(ChangeObscurityState());
  }

  // Create User in FireStore
  Future<void> createUser() async {
   await getlocation();
    final user = await registerUser();
    final userModel = UserModel(
        name: nameController.text,
        email: emailController.text,
        profilePicture:
            "https://wallpapers-clan.com/wp-content/uploads/2023/01/anime-aesthetic-boy-pfp-1.jpg",
        location: location
    );
    emit(LoadingCreateUserState());
    try {
      await _firestore
          .collection("Users")
          .doc(user!.uid)
          .set(userModel.toJson());

      bool saved = await saveuId(user);
      if (!saved) {
        throw "uId not Saved";
      }
      emit(SuccessCreateUserState());
    } catch (e) {
      emit(FailedCreateUserState(e.toString()));
    }
  }

  // Register User
  Future<User?> registerUser() async {
    try {
      emit(LoadingRegisterState());
      final UserCredential userCredentials =
          await _auth.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      return userCredentials.user;
    } on FirebaseAuthException catch (e) {
      emit(FailedRegisterState(e.code));
    }
    return null;
  }

  // Save uId
  Future<bool> saveuId(User user) async {
    uId = user.uid;
    return await CacheHelper.saveData("uId", user.uid);
  }
  var location;
// get location
  Future<void> getlocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.high);

    var placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    location = placemarks.reversed.last.subAdministrativeArea.toString() +
        " " +
        placemarks.reversed.last.administrativeArea.toString() +
        " " +
        placemarks.reversed.last.country.toString();

  }

}


