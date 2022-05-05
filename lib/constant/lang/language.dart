import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memoire/constant/lang/ar.dart';
import 'package:memoire/constant/lang/eng_us.dart';
import 'package:memoire/constant/lang/fr_fr.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'fr': fr,
        'ar': ar,
      };
}

loadLang(){
var lang = GetStorage().read('lang',);
if (lang == null){
  GetStorage().write('lang', 'en');
}

}

updateLanguage(value){
Get.updateLocale(Locale(value));
          GetStorage().write('lang', value);
}