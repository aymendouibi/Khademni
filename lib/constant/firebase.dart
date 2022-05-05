
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:memoire/Controller/AuthController.dart';

AuthController authController = AuthController.instance;
//final Future<FirebaseApp> //firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
GoogleSignIn googleSign = GoogleSignIn();


  String image = "https://firebasestorage.googleapis.com/v0/b/memoir-1b3b5.appspot.com/o/profil.png?alt=media&token=be4b3494-b118-4790-bc20-fcf20b935c17";