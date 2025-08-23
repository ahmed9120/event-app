import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../routes/page_routes_name.dart';
import '../services/snackbar_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class FireBaseAuthentication {
  static Future<bool> createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required String userFullName,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      log(credential.user!.uid);
      credential.user!.updateDisplayName(userFullName);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackbarServices.showErrorMessage(e.message ?? "Something went wrong");
      } else if (e.code == 'email-already-in-use') {
        SnackbarServices.showErrorMessage(e.message ?? "Something went wrong");
      } else {
        SnackbarServices.showErrorMessage(e.message ?? "Something went wrong");
      }
      return Future.value(false);
    } catch (e) {
      SnackbarServices.showErrorMessage("Something went wrong");
      return Future.value(false);
    }
  }

  static Future<bool> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackbarServices.showErrorMessage(e.message ?? "Something went wrong");
      } else if (e.code == 'wrong-password') {
        SnackbarServices.showErrorMessage(e.message ?? "Something went wrong");
      } else {
        SnackbarServices.showErrorMessage(e.message ?? "Something went wrong");
      }
      return Future.value(false);
    } catch (e) {
      SnackbarServices.showErrorMessage("Something went wrong");
      return Future.value(false);
    }
  }

  static Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      PageRoutesName.login,
      (route) => false,
    );
  }

  static Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }


  static final GoogleSignIn _googleSignIn= GoogleSignIn.instance;

  static Future<UserCredential?> signInWithGoogle() async {
    try{
      await _googleSignIn.initialize(
          //not working throw .env don't know why yet
          //serverClientId: dotenv.env['SERVER_CLIENT_ID'],
          serverClientId: "597778347580-36uu6q3fc0nnkornte544hsbjqddiqu4.apps.googleusercontent.com",
      );
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
      SnackbarServices.showSuccessMessage("login with google account succesfully");
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }catch(e){
      SnackbarServices.showErrorMessage("Something went wrong $e");
      return null;
    }


  }
}
