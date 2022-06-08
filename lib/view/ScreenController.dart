import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoire/constant/widgets/logo.dart';

import 'package:memoire/view/screens/home/MyHome.dart';
import 'package:memoire/view/screens/Settings.dart';
import 'package:memoire/view/screens/order/MyOrder.dart';
import 'package:memoire/view/screens/search.dart';



class MyController extends StatefulWidget {
  const MyController({Key key}) : super(key: key);

  @override
  State<MyController> createState() => _MyControllerState();
}

class _MyControllerState extends State<MyController> {
  int _selectedIndex = 0;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: MyLogo(fontSize: 23,),
        actions:  [
          IconButton(icon: Icon(Icons.settings,color: Get.isDarkMode?Colors.white:Colors.black,),onPressed: (){
            setState(() {
              _selectedIndex=3;
                _pageController.animateToPage(3,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
            });
          },)

        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        itemCornerRadius: 15,
        showElevation: true,
        backgroundColor: Colors.transparent,
        selectedIndex: _selectedIndex,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        }),
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.house_sharp),
            title:  Text('Home'.tr),
            activeColor: Theme.of(context).primaryColor,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.search),
            title:  Text('Search'.tr),
            activeColor: Theme.of(context).primaryColor,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.shopping_cart),
            title:  Text('My Orders'.tr),
            activeColor: Theme.of(context).primaryColor,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.settings),
            title:  Text('Settings'.tr),
            activeColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
      body: SizedBox.expand(
        child: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            children: <Widget>[
              MyHome(),
              CloudFirestoreSearch(),
              const MyOrder(),
              MySettings(),
            ],
          ),
        ),
      ),
    );
  }
}
