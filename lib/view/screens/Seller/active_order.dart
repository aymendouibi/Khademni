import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoire/constant/firebase.dart';
import 'package:memoire/view/screens/Seller/active_order_details.dart';


class ActiveOrder extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser.uid;
        var size = MediaQuery.of(context).size;
    var order = firebaseFirestore.collectionGroup('order').snapshots();
    return Scaffold(
      appBar:AppBar(backgroundColor: Colors.red,),
      body: StreamBuilder(
        stream: order,
        initialData: order,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ));
        } else {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var data = snapshot.data.docs[index];
            return  data['seller'] == user?
               InkWell(
                onTap: (){Get.to(ActiveOrderDetail(),arguments: data);},
                child: SizedBox(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Get.width * 0.4,
                            child: Text(
                              data['title'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(fontSize: Get.height * 0.02),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * 0.4,
                              child: Text(
                                data['desc'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(fontSize: Get.height * 0.015),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(data['price'].toString() + " Dzd")
                        ],
                      ),
                    ],
                  )),
                ),
              ):SizedBox();
            },
          );
        }
        },
      ),
    );
  }
}