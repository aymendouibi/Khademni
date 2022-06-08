import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Controller/ServiceController.dart';
import '../../../constant/firebase.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  ServiceController srv = ServiceController();
  CollectionReference service = firebaseFirestore
      .collection('user')
      .doc(auth.currentUser.uid)
      .collection('service');

  /// Variables
  bool uploadComplet = false;
  List<XFile> imageFileList = [];
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


    //var wilaya = firebaseFirestore.collection('user').doc(userID).get();
        return StreamBuilder(
     
          stream:
              FirebaseFirestore.instance.collection('user').doc(userID).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
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
                    labelText: 'Title', hintText: 'title here'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
            
               maxLines: 2,
                controller: _desc,
                decoration: const InputDecoration(label: Text('Descreption')),
              ),
              const SizedBox(
                height: 10,
              ),
               TextFormField(
                 keyboardType: TextInputType.number,
                controller: _price,
                decoration: const InputDecoration(label: Text('price')),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                hint: selectedCategory==null?const Text('select category'):Text(selectedCategory),
                items: category.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              
              ListTile(
                title: Row(
                  children: [
                    const Text("remote"),
                    Radio(
                  value: 'remote',
                  groupValue: type,
                  onChanged: (value) {
                    setState(() {
                      type = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
                  ],
                ),
               
              ),
               ListTile(
                title: Row(
              children: [
                const Text("in person"),
                Radio(
              value: 'in person',
              groupValue: type,
              onChanged: (value) {
                setState(() {
                  type = value;
                });
              },
              activeColor: Colors.green,
                ),
              ],
                ),
                
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    _getFromGallery();
                  },
                  child: Container(
                    height: 100,
                    width: 200,
                    color: Colors.black,
                    child: imageFileList.isEmpty
                        ? Container(
                            color: Colors.white.withOpacity(0.3),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imageFileList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Image.file(File(imageFileList[index].path),
                                  fit: BoxFit.fill);
                            },
                          ),
                   
                  ),
                ),
              ),
             
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    String id = service.doc().id;
                    if (dowurl.isEmpty) {
                      Get.snackbar("upload image", '');
                    } else {
                      try {
                        await service.doc(id).set({
                          'title': _title.text,
                          'desc': _desc.text,
                          'image': dowurl,
                          'userID': userID,
                          'views': views,
                          'id': id,
                          'category':selectedCategory,
                          'price':double.parse(_price.text),
                          'type':type,
                          'wilaya':snapshot.data['wilaya']
                        });
                        Get.snackbar("uploaded", '');
                        _desc.clear();
                        _title.clear();
                        _price.clear();
                        setState(() {
                          imageFileList = [];
                          selectedCategory = null;
                          type=null;
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: const Text('submit')),
            ],
          ),
        ));
            }
          });
  }

  /// Get from gallery
  _getFromGallery() async {
    TaskSnapshot uploadTask;
    List<XFile> pickedFile = await ImagePicker().pickMultiImage(
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile.isNotEmpty) {
      setState(() {
        imageFileList.addAll(pickedFile);
      });

      for (var i = 0; i < imageFileList.length; i++) {
        fileName.add(imageFileList[i].path.split("/").last);

        uploadTask = await FirebaseStorage.instance
            .ref('service/' + fileName[i])
            .putFile(
              File(imageFileList[i].path),
            )
            .whenComplete(() {
          Get.snackbar('uploaded an item', '',
              snackPosition: SnackPosition.BOTTOM);
        });

        String url = await uploadTask.ref.getDownloadURL();

        dowurl.add(url);
      }
    }
  }
}
  /* _getFromGallery() async {
    XFile pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      fileName = imageFile.path.split('/').last;
      var uploadTask =
          await FirebaseStorage.instance.ref('service/' + fileName).putFile(
                imageFile,
              );
              setState(() async{
                dowurl = await (uploadTask).ref.getDownloadURL();
              });
      
    }
  }*/


/**
 * 
 * Scaffold(
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
                    labelText: 'Title', hintText: 'title here'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
            
               maxLines: 2,
                controller: _desc,
                decoration: const InputDecoration(label: Text('Descreption')),
              ),
              const SizedBox(
                height: 10,
              ),
               TextFormField(
                 keyboardType: TextInputType.number,
                controller: _price,
                decoration: const InputDecoration(label: Text('price')),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                hint: selectedCategory==null?const Text('select category'):Text(selectedCategory),
                items: category.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              
              ListTile(
                title: Row(
                  children: [
                    const Text("remote"),
                    Radio(
                  value: 'remote',
                  groupValue: type,
                  onChanged: (value) {
                    setState(() {
                      type = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
                  ],
                ),
               
              ),
               ListTile(
                title: Row(
              children: [
                const Text("in person"),
                Radio(
              value: 'in person',
              groupValue: type,
              onChanged: (value) {
                setState(() {
                  type = value;
                });
              },
              activeColor: Colors.green,
                ),
              ],
                ),
                
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    _getFromGallery();
                  },
                  child: Container(
                    height: 100,
                    width: 200,
                    color: Colors.black,
                    child: imageFileList.isEmpty
                        ? Container(
                            color: Colors.white.withOpacity(0.3),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imageFileList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Image.file(File(imageFileList[index].path),
                                  fit: BoxFit.fill);
                            },
                          ),
                   
                  ),
                ),
              ),
             
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    String id = service.doc().id;
                    if (dowurl.isEmpty) {
                      Get.snackbar("upload image", '');
                    } else {
                      try {
                        await service.doc(id).set({
                          'title': _title.text,
                          'desc': _desc.text,
                          'image': dowurl,
                          'userID': userID,
                          'views': views,
                          'id': id,
                          'category':selectedCategory,
                          'price':double.parse(_price.text),
                          'type':type
                        });
                        Get.snackbar("uploaded", '');
                        _desc.clear();
                        _title.clear();
                        _price.clear();
                        setState(() {
                          imageFileList = [];
                          selectedCategory = null;
                          type=null;
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: const Text('submit')),
            ],
          ),
        ));
 */