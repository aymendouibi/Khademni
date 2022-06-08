import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoire/view/screens/Seller/active_order.dart';
import 'package:memoire/view/screens/Seller/addService.dart';
import 'package:memoire/view/screens/Seller/seller_service.dart';

class SellerNavigation extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red,),
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: Column(
            children:  [
           InkWell(
             onTap: (){Get.to(MyServiceList());},
             child: const Card(
               elevation: 2,
               child: Padding(
               padding: EdgeInsets.all(8.0),
               child: ListTile(title: Text('my services'),),
             )),
           ), 
           InkWell(
             
             onTap: (){
               Get.to(MyPage());
             },
             child: const Card(
               elevation: 2,
               child: Padding(
               padding: EdgeInsets.all(8.0),
               child: ListTile(title: Text('Add a new service'),),
             )),
           ),
           InkWell(
             
             onTap: (){
               Get.to(ActiveOrder());
             },
             child: const Card(
               elevation: 2,
               child: Padding(
               padding: EdgeInsets.all(8.0),
               child: ListTile(title: Text('Active Order'),),
             )),
           )
            ],
          ),
        ),
      ),
    );
  }
}