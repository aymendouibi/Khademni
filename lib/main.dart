import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memoire/Controller/ServiceController.dart';
import 'package:memoire/constant/firebase.dart';
import 'package:memoire/constant/lang/language.dart';

import 'package:memoire/constant/theme.dart';


import 'Controller/AuthController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
    await GetStorage.init();
     Get.put(ServiceController());
LoadTheme(); 
loadLang(); 

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  
  
  @override
  Widget build(BuildContext context) {
   var value = GetStorage().read('lang');
    
    return GetMaterialApp(
      translations: Language(),
      locale: Locale(value),
      fallbackLocale: Locale('en'),
      theme: light,
      darkTheme: dark,
      debugShowCheckedModeBanner: false,
      home: Center(child: CircularProgressIndicator()),
    );
  }
}
