import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CategoryDetail.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String category = Get.arguments;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red,title: Text(category),),
      body: StreamBuilder(
          initialData:
              FirebaseFirestore.instance.collectionGroup("service").snapshots(),
          stream:
              FirebaseFirestore.instance.collectionGroup("service").snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data.docs[index];
                    return data['category']==category?
                    InkWell(
                      onTap: (){
                        Get.to(CategoryDetail(),arguments: data);
                      },
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
                            SizedBox(
                              child: Text(
                                data['title'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              width: Get.width * 0.3,
                            ),
                          ],
                        )),
                      ),
                    ):const SizedBox();
                  });
            }
          }),
    );
  }
}
