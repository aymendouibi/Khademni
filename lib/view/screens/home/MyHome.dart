// ignore: file_names
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoire/view/screens/home/category/CategoryList.dart';
import 'package:memoire/view/screens/home/service_details.dart';
import 'package:memoire/view/screens/wilaya.dart';
import '../../../Controller/ServiceController.dart';
import '../../../constant/firebase.dart';

class MyHome extends StatelessWidget {
  final service = firebaseFirestore.collectionGroup("service");
  MyHome({Key key}) : super(key: key);
  List<String> category = [
    'Graphics & Design',
    'Writing & Translation',
    'Programing & Tech',
    "Business",
    "Video & Animation",
    "Digital Marketing",
    "Handwork",
  ];

    final List<String> wilaya = [ 
"Adrar",
"Chlef",
"Laghouat",
"Oum el-Bouaghi",
"Batna",
"Béjaïa",
"Biskra",
"Béchar",
"Blida",
"Bouira",
"Tamanghasset",
" Tébessa",
"Tlemcen",
"Tiaret",
"Tizi Ouzou",
" Algiers",
" Djelfa",
" Jijel",
" Sétif",
" Saïda",
" Skikda",
" Sidi Bel Abbes",
" Annaba",
" Guelma",
" Constantine",
" Médéa",
" Mostaganem",
" M'Sila",
" Mascara",
" Ouargla",
" Oran",
" El Bayadh",
" Illizi",
" Bordj Bou Arréridj",
" Boumerdès",
" El Taref",
" Tindouf",
" Tissemsilt",
" El Oued",
" Khenchela",
"Souk Ahras",
"Tipasa",
"Mila",
"Aïn Defla",
"Naama",
"Aïn Témouchent",
"Ghardaïa",
"Relizane",];

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_literals_to_create_immutables
    return GetBuilder<ServiceController>(
        builder: (controller) => controller.loading.value
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.red,
              ))
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Text(
                      'Category List'.tr,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: category.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: (){
                              Get.to(CategoryList(),arguments:category[index] );
                            },
                            child: Card(
                              elevation: 5,
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(category[index]),
                              )),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 10,),
                   Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Text(
                      'Wilaya List'.tr,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: wilaya.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: (){
                              Get.to(MyWilaya(),arguments:wilaya[index] );
                            },
                            child: Card(
                              elevation: 5,
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(wilaya[index]),
                              )),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15),
                    child: Text(
                      'Service List'.tr,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: controller.getServiceList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var views = controller.getServiceList[index].views;
                      var id = controller.getServiceList[index].id;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: SizedBox(
                          
                          height: 130,
                          child: InkWell(
                            onTap: () async {
                              Get.to(ServiceDetail(),
                                  arguments: {
                                    'service': controller.getServiceList[index]
                                  },
                                  transition: Transition.cupertino);
                              await firebaseFirestore
                                  .collection('user')
                                  .doc(controller.getServiceList[index].userID)
                                  .collection('service')
                                  .doc(id)
                                  .update({"views": views++});
                            },
                            child: Card(
                              elevation: 4,
                              child: Row(
                                children: [
                                  Image.network(
                                    controller.getServiceList[index].image[0],
                                    fit: BoxFit.fill,
                                    width: Get.width * 0.5,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 15,),
                                      SizedBox(
                                        width: Get.width*0.45,
                                        child: Text(
                                          controller.getServiceList[index].title,
                                          style:
                                              TextStyle(fontSize: Get.height*0.02),
                                              overflow: TextOverflow.ellipsis,
                                               maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      SizedBox(
                                        width: Get.width*0.42,
                                          child: Text(
                                        
                                        controller.getServiceList[index].desc,
                                          style:  TextStyle(fontSize: Get.height*0.015),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: false,
                                      )),
                                      Spacer(),
                                      SizedBox(width: Get.width*0.4,child: Row(children:  [Spacer(),Text(controller.getServiceList[index].price.toString()+" Dzd",)],))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ));
  }
}
