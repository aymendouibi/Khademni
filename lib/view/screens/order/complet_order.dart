import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_date_picker.dart';
import 'package:get/get.dart';

import '../../../constant/firebase.dart';

class MyOrder extends StatefulWidget {
  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
   CollectionReference order = firebaseFirestore
      .collection('user')
      .doc(auth.currentUser.uid)
      .collection('order');
    DateTime date = DateTime.now();
  DateTime first = DateTime(2022, 05, 06);
  DateTime last = DateTime(2022, 10, 06);
  @override
  Widget build(BuildContext context) {
    var service = Get.arguments;
    TextEditingController details = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Colors.red),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              'Complete order',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                showMaterialDatePicker(
                  title: "Order date",
                  buttonTextColor: Colors.red,
                  firstDate: first,
                  lastDate: last,
                  context: context,
                  selectedDate: date,
                  onChanged: (value) => setState(() => date = value),
                );
              },
              child: Row(
                children: const [
                  Text('Select a date: '),
                  Icon(Icons.date_range),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text('Provide order Details'),
            TextFormField(
              controller: details,
              maxLines: 3,
              decoration:
                  const InputDecoration(label: Text('provide Order details: ')),
            ),
            const Spacer(),
            Text(
              "order: " + service.title,
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "price: " + service.price.toString() + " Dzd",
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                                          String id = order.doc().id;

                    order.doc(id).
                          set({
                        'title': service.title,
                        'price': service.price,
                        'image': service.image,
                        'client': FirebaseAuth.instance.currentUser.uid,
                        'id': service.id,
                        'date': date,
                        'seller': service.userID,
                        'category': service.category,
                        'desc': service.desc,
                        'detail': details.text,
                        'order_id':id,
                      });
                      Get.back();
                    },
                    child: const Text('Submit Order')))
          ],
        ),
      ),
    );
  }
}
