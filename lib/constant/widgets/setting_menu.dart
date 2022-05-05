import 'dart:ffi';

import 'package:flutter/material.dart';

class SettingMenu extends StatelessWidget {
  IconData icon;
  Color color;
  String text;
  Function function;
   

  SettingMenu({ Key key,this.color,this.icon,this.text,this.function, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: InkWell(
        onTap: function,
        child: Row(children: [
          CircleAvatar(child: Icon(icon,color: color),backgroundColor: color.withOpacity(0.23),),
          SizedBox(width: 10,),
          Text(text),

        ],),
      ),
    );
  }
}