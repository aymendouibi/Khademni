import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:memoire/view/screens/order/complet_order.dart';
import '../../../constant/firebase.dart';

class ServiceDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Get.arguments['service'];

    return Scaffold(
      body: FutureBuilder(
        future: firebaseFirestore.collection('user').doc(service.userID).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          ContactUs() {
            Get.defaultDialog(
                title: "Contact seller via",
                content: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(snapshot.data['email']),
                        CopyButton(copy: snapshot.data['email']),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(snapshot.data['number'].toString()),
                        CopyButton(copy: snapshot.data['number'].toString()),
                      ],
                    ),
                  ],
                ));
          }

          if (snapshot.hasData) {
            return SafeArea(
              child: SizedBox(
                height: Get.height,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          SizedBox(
                              height: 200,
                              child: Carousel(
                                animationCurve: Curves.linear,
                                dotBgColor: Colors.transparent,
                                autoplay: false,
                                images: service.image.map<Widget>((i) {
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: InkWell(
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
                                              Text("Job: " +
                                                  snapshot.data['job']),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text("Descreption: " +
                                                  snapshot.data['desc']),
                                            ],
                                          ));
                                    },
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
                                  service.title,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: 'category: ',
                                      style: TextStyle(
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black)),
                                  TextSpan(
                                      text: service.category,
                                      style: const TextStyle(color: Colors.red))
                                ])),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Type: ',
                                      style: TextStyle(
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black)),
                                  TextSpan(
                                      text: service.type,
                                      style: const TextStyle(color: Colors.red))
                                ])),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Price: '.tr,
                                      style: TextStyle(
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black)),
                                  TextSpan(
                                      text: service.price.toString() + " Dzd",
                                      style: const TextStyle(color: Colors.red))
                                ])),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Views: '.tr,
                                      style: TextStyle(
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black)),
                                  TextSpan(
                                      text: service.views.toString(),
                                      style: const TextStyle(color: Colors.red))
                                ])),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Details',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                Text(
                                  service.desc,
                                  style: const TextStyle(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width * .4,
                            child: ElevatedButton(
                                onPressed: () {
                                  ContactUs();
                                },
                                child: const Text('contact seller')),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: Get.width * 0.4,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.to(MyOrder(),arguments: service);
                                },
                                child: const Text('Make an Order')),
                          ),
                        ],
                      ),
                    ),
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

/// */

class CopyButton extends StatelessWidget {
  @override
  String copy;
  CopyButton({this.copy});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
        Clipboard.setData(ClipboardData(text: copy));
        Get.snackbar('copied to clipboard', '',
            snackPosition: SnackPosition.BOTTOM);
      },
      icon: const Icon(Icons.copy),
    );
  }
}
