import 'package:flutter/material.dart';
import 'package:flutter_module/screens/profile_/profile_screen.dart';
import 'package:flutter_module/screens/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> screens = [
    SearchStockScreen.build(),
    ProfileScreen.build(),
  ];

  List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavBarItems,
        currentIndex: currentIndex,
        onTap: onTabTapped,
      ),
    );
  }
}
