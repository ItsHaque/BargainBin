import 'package:bargain_bin/screens/home_screen.dart';
import 'package:bargain_bin/screens/profile.dart';
import 'package:bargain_bin/screens/search.dart';
import 'package:bargain_bin/screens/settings.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget{
  const Navigation({super.key});
  
  @override
  State<Navigation> createState()=> _NavigationState();
}

class _NavigationState extends State<Navigation>{

  final screens=[
    const HomeScreen(),
    const Search(),
    const Profile(),
    const Settings(),
  ];
  int _selectedScreen=0;
  void _changeScreen(int index){
    setState(() {
      _selectedScreen=index;
    });
  }


  @override
  Widget build(Object context) {
    return Scaffold(
      
      body: screens[_selectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changeScreen,
        selectedItemColor: const Color(0xFF607D8B),
        unselectedItemColor: const Color(0xFF000000),
        showUnselectedLabels: true,
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
        ]
        ),
    );
  }
}
