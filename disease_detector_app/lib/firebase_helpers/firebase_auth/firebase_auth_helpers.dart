// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../config/constants.dart';
import '../../model/user_model/user_model.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context, rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context, rootNavigator: true).pop();
      showMessage(error.code.toString());
      return false;
    }
  }

  Future<bool> siginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      UserCredential result = await _auth.signInWithCredential(authCredential);

      User? userModel = result.user;

      if (userModel != null) {
        UserModel user = UserModel(
            id: userModel.uid,
            name: userModel.displayName,
            email: userModel.email,
            profileImg: userModel.photoURL);
        await _firestore.collection("users").doc(user.id).set(user.toJson());
      }
      Navigator.of(context, rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context, rootNavigator: true).pop();
      showMessage(error.code.toString());
      return false;
    }
  }

  Future<bool> signUp(
      String name, String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          name: name,
          email: email,
          profileImg: "");

      _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context, rootNavigator: true).pop();
      showMessage(error.code.toString());
      return false;
    }
  }

  void signOut() async {
    print("====== Sign Out Email ======");
    await _auth.signOut();
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> handleSignOut() async {
    print("====== Sign Out Gmail ======");
    googleSignIn.signOut();
  }

  // void signOutGoogle() async {
  //   await googleSignIn.signOut();
  // }

  Future<bool> changePassword(String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      _auth.currentUser!.updatePassword(password);
      // UserCredential userCredential = await _auth
      //     .createUserWithEmailAndPassword(email: email, password: password);
      // UserModel userModel = UserModel(
      //     id: userCredential.user!.uid, name: name, email: email, image: null);

      // _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      showMessage("Password Changed");
      Navigator.of(context).pop();

      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context, rootNavigator: true).pop();
      showMessage(error.code.toString());
      return false;
    }
  }
}
