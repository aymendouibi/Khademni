
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:memoire/Controller/AuthController.dart';

AuthController authController = AuthController.instance;
//final Future<FirebaseApp> //firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
GoogleSignIn googleSign = GoogleSignIn();


  String image = "https://firebasestorage.googleapis.com/v0/b/memoir-1b3b5.appspot.com/o/profile%2FRectangle.png?alt=media&token=d5f9de1f-c4b8-4576-8500-429fa4c40864";