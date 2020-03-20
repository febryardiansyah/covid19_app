import 'package:covid19/screens/by_country.dart';
import 'package:covid19/screens/home_screen.dart';
import 'package:covid19/screens/kasus_indonesia.dart';
import 'package:flutter/material.dart';

class BotomNavBar extends StatefulWidget {
  @override
  _BotomNavBarState createState() => _BotomNavBarState();
}

class _BotomNavBarState extends State<BotomNavBar> {
  int _currentIndex = 0;
  List<Widget>_children =[
    Home(),
    ByCountry(),
    KasusIndonesia(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        backgroundColor: Color(0xFFECF0F3),
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_drop_down_circle),
            title: Text('Global')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            title: Text('Negara')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.personal_video),
            title: Text('Indonesia')
          )
        ],
      ),
    );
  }
  void onTap(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}
