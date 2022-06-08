// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memoire/constant/lang/language.dart';

import 'package:memoire/constant/widgets/setting_menu.dart';
import 'package:memoire/view/screens/Seller/seller_navigation.dart';
import 'package:memoire/view/screens/edit_profile.dart';

import '../../constant/firebase.dart';

class MySettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  var userEmail = FirebaseAuth.instance.currentUser.email;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //profile
          InkWell(
            onTap: (){
              Get.to(MyProfile());
            },
            child: SizedBox(
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
                          userEmail,
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
                InkWell(
                  onTap: ChangeTheme,
                  child: Row(
                    children: [
                      SettingMenu(
                          text: 'Dark mode'.tr,
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
                ),
                Divider(
                  color: Color.fromARGB(255, 179, 179, 179),
                  thickness: 1.0,
                ),
                InkWell(
                  onTap: () {
                    Get.defaultDialog(
                        title: "Select Language".tr,
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
                        text: 'Language'.tr,
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
                InkWell(
                  onTap: () {
                    Get.to(SellerNavigation());
                  },
                  child: Row(
                    children: [
                      SettingMenu(
                        function: () {
                          Get.to(SellerNavigation());
                        },
                        text: 'Seller page'.tr,
                        icon: Icons.account_box,
                        color: Colors.blue,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
                Divider(
                  color: Color.fromARGB(255, 179, 179, 179),
                  thickness: 1.0,
                ),
                InkWell(
                  onTap: () {
                    Get.defaultDialog(
                        title: "Contact us by".tr,
                        content: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("aym3ndouibi@gmail.com"),
                                CopyButton(copy: "aym3ndouibi@gmail.com"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("0555584668"),
                                CopyButton(copy: "0555584668"),
                              ],
                            ),
                          ],
                        ));
                  },
                  child: Row(
                    children: [
                      SettingMenu(
                        function: () {},
                        text: 'Contact us'.tr,
                        icon: Icons.phone,
                        color: Colors.green,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios)
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
                      function: () {
                        Get.defaultDialog
                        (
                          title: "Confirm",
                          content: ElevatedButton(onPressed: (){
                          
                           authController.signOut();
                        }, child: Text('Logout')));
                       
                      },
                      text: 'Logout'.tr,
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

class CopyButton extends StatelessWidget {
  @override
  String copy;
  CopyButton({this.copy});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
        Clipboard.setData(ClipboardData(text: copy));
        Get.snackbar('copied to clipboard', '',
            snackPosition: SnackPosition.BOTTOM);
      },
      icon: const Icon(Icons.copy),
    );
  }
}
