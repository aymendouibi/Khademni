

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var fileName,imageFile,dowurl;
  TextEditingController name = TextEditingController();

  TextEditingController desc = TextEditingController();

  TextEditingController job = TextEditingController();
    TextEditingController number = TextEditingController();
    String selectedWilaya;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
              resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Colors.red),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
   
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
        children: [
            TextFormField(
              controller: name,
             decoration: const InputDecoration(label: Text('name')),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: number,
             decoration: const InputDecoration(label: Text('Number')),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 2,
              controller: desc,
              decoration: const InputDecoration(label: Text('Descreption')),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: job,
              decoration: const InputDecoration(label: Text('What do you Work?')),
            ),
            const SizedBox(height: 20,),
            const SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                hint: selectedWilaya==null?const Text('select category'):Text(selectedWilaya),
                items: wilaya.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedWilaya = value;
                  });
                },
              ),
           Center(
                child: InkWell(
                  onTap: () async {
                    _getFromGallery();
                  },
                  child: imageFile==null
                      ? SizedBox(
                          height: 150,
                        width: 150,
                        child:  CircleAvatar(
                          backgroundColor: const Color.fromARGB(255, 36, 36, 36),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('add profile image',style: TextStyle(color: Colors.white),),
                              Icon(Icons.add,color: Colors.white,size: Get.height*0.07,),
                            ],
                          ),
                        ),
                      )
                      : SizedBox(
                        height: 150,
                        width: 150,
                        child: CircleAvatar(
                          backgroundImage: FileImage(File(imageFile.path),
                                    ),
                        ),
                      ),
                ),
              ),
           const Spacer(),
           ElevatedButton(onPressed: (){
             FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser.uid).update({
               'name':name.text,
              'number':number.text,
              'desc':desc.text,
              'job':job.text,
              'image_url':dowurl,
'wilaya':selectedWilaya
             }).whenComplete(() {
               Get.snackbar('updated', '',snackPosition:SnackPosition.BOTTOM);
               name.clear();
               number.clear();
               desc.clear();
               job.clear();
               setState(() {
                 dowurl=null;
                 imageFile=null;
               });
             });
           }, child: const Text('Edit'))

        ],
      ),
          );
        },
      ),
    );
  }

   _getFromGallery() async {
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
              ).whenComplete(() => Get.snackbar('uploaded image', ""));
              setState(() async{
                dowurl = await (uploadTask).ref.getDownloadURL();
              });
      
    }
  }
}
