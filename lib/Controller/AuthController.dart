// ignore: file_names
// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memoire/constant/firebase.dart';
import 'package:memoire/view/ScreenController.dart';

import '../view/auth/MyRegister.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rx<User> firebaseUser;

  Rx<GoogleSignInAccount> googleSignInAccount;

  @override
  void onReady() {
    super.onReady();
    // auth is comning from the constants.dart file but it is basically FirebaseAuth.instance. 
    // Since we have to use that many times I just made a constant file and declared there
    
    firebaseUser = Rx<User>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount>(googleSign.currentUser);
      
      
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    
    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User user) {
    if (user == null) {
        
      // if the user is not found then the user is navigated to the MyRegister Screen
      Get.offAll(() => const MyRegister());
        
    } else {
        
      // if the user exists and logged in the the user is navigated to the Home Screen
      // ignore: prefer_const_constructors
      Get.offAll(() => SafeArea(child: MyController()));
        
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      // if the user is not found then the user is navigated to the MyRegister Screen
      Get.offAll(() => const MyRegister());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => SafeArea(child: MyController()));
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth
            .signInWithCredential(credential)
            .catchError((onErr) => print(onErr));
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
  }

  void register(String email, password,name) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);  
          FirebaseFirestore.instance
            .collection('user')
            .doc(auth.currentUser.uid)
            .set({
          'name': name,
          'email': email,
          'password': password,
          'id': auth.currentUser.uid,
          'image_url': image,
        });    
    } catch (e) {
      Get.snackbar(e.printError(),"");
      print(e.toString());
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(e.toString(),"");
      print(e.toString());
    }
  }

  void signOut() async {
    await auth.signOut();
  }
}