
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_app/Models/user_model.dart';
import 'package:gemini_app/Screens/Authentication/login_screen.dart';
import 'package:gemini_app/Shared/Constants/data.dart';
import 'package:gemini_app/Shared/Core/app_navigator.dart';
import 'package:gemini_app/Shared/Core/app_routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Models/results_model.dart';
import '../../Screens/Home/results.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);

  var nameController = TextEditingController();
  var resultsController = TextEditingController();

  final _firestore = FirebaseFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;

  // Edit Name
  var editEnabled = false;
  List answers=['','','','','','',''];
  final Gemini gemini = Gemini.instance;
  String results="";
  String time="";
  List allResults=[];

  void changeEditMode() {
    editEnabled = !editEnabled;
    emit(ChangeEditState());
  }

  // Get User
  UserModel? user, backupUser;
  Future getUser() async {
    emit(LoadingGetUserState());
    try {
      final document = await _firestore
      .collection("Users")
      .doc(uId)
      .get();
      user = UserModel.fromJson(document.data()!);
      backupUser = user!.clone();
      emit(SuccessGetUserState());
    } catch (e) {
      emit(FailedGetUserState(e.toString()));
      print(e.toString());
    }
  }

  // Update User
  Future<void> updateUser() async {
    try {
      await _firestore
      .collection("Users")
      .doc(uId)
      .update(user!.toJson());

      backupUser = user!.clone();
    } catch (e) {
      user = backupUser!.clone();
      throw "Failed to Update User";
    }
  }

  // Change Name
  void changeName() async {
    if (nameController.text == user!.name) {
      changeEditMode();
      return;
    }
    try {
      emit(LoadingChangeNameState());
      user!.name = nameController.text;
      await updateUser();
      emit(SuccessChangeNameState());
    } catch (e) {
      emit(FailedChangeNameState(e.toString()));
      print(e.toString());
    } finally {
      changeEditMode();
    }
  }



  
  // Pick Image
  Future<XFile?> pickImage() async {
    emit(PickingImageState());
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(SuccessPickingImageState());
    return image;
  }

  // Upload Picture
  void changePicture() async {
    final XFile? image = await pickImage();
    if (image!=null) {
      emit(LoadingChangePictureState());
      try {
      final file = await _firebaseStorage
      .ref()
      .child("Users/$uId/${image.name}")
      .putFile(File(image.path));
      final url = await file.ref.getDownloadURL();
      user!.profilePicture = url;
      updateUser();
      emit(SuccessChangePictureState());
      } catch (e) {
        emit(FailedChangePictureState(e.toString()));
        print(e.toString());
      }
    }
  }

  // Logout
  void logout() async {
    await _auth.signOut();
    uId = null;
    user = null;
    backupUser = null;
    emit(LogoutState());
  }

//ask gemini
  void askgemini(ask,context){

    gemini.text(ask).then((value) async {
      print( value?.output );
      var answer=value?.output;

      results=answer.toString();
      time=DateTime.now().toString();
      final resultModel = ResultsModel(result: results, time: time);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Results(results: results,),));
      try {
        emit(LoadingUploadResultsState());
        await _firestore
            .collection("Users")
            .doc(uId)
            .collection("results").add(resultModel.toJson());
        emit(SuccessUploadResultsState());
      } catch (e) {
        emit(FailedUploadResultsState(e.toString()));
        print(e.toString());
      } finally {
        changeEditMode();
      }



    })
        .catchError((e) => print(e));


  }



  // Get Results
  ResultsModel? result, backupresult;
  Future getresult() async {
    emit(LoadingGetResultsState());
    try {
      final document = await _firestore
          .collection("Users")
          .doc(uId).collection("results")
          .get();
      final Resultss =document.docs.map((result)=>ResultsModel.fromSnapshot(result)).toList();
      print('a777777777777777777777777777777777777777777777777a');
      print(Resultss[1].result);
      print(Resultss.length);
      allResults=Resultss;

      emit(SuccessGetResultsState());
    } catch (e) {
      emit(FailedGetResultsState(e.toString()));
      print(e.toString());
    }
  }
}
//_flutterTts.speak(textt.toString().replaceAll("*", ""));
