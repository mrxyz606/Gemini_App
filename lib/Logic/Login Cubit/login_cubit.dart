import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/Shared/Constants/data.dart';
import 'package:gemini_app/Shared/Helpers/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  // Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var obscured = true;

  // Obscurity Fuction
  void changeObscurity() {
    obscured = !obscured;
    emit(ChangeObscurityState());
  }

  // Log in with e-mail and password
  Future<void> login() async {
    emit(LoadingLoginState());
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      bool saved = await saveuId(userCredential.user!);
      if (!saved) {
        throw "uId not saved";
      }
      emit(SuccessLoginState());
    } on FirebaseAuthException catch (e) {
      emit(FailedLoginState(e.code));
    }
  }

  // Save uId
  Future<bool> saveuId(User user) async {
    uId = user.uid;
    return await CacheHelper.saveData("uId", user.uid);
  }
}
