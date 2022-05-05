// ignore: file_names
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/ServiceController.dart';
import '../../constant/firebase.dart';

class MyHome extends StatelessWidget {
  final service = firebaseFirestore.collectionGroup("service");
  MyHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorite = firebaseFirestore
        .collection('user')
        .doc(auth.currentUser.uid)
        .collection('favorite');

    // ignore: prefer_const_literals_to_create_immutables
    return GetBuilder<ServiceController>(
        builder: (controller) => controller.loading.value
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.red,
              ))
            : ListView.builder(
                itemCount: controller.getServiceList.length,
                itemBuilder: (BuildContext context, int index) {
                  var views = controller.getServiceList[index].views;
                  var id = controller.getServiceList[index].id;
                  return SizedBox(
                    height: 120,
                    child: InkWell(
                      onTap: () async {
                      await firebaseFirestore
        .collection('user')
        .doc(controller.getServiceList[index].userID)
        .collection('service').doc(id).update({"views":views++});
   

                    
                      },
                      child: Card(
                        child: Row(
                          children: [
                            Image.network(
                                controller.getServiceList[index].image[0]),
                            Text(controller.getServiceList[index].title),
                            Spacer(),
                            IconButton(
                                onPressed: () async {
                                  await favorite.add({
                                    'title':
                                        controller.getServiceList[index].title,
                                    'image': controller
                                        .getServiceList[index].image[0],
                                    'desc':
                                        controller.getServiceList[index].desc,
                                    'userID':
                                        controller.getServiceList[index].userID,
                                  });
                                },
                                icon: Icon(Icons.favorite))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
