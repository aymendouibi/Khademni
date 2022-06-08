import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/firebase.dart';
import '../../ScreenController.dart';

class OrderDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red),
      body: FutureBuilder(
        future: firebaseFirestore.collection('user').doc(data['seller']).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Timestamp date = data['date'];
          if (snapshot.hasData) {
            return SafeArea(
              child: SizedBox(
                height: Get.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 200,
                        child: Carousel(
                          animationCurve: Curves.linear,
                          dotBgColor: Colors.transparent,
                          autoplay: false,
                          images: data['image'].map<Widget>((i) {
                            return SizedBox(
                                width: Get.width,
                                child: Image.network(
                                  i,
                                  fit: BoxFit.fill,
                                ));
                          }).toList(),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                  title: "Seller Profile",
                                  content: Column(
                                    children: [
                                      Image.network(
                                        snapshot.data['image_url'],
                                        width: Get.width * 0.35,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(snapshot.data['name']),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text("Job: " + snapshot.data['job']),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text("Descreption: " +
                                          snapshot.data['desc']),
                                    ],
                                  ));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        snapshot.data['image_url']),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(snapshot.data['name']),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            data['title'],
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            data['desc'],
                            style: const TextStyle(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Order Time: " + date.toDate().toString(),
                            style: const TextStyle(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Buyer Details: " + data['detail'],
                            style: const TextStyle(),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Center(
                        child: ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'confirm order completed ?',
                                  content: ElevatedButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(data['client'])
                                            .collection('order')
                                            .doc(data['order_id'])
                                            .delete();
                                            Get.snackbar("Thanks for your order", "",snackPosition: SnackPosition.BOTTOM);
                                            Get.to(const MyController());
                                      },
                                      child: const Text('confirm')));
                            },
                            child: const Text('Order Completed'))),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.redAccent,
            ));
          }
        },
      ),
    );
  }
}
