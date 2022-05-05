import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:memoire/view/screens/MyFavorite.dart';

import 'package:memoire/view/screens/MyHome.dart';
import 'package:memoire/view/screens/Settings.dart';



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
            title: const Text('Home'),
            activeColor: Theme.of(context).primaryColor,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.search),
            title: const Text('Search'),
            activeColor: Theme.of(context).primaryColor,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.favorite),
            title: const Text('Favorite'),
            activeColor: Theme.of(context).primaryColor,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Settings'),
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
              MyHome(),
              const MyFavorite(),
              MySettings(),
            ],
          ),
        ),
      ),
    );
  }
}
