import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../Controller/ServiceController.dart';
import '../../../constant/firebase.dart';

class EditService extends StatefulWidget {
  @override
  _EditServiceState createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  var id = Get.arguments;
  ServiceController srv = ServiceController();
  CollectionReference service = firebaseFirestore
      .collection('user')
      .doc(auth.currentUser.uid)
      .collection('service');

  /// Variables
  bool uploadComplet = false;

List<String> fileName = []; 
  String url;
  List<String> dowurl = [];

  int views = 0;

  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  final TextEditingController _price = TextEditingController();

  final String userID = auth.currentUser.uid;

  final List<String> category = [ 'Graphics & Design',
    'Writing & Translation',
    'Programing & Tech',
    "Business",
    "Video & Animation",
    "Digital Marketing"];
   String selectedCategory;

  String type ;

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(backgroundColor: Colors.red,),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(
                    labelText: 'new title', hintText: 'new title here'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _desc,
                decoration: const InputDecoration(label: Text('new Descreption')),
              ),
              const SizedBox(
                height: 10,
              ),
               TextFormField(
                 keyboardType: TextInputType.number,
                controller: _price,
                decoration: const InputDecoration(label: Text('new price')),
              ),
              const SizedBox(
                height: 10,
              ),
              
              
              
           
           
             
            
             
             
              ElevatedButton(
                  onPressed: () async {
                   if(_title.text =='' ||_desc.text==''|| _price.text==null)
                  {
                    Get.snackbar('update all field', '',snackPosition: SnackPosition.BOTTOM);
                  }
                    else {try {
                        await service.doc(id).update({
                          'title': _title.text,
                          'desc': _desc.text, 
                          
                          'price':double.parse(_price.text),
                        });
                        Get.snackbar("updated", '');
                        _desc.clear();
                        _title.clear();
                        _price.clear();
                        setState(() {
                       
                          selectedCategory = null;
                          
                        });
                      } catch (e) {
                        Get.snackbar(e.toString(), '',snackPosition: SnackPosition.BOTTOM);
                      }}  
                    
                  },
                  child: const Text('edit')),
            ],
          ),
        ));
  }

 
}
  


