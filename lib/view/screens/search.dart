import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/ServiceController.dart';
import 'home/service_details.dart';

class CloudFirestoreSearch extends StatefulWidget {
  @override
  _CloudFirestoreSearchState createState() => _CloudFirestoreSearchState();
}

class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {
  String name = "";
  var searched = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(
        builder: (controller) => controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.red,
              ))
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.red,
                        decoration:  InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.red),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.red,
                            ),
                            hintText: "Search".tr
                            ),
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });

                          void search(String query) {
                            final suggestion =
                                controller.getServiceList.where((e) {
                              final searchedtitle = e.title.toLowerCase();
                              final input = query.toLowerCase();
                              return searchedtitle.contains(input);
                            }).toList();
                            setState(() {
                              searched = suggestion;
                            });
                          }

                          search(name);
                        },
                      ),
                    ),
                  ],
                ),
                body: searched.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "What Are you intersted in ?".tr,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      )
                    : ListView.builder(
                        itemCount: searched.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 250,
                            height: 120,
                            child: InkWell(
                              onTap: () async {
                                Get.to(ServiceDetail(),
                                    arguments: {'service': searched[index]},
                                    transition: Transition.cupertino);
                              },
                              child: Card(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: Get.width * 0.45,
                                      child: Image.network(
                                        searched[index].image[0],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.4,
                                          child: Text(
                                            searched[index].title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: Get.height * 0.02),
                                          ),
                                        ),
                                        SizedBox(
                                            width: Get.width * 0.4,
                                            child: Text(
                                              searched[index].desc,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.015),
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(searched[index].price.toString() +
                                            " Dzd")
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )));
  }
}
