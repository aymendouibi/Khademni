import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoire/constant/firebase.dart';
import 'package:memoire/view/screens/order/OrderDetail.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final favorite = firebaseFirestore
        .collection('user')
        .doc(auth.currentUser.uid)
        .collection('order');

    return StreamBuilder(
      stream: favorite.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("My Orders".tr,style: Theme.of(context).textTheme.headline1,),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data.docs[index];
                    return InkWell(
                      onTap: (){Get.to(OrderDetail(),arguments: data);},
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
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
