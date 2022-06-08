import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoire/view/screens/Seller/editService.dart';

class MyServiceList extends StatelessWidget {
  var service = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("service")
      .snapshots();
  var serviceS = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("service");
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red),
      body: StreamBuilder(
          stream: service,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data.docs[index];
                    return SizedBox(
                      width: size.width,
                      height: 120,
                      child: Card(
                          child: Row(
                        children: [
                          Image.network(
                            data['image'][0],
                            width: size.width * 0.5,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(child: Text(data['title'],overflow: TextOverflow.ellipsis,maxLines: 2,),width: Get.width*0.3,),
                          const Spacer(),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    serviceS.doc(data['id']).delete();
                                  },
                                  icon: const Icon(Icons.delete,color: Colors.red,)),
                              IconButton(
                                  onPressed: () {Get.to(EditService(),arguments: data['id']);},
                                  icon: const Icon(Icons.edit,color: Colors.blue,)),
                            ],
                          ),
                        ],
                      )),
                    );
                  });
            }
          }),
    );
  }
}
