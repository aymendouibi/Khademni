// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memoire/constant/lang/language.dart';

import 'package:memoire/constant/widgets/setting_menu.dart';
import 'package:memoire/view/screens/Seller/addService.dart';

import '../../constant/firebase.dart';

class MySettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Account'.tr,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),

          //profile
          SizedBox(
            height: 120,
            child: Card(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/profil.png',
                      height: 90,
                      width: 100,
                    ),
                  ),
                  SizedBox(
                    width: 15,  
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "User 1",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        "Edit Profil",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_sharp),
                ],
              ),
            ),
          ),
          //dark mode
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Settings'.tr,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(
                  children: [
                    SettingMenu(
                        text: 'Dark mode',
                        icon: Icons.dark_mode,
                        color: Colors.purple,
                        function: () {
                          ChangeTheme();
                        }),
                    Spacer(),
                    Switch(
                        activeColor: Colors.purple,
                        value: Get.isDarkMode,
                        onChanged: (value) {
                          ChangeTheme();
                        })
                  ],
                ),
                Divider(
                  color: Color.fromARGB(255, 179, 179, 179),
                  thickness: 1.0,
                ),
                InkWell(
                  onTap: () {
                    Get.defaultDialog(
                        title: "Select Language",
                        content: Column(
                          children: [
                            InkWell(
                              child: Text('English'),
                              onTap: () {
                                updateLanguage('en');
                                Get.back();
                              },
                            ),
                            Divider(
                              color: Color.fromARGB(255, 110, 110, 110),
                            ),
                            InkWell(
                              child: Text('French'),
                              onTap: () {
                                updateLanguage('fr');
                                Get.back();
                              },
                            ),
                            Divider(
                              color: Color.fromARGB(255, 110, 110, 110),
                              thickness: 1.0,
                            ),
                            InkWell(
                              child: Text('Arabic'),
                              onTap: () {
                                updateLanguage('ar');
                                Get.back();
                              },
                            ),
                          ],
                        ));
                  },
                  child: Row(
                    children: [
                      SettingMenu(
                        text: 'Language',
                        icon: Icons.room_rounded,
                        color: Colors.orange,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
                Divider(
                  color: Color.fromARGB(255, 179, 179, 179),
                  thickness: 1.0,
                ),
                Row(
                  children: [
                    SettingMenu(
                      function: (){Get.to(MyPage());},
                      text: 'Seller page',
                      icon: Icons.account_box,
                      color: Colors.blue,
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                Divider(
                  color: Color.fromARGB(255, 179, 179, 179),
                  thickness: 1.0,
                ),
                Row(
                  children: [
                    SettingMenu(
                      function: () {},
                      text: 'Contact us',
                      icon: Icons.phone,
                      color: Colors.green,
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                Divider(
                  color: Color.fromARGB(255, 179, 179, 179),
                  thickness: 1.0,
                ),
                Row(
                  children: [
                    SettingMenu(
                      function: () {
                        authController.signOut();
                      },
                      text: 'Logout',
                      icon: Icons.logout,
                      color: Colors.red,
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

ChangeTheme() {
  if (Get.isDarkMode) {
    Get.changeThemeMode(ThemeMode.light);
    GetStorage().write('theme', 'light');
  }

  if (Get.isDarkMode == false) {
    Get.changeThemeMode(ThemeMode.dark);
    GetStorage().write('theme', 'dark');
  }
}
