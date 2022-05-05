import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userID;
   String content;
   Timestamp email;


  UserModel({
  this.content,
    
  });

  UserModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    userID = documentSnapshot.id;
    content = documentSnapshot["content"];
    email = documentSnapshot["createdOn"];
  }
}