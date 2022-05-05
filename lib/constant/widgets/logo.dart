

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLogo extends StatelessWidget {
final double fontSize;

   // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
   MyLogo({ this.fontSize});

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return RichText(
  text: TextSpan(
    // Note: Styles for TextSpans must be explicitly defined.
    // Child text spans will inherit styles from parent
    style: TextStyle(
    fontWeight:FontWeight.bold,
    color: Get.isDarkMode? Colors.white:Colors.black,
    
    ),
    children: [
    TextSpan(text: 'K',style: TextStyle(color: color,fontSize: fontSize + 2,fontFamily: 'BS')),
    TextSpan(text: 'hademni', style: TextStyle(fontSize: fontSize)),
    
    ],
  ),
 );
  }
}